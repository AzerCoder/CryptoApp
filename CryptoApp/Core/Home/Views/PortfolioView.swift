//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 21/07/24.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @Environment(\.dismiss) var dissmis
    @State var selectedCoin: CoinModel? = nil
    @State private var quantityText:String = ""
    @State private var showCheckmark:Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(alignment:.leading,spacing:0){
                    SearchBarView(searchText: $vm.searchText)
                    coinsLogoList
                    
                    if selectedCoin != nil{
                        portfolioInputSection
                    }
                    
                }
            }
            .navigationTitle("Edit Portfolio")
            .navigationBarItems(
                leading:
                    Button(action: {
                        dissmis()
                    },
                           label: {
                               Image(systemName: "xmark")
                                   .font(.headline)
                           }),
                trailing:trailingNavBarItem)
            .onChange(of: vm.searchText) { newValue in
                if newValue == ""{
                    removeSeledtedCoin()
                }
            }
        }
    }
}

#Preview {
    
    PortfolioView()
        .environmentObject(HomeViewModel())
}


extension PortfolioView{
    
    private var  coinsLogoList: some View{
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing:10){
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins: vm.allCoins){coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear,lineWidth: 1)
                        )
                }
            }.frame(height: 120)
                .padding(.leading)
        })
    }
    
    private func updateSelectedCoin(coin: CoinModel){
        selectedCoin = coin
        
       if let portfolioCoin  = vm.portfolioCoins.first(where: {$0.id == coin.id}),
          let amont = portfolioCoin.currentHoldings{
           quantityText = "\(amont)"
       }else{
           quantityText = ""
       }
    }
    
    private func getCurrentValue()->Double{
        if let quentity = Double(quantityText){
            return quentity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing:20){
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith2Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Ammount holding:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarItem:some View{
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1:0)
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("Save".uppercased())
            })
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1:0
            )
           
        } .font(.headline)
    }
    
    private func saveButtonPressed(){
        
        guard let coin = selectedCoin,let amount = Double(quantityText) else {return}
        
        vm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn){
            showCheckmark = true
            removeSeledtedCoin()
        }
        
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSeledtedCoin(){
        selectedCoin = nil
        vm.searchText = ""
        quantityText = ""
    }
}
