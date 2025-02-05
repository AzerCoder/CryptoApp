//
//  Double.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 20/07/24.
//

import Foundation

extension Double{
    
    private var currentFormatter2: NumberFormatter{
        
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func asCurrencyWith2Decimals()-> String{
        let number = NSNumber(value: self)
        return currentFormatter2.string(from: number) ?? "$0.00"
    }
    
    func asNumberString()-> String{
        return String(format: "%.2f", self)
    }
    
    func asPersentString()->String{
        return asNumberString() + "%"
    }
    
    func formattedWithAbbreviations() -> String {
            let num = abs(self)
            let sign = (self < 0) ? "-" : ""
            
            switch num {
            case 1_000_000_000_000...:
                let formatted = num / 1_000_000_000_000
                let stringFormatted = formatted.asNumberString()
                return "\(sign)\(stringFormatted)Tr"
            case 1_000_000_000...:
                let formatted = num / 1_000_000_000
                let stringFormatted = formatted.asNumberString()
                return "\(sign)\(stringFormatted)Bn"
            case 1_000_000...:
                let formatted = num / 1_000_000
                let stringFormatted = formatted.asNumberString()
                return "\(sign)\(stringFormatted)M"
            case 1_000...:
                let formatted = num / 1_000
                let stringFormatted = formatted.asNumberString()
                return "\(sign)\(stringFormatted)K"
            case 0...:
                return self.asNumberString()
            default:
                return "\(sign)\(self)"
            }
        }
}
