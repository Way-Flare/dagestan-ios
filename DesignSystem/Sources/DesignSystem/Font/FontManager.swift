//
//  FontManager.swift
//
//  Created by Abdulaev Ramazan on 07.05.2024.
//

import CoreText
import Foundation

public struct FontManager {
    public static func registerFonts() {
        let bundle = Bundle.module
        let fontUrls = [
            "Manrope-ExtraBold.ttf",
            "Manrope-Regulard.ttf",
            "Manrope-SemiBold"
        ].compactMap { bundle.url(forResource: $0, withExtension: nil) }

        fontUrls.forEach { url in
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}
