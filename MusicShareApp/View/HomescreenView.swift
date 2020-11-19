//
//  HomescreenView.swift
//  MusicShareApp
//
//  Created by yanasetakuya on 2020/11/15.
//

import SwiftUI
import Firebase

struct HomescreenView : View {
    
    @State var index = 0
    
    var body: some View{
        
        VStack(spacing: 0){
            
            ZStack {
                //タブ切り替え
                if self.index == 0 {
                    //ホーム画面
                    Text("Home")
                    Color("Color1").opacity(0.35)
                } else if self.index == 1 {
                    //検索画面
                    SearchView()
                } else if self.index == 2 {
                    //お気に入り画面
                    Text("Favorite")
                    Color("Color1").opacity(0.35)
                } else{
                    //アカウント画面
                    Color("Color1").opacity(0.35)
                    AccountView()
                }
                
            }
            .padding(.bottom, -35)
            
            CustomTabsView(index: self.$index)
            
        }
        
    }
}
