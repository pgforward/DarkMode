//
//  View+Extensions.swift
//  DarkMode
//
//  Created by Peter Forward on 9/30/23.
//

import Foundation
import SwiftUI
/// Custom View Extensions
extension View {
    
    @MainActor @ViewBuilder
    func createImages(toggleDarkMode: Bool, currentImage: Binding<UIImage?>, previousImage: Binding<UIImage?>, activateDarkMode: Binding<Bool>) -> some View {
        self
            .onChange (of: toggleDarkMode) {oldValue, newValue in
                logMsg(msg: "toggleDarkMode=\(toggleDarkMode) oldValue=\(oldValue) newValue=\(newValue)")
                Task {
                    if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first (where: {
                        $0.isKeyWindow }) {
                        let imageView = UIImageView()
                        imageView.frame = window.frame
                        imageView.image = window.rootViewController?.view.image(window.frame.size)
                        imageView.contentMode = .scaleAspectFit
                        window.addSubview(imageView)
                        if let rootView = window.rootViewController?.view {
                            let frameSize = rootView.frame.size
                            /// Creating Snapshots
                            /// Old One
                            activateDarkMode.wrappedValue = !newValue
                            previousImage.wrappedValue = rootView.image(frameSize)
                            try await Task.sleep(for: .seconds(0.01))
                            /// New One with Updated Trait State activateDarkMode.wrapperValue = newValue
                            activateDarkMode.wrappedValue = newValue
                            /// Giving some time to complete the transition
                            try await Task.sleep(for: .seconds(0.01))
                            currentImage.wrappedValue = rootView.image (frameSize)
                            /// Removing once all the snapshots have been taken
                            try await Task.sleep(for: .seconds(0.01))
                            imageView.removeFromSuperview()
                            logMsg(msg: "Images captured")
                        }
                    }
                }
            }
    }
}

/// Converting UIView to UIImage
extension UIView {
    func image(_ size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            drawHierarchy(in: .init(origin: .zero, size: size), afterScreenUpdates: true)
        }
    }
}
