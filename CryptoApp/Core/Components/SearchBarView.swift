//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 21/07/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText:String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.secondaryText:Color.theme.accent)
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0:1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.2),
                    radius: 10)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
