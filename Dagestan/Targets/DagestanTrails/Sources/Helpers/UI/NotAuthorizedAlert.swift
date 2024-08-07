//
//  NotAuthorizedAlert.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 07.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct NotAuthorizedAlert: ViewModifier {
    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        content
            .alert("Вы не авторизованы", isPresented: $isPresented) {
                Button("Понял принял обработал", role: .cancel) {}
            } message: {
                Text("Перейди, по-братски, на вкладку ‘Профиль’ и авторизуйся")
            }
    }
}

extension View {
    func notAutorizedAlert(isPresented: Binding<Bool>) -> some View {
        self.modifier(NotAuthorizedAlert(isPresented: isPresented))
    }
}
