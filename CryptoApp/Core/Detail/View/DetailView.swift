//
//  DetailView.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 27/07/24.
//

import SwiftUI


struct DetailLoadingView:View {
    
    @Binding var coin:CoinModel?
    
    var body: some View {
        ZStack{
            if let coin = coin{
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    @State private var showText:Bool = false
    
    private let columns:[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private var spacing:CGFloat = 30
    
    init(coin:CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView(showsIndicators:false) {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing:20){
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    webUrls
                }.padding()
            }
        }
        .navigationBarTitle(vm.coin.name)
        .navigationBarItems(trailing:navigationItem)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}


extension DetailView{
    
    private var navigationItem:some View{
        HStack{
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25,height: 25)
        }
    }
    
    private var overviewTitle:some View{
        VStack{
            Text("Overview")
                .font(.title)
                .bold()
                .foregroundStyle(Color.theme.accent)
                .frame(maxWidth: .infinity,alignment: .leading)
            
        }
    }
    
    private var descriptionSection:some View{
        ZStack{
            if let coinDescription = vm.coinDescription,!coinDescription.isEmpty{
                VStack(alignment:.leading) {
                    Text(coinDescription)
                        .lineLimit(showText ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    Button {
                        withAnimation(.easeInOut) {
                            showText.toggle()
                        }
                        
                    } label: {
                        Text(showText ? "Less": "Read more...")
                            .fontWeight(.bold)
                            .font(.caption)
                            .padding(.vertical,4)
                    }
                    .accentColor(.blue)
                    
                }.frame(maxWidth: .infinity,alignment: .leading)
            }
        }
    }
    
    private var overviewGrid:some View{
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
    }
    
    private var additionalTitle:some View{
        VStack{
            Text("Additional Details")
                .font(.title)
                .bold()
                .foregroundStyle(Color.theme.accent)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            
            
        }
    }
    
    private var additionalGrid:some View{
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
    }
    
    private var webUrls:some View{
        VStack(alignment:.leading,spacing:10){
            if let websiteString = vm.websiteURL,let url = URL(string: websiteString){
                Link("Website", destination: url)
            }
            
            if let redditString = vm.redditURL,let url = URL(string: redditString){
                Link("Reddit", destination: url)
            }
        }
        .accentColor(.blue)
        .font(.headline)
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}
