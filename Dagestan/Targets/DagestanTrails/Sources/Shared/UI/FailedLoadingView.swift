//
//  FailedLoadingView.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 30.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

/// Вьюшка для отображении при нудачной загрузке данных
struct FailedLoadingView: View {
    let completion: (() -> Void)?

    var body: some View {
        VStack(alignment: .center) {
            Text("Не удалось загрузить информацию")
                .font(.manropeRegular(size: Grid.pt18))
            WFButton(title: "Попробовать снова", size: .m, type: .primary) {
                completion?()
            }
            .padding(.horizontal, Grid.pt20)
        }
    }
}
