//
//  String.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 28/07/24.
//

import Foundation

extension String{
    
    var removingHTMLOccurances:String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "",options: .regularExpression,range: nil)
    }
}
