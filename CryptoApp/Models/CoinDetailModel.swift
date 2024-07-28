//
//  CoinDetailModel.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 27/07/24.
//

import Foundation


// MARK: - Welcome
struct CoinDetailModel: Codable {
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let categories: [String]?
    let description: Description?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id,symbol,name,categories,description,links
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
    }
    
    var redableDescription:String?{
        return description?.en?.removingHTMLOccurances
    }
}

// MARK: - Description
struct Description: Codable {
    let en: String?
}

// MARK: - Links
struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?

    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}
