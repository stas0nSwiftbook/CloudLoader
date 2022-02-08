//
//  ContentView.swift
//  CloudLoader
//
//  Created by Станислав Буйновский on 07.02.2022.
//

import SwiftUI

struct DemoView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            ActivityArcsView(
                animate: $isAnimating,
                count: 4,
                width: 6,
                spacing: 4
            )
                .foregroundColor(.orange)
            
            ActivityRowOfShapesView(
                animate: $isAnimating,
                count: 8,
                spacing: 6
            )
                .foregroundColor(.blue)
            
            ActivityBarsView(
                animate: $isAnimating,
                count: 8,
                spacing: 14,
                cornerRadius: 4,
                scaleRange: 0.5...1,
                opacityRange: 0...1
            )
                .foregroundColor(.green)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}
