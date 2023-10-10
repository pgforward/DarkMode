//
//  ContentView.swift
//  DarkMode
//
//  Created by Peter Forward on 9/30/23.
//

import SwiftUI

struct ContentView: View {
    @State var testCounter = 0
    @State private var activeTab: Int = 0
    /// Sample Toggle States
    @State private var toggles: [Bool] = Array(repeating: false, count: 10)
    /// Interface Style
    @State private var toggleDarkMode: Bool = false
    @State private var activeDarkMode: Bool = false
//    @State private var buttonRect: CGRect = .zero
    /// Current & Previous state images
    /// When the dark mode is toggled current screen is stored in previous & new screen is stored in current
    /// These are used as an overlay with the mask effect
    @State private var currentImage: UIImage?
    @State private var previousImage: UIImage?
    @State private var maskAnimation: Bool = false
    var body: some View {
        /// Sample View
        TabView(selection: $activeTab) {
            NavigationStack {
                List {
                    Section("Text Section") {
                        Toggle("Dark Mode", isOn: $toggleDarkMode)
                    }
                    Section("Text Section") {
                        Toggle("Large Display", isOn: $toggles[0])
                        Toggle("Bold Text", isOn: $toggles[1])
                    }
                    Section {
                        Toggle("Night Light", isOn: $toggles[2])
                        Toggle("True Tone", isOn: $toggles[3])
                    } header: {
                        Text("Display Section")
                    } footer: {
                        Text("This is a sample footer")
                    }
                }
                .navigationTitle("Dark Mode")
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            Text("Settings")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
            TestOneView()
                .tabItem {
                    Image(systemName: "testtube.2")
                    Text("Test")
                }
        }

        .createImages(
            toggleDarkMode: toggleDarkMode,
            currentImage: $currentImage,
            previousImage: $previousImage,
            activateDarkMode: $activeDarkMode)
        .overlay(content: {
                if let previousImage, let currentImage {
                    ZStack {
                        Image(uiImage: previousImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Image(uiImage: currentImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .mask() {
                                Circle()
                                    .frame(width: 23 * (maskAnimation ? 40 : 1), height: 23 * (maskAnimation ? 40 : 1))
                            }
                    }
                    .task {
                        guard !maskAnimation else {return}
                        withAnimation(.easeInOut(duration: 1.9), completionCriteria: .logicallyComplete) {
                            logMsg(msg: "Start Animation \(maskAnimation)")
                            maskAnimation = true
                            
                        } completion: {
                            // Removing all snapshots
                            logMsg(msg: "Animation Complete \(maskAnimation) ")
          
                            self.currentImage = nil
                            self.previousImage = nil
                            maskAnimation = false
                        }
                    }
            }
        })
        .ignoresSafeArea()
        .preferredColorScheme(activeDarkMode ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
