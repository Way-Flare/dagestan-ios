//
//  Data+append.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation
import UniformTypeIdentifiers


extension Data {
    mutating func appendString(string: String) {
        guard let data = string.data(using: .utf8, allowLossyConversion: true) else { return }
        append(data)
    }
}

func mimeType(for fileUrl: URL) -> String {
    let pathExtension = fileUrl.pathExtension

    guard let utType = UTType(filenameExtension: pathExtension) else {
        return "application/octet-stream"
    }

    return utType.preferredMIMEType ?? "application/octet-stream"
}
