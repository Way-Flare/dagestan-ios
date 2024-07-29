//
//  FileManagerUtil.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 28.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import UIKit

struct FileManagerHelper {
    static let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!

    static func saveImage(_ data: Data, withName name: String) -> Bool {
        let filePath = cacheDirectory.appendingPathComponent(name)
        do {
            try data.write(to: filePath)
            return true
        } catch {
            print("Failed to save image: \(error)")
            return false
        }
    }

    static func loadImage(withName name: String) -> UIImage? {
        let filePath = cacheDirectory.appendingPathComponent(name)
        guard let imageData = try? Data(contentsOf: filePath) else { return nil }
        return UIImage(data: imageData)
    }

    static func imageSize(withName name: String) -> Int? {
        let filePath = cacheDirectory.appendingPathComponent(name)
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: filePath.path)
            if let fileSize = attributes[.size] as? NSNumber {
                return fileSize.intValue
            }
        } catch {
            print("Error getting file size: \(error)")
        }
        return nil
    }

    static func imageExists(withName name: String) -> Bool {
        let path = cacheDirectory.appendingPathComponent(name)
        return FileManager.default.fileExists(atPath: path.path)
    }
}
