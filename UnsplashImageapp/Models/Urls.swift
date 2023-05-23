//
//  Urls.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/23.
//

import Foundation

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
