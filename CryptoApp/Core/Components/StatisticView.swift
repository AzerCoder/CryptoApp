//
//  StatisticView.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 21/07/24.
//

import SwiftUI

struct StatisticView: View {
    let stat : StatisticModel
    var body: some View {
        VStack(alignment:.leading,spacing:4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack(spacing:4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0:180))
                Text(stat.percentageChange?.asPersentString() ?? "")
                    .font(.caption)
                .bold()
            }.foregroundColor( (stat.percentageChange ?? 0) >= 0 ? Color.theme.green:Color.theme.red)
                .opacity(stat.percentageChange  == nil ? 0:1)
        }
    }
}

#Preview {
    StatisticView(stat: DeveloperPreview.instance.stat)
}
