//
//  UIApplication.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 21/07/24.
//

import SwiftUI

extension UIApplication{
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
