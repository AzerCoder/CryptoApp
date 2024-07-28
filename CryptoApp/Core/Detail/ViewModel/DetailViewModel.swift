//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 27/07/24.
//

import Foundation
import Combine

class DetailViewModel:ObservableObject{
    
    @Published var overviewStatistics:[StatisticModel] = []
    @Published var additionalStatistics:[StatisticModel] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    @Published var coin: CoinModel
    
    private let detailService: CoinDetailDataService
    private var cencellables = Set<AnyCancellable>()
    
    init(coin:CoinModel){
        self.coin = coin
        self.detailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        
        detailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] (returnedArrays) in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cencellables)
        
        detailService.$coinDetails
            .sink { [weak self] (returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.redableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cencellables)
    }
    
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        let overviewArray = createOverviewArray(coinModel: coinModel)
        let additionalArray = createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
        return (overviewArray, additionalArray)
    }
    
    private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        let price = coinModel.currentPrice.asCurrencyWith2Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overviewArray: [StatisticModel] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        return overviewArray
    }
    
    private func createAdditionalArray(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatisticModel] {
        
        let high = coinModel.high24H?.asCurrencyWith2Decimals() ?? "N/A"
        let highStat = StatisticModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith2Decimals() ?? "N/A"
        let lowStat = StatisticModel(title: "24h Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith2Decimals() ?? "N/A"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "N/A" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "N/A"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [StatisticModel] = [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
        return additionalArray
    }
}
