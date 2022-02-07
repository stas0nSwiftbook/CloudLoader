//
//  ActivityArcsView.swift
//  CloudLoader
//
//  Created by Станислав Буйновский on 07.02.2022.
//

import SwiftUI

struct ActivityArcsView: View {
    @Binding private var isAnimating: Bool
    let count: UInt
    let width: CGFloat
    let spacing: CGFloat

    init(animate: Binding<Bool>, count: UInt = 3, width: CGFloat = 2, spacing: CGFloat = 1) {
        self._isAnimating = animate
        self.count = count
        self.width = width
        self.spacing = spacing
    }

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<Int(count)) { index in
                arc(forIndex: index, in: geometry.size)
                    .rotationEffect(isAnimating ? .degrees(360) : .degrees(0))
                    .animation(
                        Animation.default
                            .speed(Double.random(in: 0.1...0.5))
                            .repeatCount(isAnimating ? .max : 1, autoreverses: false),
                        value: isAnimating
                    )
            }
        }
        .aspectRatio(contentMode: .fit)
        .padding()
    }

    private func arc(forIndex index: Int, in geometrySize: CGSize) -> some View {
        Group { () -> Path in
            var path = Path()
            path.addArc(center: CGPoint(x: geometrySize.width/2, y: geometrySize.height/2),
                     radius: geometrySize.width/2 - width/2 - CGFloat(index) * (width + spacing),
                     startAngle: .degrees(0),
                     endAngle: .degrees(Double(Int.random(in: 120...300))),
                     clockwise: true)
            return path.strokedPath(.init(lineWidth: width))
        }
        .frame(width: geometrySize.width, height: geometrySize.height)
    }
}

struct ActivityArcsView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityArcsView(animate: .constant(true))
    }
}
