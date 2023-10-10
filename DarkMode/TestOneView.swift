//
//  TestOneView.swift
//  DarkMode
//
//  Created by Peter Forward on 10/3/23.
//

import SwiftUI

struct TestOneView: View {
    
    @State private var toggleDarkMode: Bool = false
    @State private var activeDarkMode: Bool = false
    @State private var currentImage: UIImage?
    @State private var previousImage: UIImage?
    @State private var maskAnimation: Bool = false
    var body: some View {
        VStack {
            Section("Text Section") {
                Toggle("Dark Mode", isOn: $toggleDarkMode)
            }
            Text("Hello World")
                .font(.headline)
                .background(Color.yellow)
            Text("More Text")
            Text("Even more Text")
                .overlay(content: {
                    VStack {
                        Circle()
                            .foregroundColor(.green)
//                            .background(Color.green)
                    }
                })
  
   
        }
        .createImages(
            toggleDarkMode: toggleDarkMode,
            currentImage: $currentImage,
            previousImage: $previousImage,
            activateDarkMode: $activeDarkMode)

    }
    
    
    
    
}


#Preview {
    TestOneView()
}
