//
//  File.swift
//  
//
//  Created by Beatriz Leonel da Silva on 19/04/23.
//

import Foundation
import SwiftUI

struct OrientationDetector: ViewModifier {
  @Binding var orientation: UIDeviceOrientation

  func body(content: Content) -> some View {
    content
      .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
        orientation = UIDevice.current.orientation
      }
  }
}

extension View {
  func detectOrientation(_ binding: Binding<UIDeviceOrientation>) -> some View {
    self.modifier(OrientationDetector(orientation: binding))
  }
}
