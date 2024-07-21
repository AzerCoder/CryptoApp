//
//  PreviewProvider.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 20/07/24.
//

import SwiftUI

extension Preview{
    
    static var dev: DeveloperPreview{
        return DeveloperPreview.instance
    }
}

class DeveloperPreview{
    
    static let instance  = DeveloperPreview()
    private init() {}
    
    let stat = StatisticModel(title: "Title", value: "Value", percentageChange: 1.11)
    let stat1 = StatisticModel(title: "Title1", value: "Value1")
    let stat2 = StatisticModel(title: "Title2", value: "Value2", percentageChange: -3.22)
    let stat3 = StatisticModel(title: "Title3", value: "Value3", percentageChange: 2.45)
    
    let coin = CoinModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
        currentPrice: 34250.0,
        marketCap: 642250000000.0,
        marketCapRank: 1,
        fullyDilutedValuation: 721500000000.0,
        totalVolume: 25000000000.0,
        high24H: 35000.0,
        low24H: 33500.0,
        priceChange24H: 750.0,
        priceChangePercentage24H: 2.23,
        marketCapChange24H: 14500000000.0,
        marketCapChangePercentage24H: 2.31,
        circulatingSupply: 18750000.0,
        totalSupply: 21000000.0,
        maxSupply: 21000000.0,
        ath: 64850.0,
        athChangePercentage: -47.2,
        athDate: "2021-04-14",
        atl: 67.81,
        atlChangePercentage: 50432.34,
        atlDate: "2013-07-06",
        lastUpdated: "2024-07-20T18:30:00.000Z",
        sparklineIn7D: SparklineIn7D(price: [33000.0, 33200.0, 34000.0, 34250.0, 34100.0]),
        priceChangePercentage24HInCurrency: 2.23,
        currentHoldings: 0.5
    )
}

