//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 21/07/24.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject var vm: HomeViewModel
   
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(alignment:.leading,spacing:0){
                    SearchBarView(searchText: $vm.searchText)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        LazyHStack(spacing:10){
                            ForEach(vm.allCoins){coin in
                                CoinLogoView(coin: coin)
                                    .frame(width: 75)
                            }
                        }
                    })
                }
            }
            .navigationTitle("Edit Portfolio")
            .navigationBarItems(leading:XmarkButton())
        }
    }
}

#Preview {
   
    PortfolioView()
        .environmentObject(HomeViewModel())
}
