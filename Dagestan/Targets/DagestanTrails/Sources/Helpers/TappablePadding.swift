//
//  TappablePadding.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 06.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct TappablePadding: ViewModifier {
  let insets: EdgeInsets
  let onTap: () -> Void
  
  func body(content: Content) -> some View {
    content
      .padding(insets)
      .contentShape(Rectangle())
      .onTapGesture {
        onTap()
      }
      .padding(insets.inverted)
  }
}

extension View {
  func tappablePadding(_ insets: EdgeInsets, onTap: @escaping () -> Void) -> some View {
    self.modifier(TappablePadding(insets: insets, onTap: onTap))
  }
}

extension EdgeInsets {
  var inverted: EdgeInsets {
    .init(top: -top, leading: -leading, bottom: -bottom, trailing: -trailing)
  }
    
    init(all: CGFloat) {
        self.init(top: all, leading: all, bottom: all, trailing: all)
    }
    
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
