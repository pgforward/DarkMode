//
//  TestView.swift
//  DarkMode
//
//  Created by Peter Forward on 10/1/23.
//

import SwiftUI

struct TestView: View {
    @State var scale : CGFloat = 1.0
    var body: some View {
        VStack {
            ZStack {
                
                Image("test")
                Text("\(scale)")
            }
            
            .mask(alignment: .center) {
                        Rectangle()
                             .frame(width: 120 * scale, height: 120 * scale,alignment: .bottomTrailing)
                             .foregroundColor(.orange)
                             .animation(.easeInOut(duration: 3), value: scale)
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            scale = 3    // Compute to find what is the scale for full screen
        }
//        Circle()
//             .frame(width: 120 * scale, height: 120 * scale,alignment: .bottomTrailing)
//             .foregroundColor(.orange)
//             .onTapGesture {
//                 scale = 3    // Compute to find what is the scale for full screen
//             }
//             .animation(.easeInOut(duration: 3), value: scale)
    }
}

#Preview {
    TestView()
}
