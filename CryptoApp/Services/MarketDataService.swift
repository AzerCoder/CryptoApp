//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 21/07/24.
//

import SwiftUI
import Combine

class MarketDataService{
    
    @Published var marketdata: MarketDataModel?
    
    var marketDataSubscription: AnyCancellable?
    
    init(){
        getData()
    }
    
    private func getData(){
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {return}
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleComplition, receiveValue: {[weak self] (globalData) in
                self?.marketdata = globalData.data
                print(globalData)
            })
        
           
    }
}
