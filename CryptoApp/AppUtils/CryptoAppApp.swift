//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 17/07/24.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    @StateObject private var vm: HomeViewModel = HomeViewModel()
    @State private var showLaunchView:Bool = true
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationView{
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(vm)
                
                ZStack{
                    if showLaunchView{
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .top))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
