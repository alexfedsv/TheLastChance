//
//  MockImageHelper.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 29.10.2024.
//

import UIKit

final class MockImageHelper {
    static func getImageBase64String(imageName: String) -> String {
        guard let image = UIImage(named: imageName) else {
            print("[ERROR]: Image named \(imageName) not found.")
            return ""
        }
        guard let imageData = image.pngData() else {
            print("[ERROR]: Could not convert image to Data.")
            return ""
        }
        let base64String = imageData.base64EncodedString()
        return base64String
    }
}
