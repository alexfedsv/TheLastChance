//
//  PhotoHelper.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 22.11.2024.
//

import UIKit

final class PhotoHelper {
    static func getImageBase64String(imageData: Data?) -> String {
        guard let data = imageData else {
            print("[ERROR]: ImageData named is nil")
            return ""
        }
        let base64String = data.base64EncodedString()
        return base64String
    }
}
