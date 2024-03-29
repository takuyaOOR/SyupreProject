//
//  FavoriteView.swift
//  MusicShareApp
//
//  Created by yanasetakuya on 2020/11/26.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
import AVKit

struct FavoriteView: View {
    
    //ユーザーIDとユーザーネームをUserdefaultから取得
    var userID = UserDefaults.standard.object(forKey: "userID")
    var userName = UserDefaults.standard.object(forKey: "userName")
    
    //RealtimeDatabaseリファレンス
    @State var ref = Database.database().reference()
    
    @ObservedObject var getFavMusic = GetFavMusic()
    
    //音楽再生用変数
    @State var player:AVPlayer?
    
    //シェアシート表示用変数
    @State private var showActivityView: Bool = false
    
    //背景透過用コンストラクタ
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack(spacing: 20) {
                Spacer()

                Text("Favorite")
                    .font(.title)
                    .fontWeight(.heavy)

                Spacer()
            }

            ScrollView(.vertical, showsIndicators: false){

                ForEach(getFavMusic.favMusicData){music in
                    HStack {

                        //画像表示
                        WebImage(url: URL(string: music.imageUrl))
                            .resizable()
                            .frame(width: 130, height: 130, alignment: .center)
                            .cornerRadius(12)

                        //音楽情報表示
                        VStack {
                            
                            Text(music.musicName)
                                .font(.system(size: 15))
                                .foregroundColor(Color("Color1"))
                                .font(.headline)
                                .fontWeight(.bold)
                                .lineLimit(3)
                                .multilineTextAlignment(.center)

                            Text(music.artistName)
                                .font(.system(size: 12))
                                .foregroundColor(Color("Color1"))
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .lineLimit(3)
                                .multilineTextAlignment(.center)


                            HStack {
                                Spacer()

                                //再生ボタン
                                Button(action: {

                                    //音楽を再生する
                                    playMusic(url: music.previewUrl)

                                }) {

                                    Image(systemName: "play")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(Color.green)
                                        .padding(12)
                                        .background(Color("Color1"))
                                        .clipShape(Circle())

                                }

                                //シェアボタン
                                Button(action: {

                                    actionSheet(musicName: music.musicName,
                                                artistName: music.artistName,
                                                previewUrl: music.previewUrl,
                                                imageUrl: music.imageUrl)

                                }) {
                                    Image(systemName: "square.and.arrow.up")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(Color.blue)
                                        .padding(12)
                                        .background(Color("Color1"))
                                        .clipShape(Circle())
                                }

                                //お気に入り削除ボタン
                                Button(action: {

                                    //お気に入りリストから削除
                                    getFavMusic.deleteFavoriteMusic(ref: ref, userID: userID as! String, trackID: music.trackID)
                                    //お気に入りリストを初期化
                                    getFavMusic.favMusicData.removeAll()
                                    
                                }) {

                                    Image(systemName: "heart.slash")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(Color("Color3"))
                                        .padding(12)
                                        .background(Color("Color1"))
                                        .clipShape(Circle())
                                }

                                Spacer()
                            }

                        }

                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("Color1"), lineWidth: 1)
                    )
                    .padding(.horizontal, 25)
                    .padding(.top, 15)
                    .padding(.bottom, 10)

                }

            }

            Spacer()
        }
        .padding(.vertical, 35)
        //このビューが読み込まれたらお気に入りミュージックを取得
        .onAppear {
            
            getFavMusic.fetchFavoriteMusic(ref: ref, userID: userID as! String)
        }
    }
    
    
    //音楽再生用メソッド
    func playMusic(url: String) {
        let url = URL(string: url)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
        
    }
    
    
    //シェアシート
    func actionSheet(musicName: String, artistName: String, previewUrl: String, imageUrl: String) {
        //楽曲情報と視聴用URL
        let data: String = "\(artistName) : \(musicName) \n視聴用URL : \(previewUrl)"
        
        //画像
        let imageData = try? Data(contentsOf: URL(string: imageUrl)!)
        let image = UIImage(data: imageData!)
        
        //楽曲情報とimageを配列に保存
        let item = [image, data] as [Any]
        
        let av = UIActivityViewController(activityItems: item, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }

    
}



