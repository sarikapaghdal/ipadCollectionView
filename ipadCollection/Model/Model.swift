//
//  Model.swift
//  ipadCollection
//
//  Created by Dhaval_G_S on 12.07.19.
//  Copyright © 2019 Dhaval_G_S. All rights reserved.
//

import UIKit

struct Photo: Codable {
    let farm: Int?
    let height: String?
    let id: String?
    let isfamily: Int?
    let isfriend: Int?
    let ispublic: Int?
    let owner: String?
    let secret: String?
    let server: String?
    let title: String?
    let urlString: String?
    let width : String?
    
    private enum CodingKeys: String, CodingKey {
        case urlString = "url_m"
        case width = "width_m"
        case height = "height_m"
        case farm, id, isfamily, isfriend, ispublic, owner, secret, server, title
    }
}

struct Results: Codable {
    let stat: String?
    let photos: Photos?
}

struct Photos: Codable {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let photo: [Photo]?
    let total: String?
}
