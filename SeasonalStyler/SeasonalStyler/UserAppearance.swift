//
//  UserAppearance.swift
//  SeasonalStyler
//
//  Created by Kiyomi Blackmun on 4/22/24.
//

import Foundation
import UIKit

struct UserAppearance: Codable {
    //initially wanted to Use UIColor, but it does not conform to Decodable
    let eyeColor: String
    let hairColor: String
    let skinColor: String
    let userFaceImageData: String //path used to create a URL to fetch the user's selfie image
 
    enum CodingKeys: String, CodingKey {
        case eyeColor
        case hairColor
        case skinColor
        case userFaceImageData
    }

}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let userDefaults = UserDefaults.standard
    private let userAppearanceKey = "UserAppearance"
    
    func saveUserAppearance(_ appearance: UserAppearance) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(appearance)
            userDefaults.set(data, forKey: userAppearanceKey)
        } catch {
            print("Error encoding user appearance: \(error.localizedDescription)")
        }
    }
    
    func loadUserAppearance() -> UserAppearance? {
        guard let data = userDefaults.data(forKey: userAppearanceKey) else {return nil}
        do {
            let decoder = JSONDecoder()
            let appearance = try decoder.decode(UserAppearance.self, from: data)
            return appearance
        } catch {
            print("Error decoding user appearance: \(error.localizedDescription)")
            return nil
        }
    }
    
    func saveImage(_ image: UIImage, forKey key: String) {
            guard let data = image.jpegData(compressionQuality: 0.5) else { return }
            let encoded = try! PropertyListEncoder().encode(data)
            userDefaults.set(encoded, forKey: key)
    }
        
    func loadImage(forKey key: String) -> UIImage? {
            guard let data = userDefaults.data(forKey: key) else { return nil }
            let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
            return UIImage(data: decoded)
    }
}
