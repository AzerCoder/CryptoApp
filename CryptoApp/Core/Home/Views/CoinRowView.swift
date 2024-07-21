//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 20/07/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing:0) {
            leftColumn
            Spacer()
            if showHoldingsColumn{
                centerColumn
            }
            rightColumn
        }.font(.subheadline)
    }
}

#Preview {
    CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)
        .previewLayout(.sizeThatFits)
}


extension CoinRowView{
    private var leftColumn:some View{
        HStack{
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30,height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerColumn:some View{
        VStack(alignment:.trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }.foregroundColor(Color.theme.accent)
    }
    
    private var rightColumn:some View{
        VStack(alignment:.trailing){
            Text(coin.currentPrice.asCurrencyWith2Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPersentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                )
        }.frame(width: UIScreen.main.bounds.width/3.5,alignment: .trailing)
    }
}
