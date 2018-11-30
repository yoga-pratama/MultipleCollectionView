//
//  Music.swift
//  MultipleCollectionView
//
//  Created by Yoga Pratama on 30/11/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation


struct Music {
    let artistName : String
    let name  : String
    let kind  : String
    let artworkUrl100 : String
    
    init(dictionary: MusicJSON ) {
        self.artistName = dictionary["artistName"] as! String
        self.name  = dictionary["name"] as! String
        self.kind  = dictionary["kind"] as! String
        self.artworkUrl100 = dictionary["artworkUrl100"] as! String
    }
}
