//
//  TestTransitionView.swift
//  DarkMode
//
//  Created by Peter Forward on 10/3/23.
//

import SwiftUI

struct TestTransitionView: View {
    @State private var isShowingRed = false

    var body: some View {
        ZStack {
            if !isShowingRed {
                Color.blue
            }

            if isShowingRed {
                Color.red
                    .transition(.iris)
                    .zIndex(1)
            }
            Text("Hello")
        }
        .ignoresSafeArea()
//        .padding(50)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isShowingRed.toggle()
            }
        }
        
    }
}

#Preview {
    TestTransitionView()
}
