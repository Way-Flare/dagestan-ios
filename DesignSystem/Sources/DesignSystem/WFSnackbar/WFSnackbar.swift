//
//  SwiftUIView.swift
//
//
//  Created by Рассказов Глеб on 22.06.2024.
//

import SwiftUI

public struct WFSnackbar: View {
    public let status: Status

    public init(status: Status) {
        self.status = status
    }
    
    public var body: some View {
        HStack(spacing: Grid.pt12) {
            status.icon
                .resizable()
                .frame(width: Grid.pt24, height: Grid.pt24)
                .foregroundColor(status.color)
            Text(status.text)
                .foregroundStyle(WFColor.iconPrimary)
                .font(.manropeRegular(size: Grid.pt16))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Grid.pt12)
        .background(WFColor.surfacePrimary)
        .cornerStyle(.constant(Grid.pt12))
        .shadow(radius: Grid.pt4)
    }
}

public extension WFSnackbar {
    enum Status {
        case success(text: String)
        case error(text: String)
        case warning(text: String)

        var icon: Image {
            switch self {
            case .success:
                return Image(systemName: "checkmark.circle.fill")
            case .error:
                return Image(systemName: "xmark.circle.fill")
            case .warning:
                return Image(systemName: "exclamationmark.triangle.fill")
            }
        }

        var color: Color {
            switch self {
            case .success:
                return WFColor.successPrimary
            case .error:
                return WFColor.errorPrimary
            case .warning:
                return WFColor.warningPrimary
            }
        }

        var text: String {
            switch self {
            case let .success(text), let .error(text), let .warning(text):
                return text
            }
        }
    }
}

#Preview {
    WFSnackbar(status: .success(text: "Адрес скопирован!"))
}
