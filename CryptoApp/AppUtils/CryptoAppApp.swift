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
