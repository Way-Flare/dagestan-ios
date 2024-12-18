//
//  NoFeatureAlert.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 04.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct NoFeatureAlert: ViewModifier {
    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        content
            .alert("Этого функционала еще нет :(", isPresented: $isPresented) {
                Button("Все, понял, жду!", role: .cancel) {}
            } message: {
                Text("Чуть-чуть сабур делай")
            }
    }
}

extension View {
    func noFeatureAlert(isPresented: Binding<Bool>) -> some View {
        self.modifier(NoFeatureAlert(isPresented: isPresented))
    }
}
