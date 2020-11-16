//
//  CustomTabsView.swift
//  MusicShareApp
//
//  Created by yanasetakuya on 2020/11/17.
//

import SwiftUI

struct CustomTabsView: View {
    
    @Binding var index: Int
    
    var body: some View {
        HStack {
            
            //ホームタブ
            Button(action: {
                self.index = 0
            }) {
                Image(systemName: "house.circle")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            }
            .foregroundColor(Color("Color1").opacity(self.index == 0 ? 1 : 0.2))
            
            
            Spacer(minLength: 0)
            //検索タブ
            Button(action: {
                self.index = 1
            }) {
                Image(systemName: "magnifyingglass.circle")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            }
            .foregroundColor(Color("Color1").opacity(self.index == 1 ? 1 : 0.2))
            .offset(x: 10.0)
            
            Spacer(minLength: 0)
            
            //追加ボタン
            Button(action: {
                
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(Color("Color3"))
            }
            .offset(y: -25)
            
            Spacer(minLength: 0)
            
            //お気に入りタブ
            Button(action: {
                self.index = 2
            }) {
                Image(systemName: "heart.circle")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            }
            .foregroundColor(Color("Color1").opacity(self.index == 2 ? 1 : 0.2))
            .offset(x: -10.0)
            
            Spacer(minLength: 0)
            
            //個人設定タブ
            Button(action: {
                self.index = 3
            }) {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            }
            .foregroundColor(Color("Color1").opacity(self.index == 3 ? 1 : 0.2))
            
        }
        .padding(.horizontal, 35)
        .padding(.top, 35)
        .background(Color.white)
        .clipShape(CShape())
    }
}

struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 35))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 35))
            
            path.addArc(center: CGPoint(x: rect.width / 2, y: 35),
                        radius: 35, startAngle: .zero, endAngle: .init(degrees: 180),
                        clockwise: true)
            
        }
    }
}
