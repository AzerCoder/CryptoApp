//
//  SettingView.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 28/07/24.
//

import SwiftUI

struct SettingView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let tgURL = URL(string: "https://t.me/iOSDevUzb")!
    let instaURL = URL(string: "https://www.instagram.com/azamjon_abdumuxtorov")!
    let personURL = URL(string: "https://t.me/Azamjon_Abdumuxtorov")!
    @Environment(\.dismiss) var dissmis
    
    var body: some View {
        NavigationView{
            List{
                myChannel
                    .listRowBackground(Color.theme.background.opacity(0.5))
                developerSection
                    .listRowBackground(Color.theme.background.opacity(0.5))
                applicationSection
                    .listRowBackground(Color.theme.background.opacity(0.5))
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .navigationBarItems(
                leading: Button(action: {
                    dissmis()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                }))
        }
    }
}

#Preview {
    SettingView()
}

extension SettingView{
    
    private var myChannel:some View{
        Section(header: Text("A'zamjon Abdumuxtorov")){
            VStack(alignment:.leading){
                Image("images")
                    .resizable()
                    .frame(width: 100,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following a @iOSDevUzb. It uses MVVM Architecture, Combine, and CoreDate!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }.padding(.vertical)
            Link("Subscribe on Telegram 🥳",destination: tgURL)
            Link("Subscribe on Instagram 🥳",destination: instaURL)
        }
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("images")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by A'zamjon Abdumuxtorov. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit Telegram 🤙", destination: personURL)
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        }
    }
    
}
