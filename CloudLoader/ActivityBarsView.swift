//
//  ActivityArcsView.swift
//  CloudLoader
//
//  Created by Станислав Буйновский on 07.02.2022.
//

import SwiftUI

struct ActivityBarsView: View {
    @Binding private var isAnimating: Bool
    let count: UInt
    let spacing: CGFloat
    let cornerRadius: CGFloat
    let scaleRange: ClosedRange<Double>
    let opacityRange: ClosedRange<Double>

    init(animate: Binding<Bool>,
                count: UInt = 8,
                spacing: CGFloat = 8,
                cornerRadius: CGFloat = 8,
                scaleRange: ClosedRange<Double> = (0.5...1),
                opacityRange: ClosedRange<Double> = (0.25...1)) {
        self._isAnimating = animate
        self.count = count
        self.spacing = spacing
        self.cornerRadius = cornerRadius
        self.scaleRange = scaleRange
        self.opacityRange = opacityRange
    }

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<Int(count)) { index in
                item(forIndex: index, in: geometry.size)
            }
        }
        .aspectRatio(contentMode: .fit)
        .padding()
    }

    private var scale: CGFloat { CGFloat(isAnimating ? scaleRange.lowerBound : scaleRange.upperBound) }
    private var opacity: Double { isAnimating ? opacityRange.lowerBound : opacityRange.upperBound }

    private func size(count: UInt, geometry: CGSize) -> CGFloat {
        (geometry.width/CGFloat(count)) - (spacing - 1)
    }

    private func item(forIndex index: Int, in geometrySize: CGSize) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius,  style: .continuous)
            .frame(width: size(count: count, geometry: geometrySize), height: geometrySize.height)
            .scaleEffect(x: 1, y: scale, anchor: .center)
            .opacity(opacity)
            .animation(
                Animation
                    .default
                    .repeatCount(isAnimating ? .max : 1, autoreverses: true)
                    .delay(Double(index) / Double(count) / 2),
                value: isAnimating
            )
            .offset(x: CGFloat(index) * (size(count: count, geometry: geometrySize) + spacing))
    }
}

struct ActivityBarsView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityBarsView(animate: .constant(true))
    }
}
