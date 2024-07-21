//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 20/07/24.
//

import Foundation
import Combine

class HomeViewModel:ObservableObject{
    
    @Published var statistics :[StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText:String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cencellables = Set<AnyCancellable>()
    
    
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins)in
                self?.allCoins = returnedCoins
            }
            .store(in: &cencellables)
        
        marketDataService.$marketdata
            .map { (marketDataModel) -> [StatisticModel] in
                var stats:[StatisticModel] = []
                
                guard let data = marketDataModel else{
                    return stats
                }
                
                let marketCap = StatisticModel(title: "Market Cap", value: data.marketCup, percentageChange: data.marketCapChangePercentage24HUsd)
                let volume = StatisticModel(title: "24h Volume", value: data.volume)
                let btcDominance =  StatisticModel(title: "BTC Dominance", value: data.btcDominance)
                let portfolio =  StatisticModel(title: "Portfolio Value", value: "$0.00",percentageChange: 0)
                
                stats.append(contentsOf: [
                    marketCap,
                    volume,
                    btcDominance,
                    portfolio
                ])
                return stats
            }
            .sink {[weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cencellables)
        
        
    }
    
    private func filterCoins(text:String,coins:[CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else{
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
}
