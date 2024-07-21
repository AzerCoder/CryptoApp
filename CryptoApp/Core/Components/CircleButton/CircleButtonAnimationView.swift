//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 19/07/24.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate : Bool
    
    var body: some View {
       Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1:0)
            .opacity(animate ? 0 : 1)
            .animation(animate ? Animation.easeOut(duration: 1.0):.none)
            .onAppear{
                animate.toggle()
            }
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(true))
}
