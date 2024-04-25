//
//  ContentView.swift
//  DKDesignSystem
//
//  Created by Рассказов Глеб on 26.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DagestanKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        MenuView<SwiftUIMenuItem, SwiftUIMenuRouter>()
    }
}

#Preview {
    ContentView()
}
