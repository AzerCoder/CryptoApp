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
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
