//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 27/07/24.
//

import Foundation
import Combine

class CoinDetailDataService{
    
    @Published var coinDetails: CoinDetailModel? = nil
    
    var coinDetailSubsription: AnyCancellable?
    let coin:CoinModel
    
    init(coin:CoinModel){
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails(){
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparklinefalse") else {return}
        
        coinDetailSubsription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleComplition, receiveValue: {[weak self] (returnedCoin) in
                self?.coinDetails = returnedCoin
                self?.coinDetailSubsription?.cancel()
            })
           
           
    }
}
