//
//  LocateMeButton.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 22.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import MapboxMaps
import SwiftUI
import DesignSystem

@available(iOS 14.0, *)
struct LocateMeButton: View {
    @Binding var viewport: Viewport

    var body: some View {
        Button {
            withViewportAnimation(.default(maxDuration: 1)) {
                if isFocusingUser {
                    viewport = .followPuck(zoom: 16.5, bearing: .heading, pitch: 60)
                } else if isFollowingUser {
                    viewport = .idle
                } else {
                    viewport = .followPuck(zoom: 13, bearing: .constant(0))
                }
            }
        } label: {
            Image(systemName: imageName)
                .transition(.scale.animation(.easeOut))
                .foregroundStyle(WFColor.iconAccent)
                .padding()
        }
        .safeContentTransition()
    }

    private var isFocusingUser: Bool {
        return viewport.followPuck?.bearing == .constant(0)
    }

    private var isFollowingUser: Bool {
        return viewport.followPuck?.bearing == .heading
    }

    private var imageName: String {
        if isFocusingUser {
            return  "location.fill"
        } else if isFollowingUser {
            return "location.north.line.fill"
        }
        return "location"

    }
}

@available(iOS 13.0, *)
private extension View {
    func safeContentTransition() -> some View {
        if #available(iOS 17, *) {
            return self.contentTransition(.symbolEffect(.replace))
        }
        return self
    }
}
