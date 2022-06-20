//
//  HomeView.swift
//  Peter007_1
//
//  Created by DONG SHENG on 2022/6/20.
//

import SwiftUI

class HomeViewModel: ObservableObject{
    
//   (View1用)  - - - - - - - - - - - - - - - - - - - - - - - - - - -
    @Published var show1: Bool = false
 
//   (View2用)  - - - - - - - - - - - - - - - - - - - - - - - - - - -
    @Published var colorArray: [Color] = [
        // 紫 -> 靛 -> 藍 -> 綠 -> 黃 -> 橘 -> 紅
        Color(#colorLiteral(red: 0.6545115113, green: 0.1989120245, blue: 0.8611527085, alpha: 1)), Color(#colorLiteral(red: 0.37135607, green: 0.1111179665, blue: 0.5821831226, alpha: 1)), Color(#colorLiteral(red: 0.01684191637, green: 0.198341459, blue: 1, alpha: 1)) , Color(#colorLiteral(red: 0, green: 0.9767891765, blue: 0, alpha: 1)),
        Color(#colorLiteral(red: 0.9994267821, green: 0.9855352044, blue: 0, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.5746231079, blue: 0, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1))
    ]
    @Published var colorIndex: Int = Int.random(in: 0...6) // 七個顏色中 隨機挑一個初始
    
//   (View3用)  - - - - - - - - - - - - - - - - - - - - - - - - - - -
    @Published var randomRed: Double = Double.random(in: 0...1)
    @Published var randomGreen: Double = Double.random(in: 0...1)
    @Published var randomBlue: Double = Double.random(in: 0...1)
    
//   (View5用)  - - - - - - - - - - - - - - - - - - - - - - - - - - -
    @Published var imageIndex: Int = Int.random(in: 1...6) // 六張圖片中 隨機挑一個為初始
}

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        TabView {
            View1
                .tabItem{
                    Text("View1")
                }
            View2
                .tabItem{
                    Text("View2")
                }
            View3
                .tabItem{
                    Text("View3")
                }
            View5
                .tabItem{
                    Text("View5")
            
                }
        }
        .accentColor(.purple)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView{
    
    // 簡單版 點擊畫面 黑 <-> 白 切換
    private var View1: some View{
        VStack{
            Color(viewModel.show1 ? .black : .white)
        }
        .ignoresSafeArea(edges: .top)
        .onTapGesture {
            viewModel.show1.toggle()
        }
    }
    
    // 進階版1(進階) : 一開始隨機顯示其中一種顏色，之後點擊畫面依照彩虹順序換色
    // 紫 -> 靛 -> 藍 -> 綠 -> 黃 -> 橘 -> 紅
    private var View2: some View{
        VStack{
            viewModel.colorArray[viewModel.colorIndex]
        }
        .ignoresSafeArea(edges: .top)
        .onTapGesture {
            guard viewModel.colorIndex < 6 else { self.viewModel.colorIndex = 0 ; return }
            self.viewModel.colorIndex += 1
        }
    }
    
    // 進階版2 : 點擊畫面將亂數產生新的顏色
    private var View3: some View{
        VStack{
            Color(red: viewModel.randomRed, green: viewModel.randomGreen, blue: viewModel.randomBlue)
        }
        .ignoresSafeArea(edges: .top)
        .onTapGesture {
            self.viewModel.randomRed = Double.random(in: 0...1)
            self.viewModel.randomBlue = Double.random(in: 0...1)
            self.viewModel.randomGreen = Double.random(in: 0...1)
        }
    }
    
    // 進階版3(進階): 一開始隨機顯示其中一張圖片，之後點擊畫面依照片順序換圖
    private var View5: some View{
        VStack{
            Image("Image\(viewModel.imageIndex)")
                .resizable()
        }
        .ignoresSafeArea(edges: .top)
        .onTapGesture {
            guard self.viewModel.imageIndex < 6 else { self.viewModel.imageIndex = 1 ; return }
            self.viewModel.imageIndex += 1
        }
    }
}
