//
//  CloudLoaderView.swift
//  CloudLoader
//
//  Created by Станислав Буйновский on 07.02.2022.
//

import SwiftUI

struct CloudLoaderView: View {
    @State private var persentage: CGFloat = 0
    @State private var fromPersentage: CGFloat = 0
    
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = width / 2
            
            Path { path in
                path.move(to:CGPoint(x: width / 4, y: height))
                path.addArc(center: CGPoint(x: width / 4, y: height * 2 / 3),
                            radius: height / 3,
                            startAngle: Angle(degrees: 90),
                            endAngle: Angle(degrees: 270),
                            clockwise: false)
                path.addLine(to: CGPoint(x: width / 3, y: height / 3))
                path.addArc(center: CGPoint(x: width / 2, y: height / 3),
                            radius: height / 3,
                            startAngle: Angle(degrees: 180),
                            endAngle: Angle(degrees: 0),
                            clockwise: false)
                path.addLine(to: CGPoint(x: width * 3 / 4, y: height / 3))
                path.addArc(center: CGPoint(x: width * 3 / 4, y: height * 2 / 3),
                            radius: height / 3,
                            startAngle: Angle(degrees: 270),
                            endAngle: Angle(degrees: 90),
                            clockwise: false)
                path.closeSubpath()
            }
            .trim(from: fromPersentage, to: persentage)
            .stroke(color, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            .onAppear {
                withAnimation(.easeInOut(duration: 1.3).repeatForever(autoreverses: false)) {
                    persentage = 1.0
                }
                withAnimation(.easeInOut(duration: 1.3).repeatForever(autoreverses: false)) {
                    fromPersentage = 1.0
                }
            }
            
            Path { path in
                path.move(to:CGPoint(x: width / 4, y: height))
                path.addArc(center: CGPoint(x: width / 4, y: height * 2 / 3),
                            radius: height / 3,
                            startAngle: Angle(degrees: 90),
                            endAngle: Angle(degrees: 270),
                            clockwise: false)
                path.addLine(to: CGPoint(x: width / 3, y: height / 3))
                path.addArc(center: CGPoint(x: width / 2, y: height / 3),
                            radius: height / 3,
                            startAngle: Angle(degrees: 180),
                            endAngle: Angle(degrees: 0),
                            clockwise: false)
                path.addLine(to: CGPoint(x: width * 3 / 4, y: height / 3))
                path.addArc(center: CGPoint(x: width * 3 / 4, y: height * 2 / 3),
                            radius: height / 3,
                            startAngle: Angle(degrees: 270),
                            endAngle: Angle(degrees: 90),
                            clockwise: false)
                path.closeSubpath()
            }
            .fill(LinearGradient(
                colors: [color, .white],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.8)
            ))
        }
        
    }
}

struct CloudLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
