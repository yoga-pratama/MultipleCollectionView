//
//  Book.swift
//  MultipleCollectionView
//
//  Created by Yoga Pratama on 03/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation



struct  Book {
    let artistName : String
    let name  : String
    let kind  : String
    let artworkUrl100 : String
    
    init(dictionary: bookJSON ) {
        self.artistName = dictionary["artistName"] as! String
        self.name  = dictionary["name"] as! String
        self.kind  = dictionary["kind"] as! String
        self.artworkUrl100 = dictionary["artworkUrl100"] as! String
    }
}
