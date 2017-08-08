//
//  AlbumsStruct.swift
//  test
//
//  Created by Artem Mkrtchyan on 8/8/17.
//  Copyright © 2017 Artem Mkrtchyan. All rights reserved.
//

import Foundation

struct Album {
    let id: String
    let name: String
    let coverPhotoId: String
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as! String
        self.name = dictionary["name"] as! String
        self.coverPhotoId = (dictionary["cover_photo"] as? Dictionary<String, Any>)?["id"] as? String ?? ""
    }
}
