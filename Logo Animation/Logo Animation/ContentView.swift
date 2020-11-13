//
//  ContentView.swift
//  Logo Animation
//
//  Created by Ena Vorkapic on 11/13/20.
//

import SwiftUI

let borderBlue = Color(UIColor(red: 67/255, green: 118/255, blue: 235/255, alpha: 1))
let mediumBlue = Color(UIColor(red: 98/255, green: 142/255, blue: 249/255, alpha: 1))
let lightestBlue = Color(UIColor(red: 192/255, green: 209/255, blue: 1, alpha: 1))

struct ContentView: View {
    @State var time: Double = 0
    @State var offsetY: CGFloat = 72
    
    let gradient = LinearGradient(gradient: Gradient(colors: [mediumBlue, .white]), startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        VStack {
            ZStack {
                Wave(time: CGFloat(time))
                    .fill(gradient)
                    .frame(width: 250, height: 125) }
            .offset(x: 0, y: offsetY - 35)
            .mask(
                Image("pigeon")
                    .resizable()
                    .frame(width: 250, height: 125)
                    .aspectRatio(contentMode: .fit))
                .overlay(
                    Pigeon()
                        .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                        .frame(width: 250, height: 125)
                        .foregroundColor(mediumBlue)) }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.015, repeats: true) { _ in
                self.time += 0.01
                if self.offsetY >= (-52) {
                    withAnimation(Animation.linear(duration: 0.08)) {
                        self.offsetY -= 0.2
                    }
                } else {
                    self.offsetY = 72
                } } } }
}

struct Pigeon: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.size.width/2 + 5, y: rect.size.height - 50))
            path.addLine(to: CGPoint(x: rect.size.width/2 + 23, y: rect.size.height - 25))
            path.addLine(to: CGPoint(x: rect.size.width/2, y: rect.size.height))
            path.addLine(to: CGPoint(x: rect.size.width/2 - 23, y: rect.size.height - 25))
            path.addLine(to: CGPoint(x: rect.size.width/2 - 5, y: rect.size.height - 50))
            
            path.addQuadCurve(to: CGPoint(x: 0, y: 10), control: CGPoint(x: 80, y: 35))
            path.addQuadCurve(to: CGPoint(x: rect.size.width/2 - 20, y: 18), control: CGPoint(x: 40, y:-5))
            path.addQuadCurve(to: CGPoint(x: rect.size.width/2 - 11, y: 15), control: CGPoint(x: rect.size.width/2 - 12, y: 20))
            
            path.addArc(center: CGPoint(x: rect.size.width/2, y: 13), radius: 11, startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false)
            
            path.addQuadCurve(to: CGPoint(x: rect.size.width/2 + 20, y: 18), control: CGPoint(x: rect.size.width/2 + 11, y: 20))
            path.addQuadCurve(to: CGPoint(x: rect.size.width, y: 10), control: CGPoint(x: rect.size.width - 40, y: -5))
            path.addQuadCurve(to: CGPoint(x: rect.size.width/2 + 5, y:rect.size.height - 50), control: CGPoint(x: rect.size.width/2 + 40, y: 35))
        }
    }
}

struct Wave: Shape {
    var time: CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 250, y: 210))
            path.addLine(to: CGPoint(x: 0, y: 210))

            for i in stride(from: 0, to: CGFloat(rect.width), by: 0.5) {
                path.addLine(to: CGPoint(x: i, y: sin((i / (rect.height/2.5)) + time * .pi * 1.5) * 20 + rect.midY))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
