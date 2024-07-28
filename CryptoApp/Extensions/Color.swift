//
//  Color.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 17/07/24.
//

import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}


struct LaunchTheme{
    
    let accent = Color("LaunchAccent")
    let background = Color("LaunchBackground")
}
