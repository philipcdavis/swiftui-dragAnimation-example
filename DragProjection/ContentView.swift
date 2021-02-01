//
//  ContentView.swift
//  DragProjection
//
//  Created by Philip Davis on 1/19/21.
//

import SwiftUI

func project(initialVelocity: Float, decelerationRate:Float) -> Float {
    return (initialVelocity / 1000.0) * decelerationRate / (1.0 - decelerationRate)
}

let decelerationRate = UIScrollView.DecelerationRate.normal

//let projectedPosition = (
//    x: x.value + project(initialVelocity: x.velocity, decelerationRate: decelerationRate)
//    y: y.value + project(initialVelocity: y.velocity, decelerationRate: decelerationRate),
//)
//
//let nearestCornerPosition = nearestCornerTo(projectedPosition)
//
//x.target = nearestCornerPosition.x
//y.target = nearestCornerPosition.y





struct ContentView: View {
    @State private var dragAmount:CGSize = .zero
    @State private var isDragging = false
    
    var body: some View {
        ZStack {
            Color(.gray)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .opacity(isDragging ? 1 : 0.5)
                .frame(width: 100, height: 150)
                .offset(dragAmount)
                .shadow(radius: isDragging ? 20 : 3 )
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            
                            let translation: CGSize = value.translation
                            let multiplier: CGFloat = 10
                            let incrementalW: CGFloat = log(abs(translation.width)) * multiplier
                            let incrementalH: CGFloat = log(abs(translation.height)) * multiplier
                            let incremental = CGSize(
                                width: translation.width > 0 ? incrementalW : -incrementalW,
                                height: translation.height > 0 ? incrementalH : -incrementalH
                            )
                            let resistance = CGSize(
                                width: abs(translation.width) < abs(incremental.width) ? translation.width : incremental.width,
                                height: abs(translation.height) < abs(incremental.height) ? translation.height : incremental.height
                            )
                            
                            
                            
                            
                            dragAmount = resistance
                            
                        }
                        .onEnded { value in
                            
                            withAnimation(.spring()) {
                                isDragging = false
                                dragAmount = .zero
                            }
                            
                            
                        })
                .scaleEffect(isDragging ? 1.1 : 1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
