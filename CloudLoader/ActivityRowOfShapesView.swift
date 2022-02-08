//
//  ActivityArcsView.swift
//  CloudLoader
//
//  Created by Станислав Буйновский on 07.02.2022.
//

import SwiftUI

struct ActivityRowOfShapesView: View {
    @Binding private var isAnimating: Bool
    let count: UInt
    let spacing: CGFloat
    let content: AnyView
    let scaleRange: ClosedRange<Double>
    let opacityRange: ClosedRange<Double>
    
    init<Content: View>(animate: Binding<Bool>,
                        count: UInt = 3,
                        spacing: CGFloat = 8,
                        scaleRange: ClosedRange<Double> = (0.75...1),
                        opacityRange: ClosedRange<Double> = (0.25...1),
                        content: () -> Content) {
        
        self._isAnimating = animate
        self.count = count
        self.content = AnyView(content())
        self.spacing = spacing
        self.scaleRange = scaleRange
        self.opacityRange = opacityRange
    }
    
    init(animate: Binding<Bool>,
         count: UInt = 5,
         spacing: CGFloat = 8,
         scaleRange: ClosedRange<Double> = (0.75...1),
         opacityRange: ClosedRange<Double> = (0.25...1)) {
        self.init(animate: animate, count: count, spacing: spacing,
                  scaleRange: scaleRange,
                  opacityRange: opacityRange) {
            Circle()
        }
    }
    
    private func animatingScale(forIndex index: Int) -> CGFloat { CGFloat(index + 1) / CGFloat(count) }
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<Int(count)) { index in
                item(forIndex: index, in: geometry.size)
            }
            .offset(x: 0, y: geometry.size.height / 2.5)
        }
        .aspectRatio(contentMode: .fit)
        .padding()
        
    }
    
    private func size(count: UInt, geometry: CGSize) -> CGFloat {
        (geometry.width/CGFloat(count)) - spacing
    }
    
    private var scale: CGFloat { CGFloat(isAnimating ? scaleRange.lowerBound : scaleRange.upperBound) }
    private var opacity: Double { isAnimating ? opacityRange.lowerBound : opacityRange.upperBound }
    
    private func item(forIndex index: Int, in geometrySize: CGSize) -> some View {
        content
            .frame(width: size(count: count, geometry: geometrySize),
                   height: size(count: count, geometry: geometrySize))
            .scaleEffect(scale)
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

struct ActivityRowOfShapesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityRowOfShapesView(animate: .constant(true))
    }
}
