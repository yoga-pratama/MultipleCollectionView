//
//  DataStore.swift
//  MultipleCollectionView
//
//  Created by Yoga Pratama on 30/11/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation
import UIKit

final class DataStore{
    static let sharedInstance = DataStore()
    fileprivate init(){}
    
    var musicList : [Music] = []
    var musicAlbum: [UIImage] = []
    
    func getData(completion: @escaping () -> Void){
        API.getMusicAPI{ (json) in
            let feed = json?["feed"] as? MusicJSON
            if let results = feed?["results"] as? [MusicJSON]{
                for dict in results{
                    let  musicLists = Music(dictionary: dict)
                    self.musicList.append(musicLists)
                }
                completion()
            }
        }
    }
    
    func getCoverImages(completion : @escaping () -> Void){
        getData {
            for data in self.musicList{
                let url = URL(string: data.artworkUrl100)
                let data2 = try? Data(contentsOf: url!)
                if let imageData = data2{
                    print("receiving image.....")
                    let image = UIImage(data: imageData)
                    self.musicAlbum.append(image!)
                }
            }
            
            OperationQueue.main.addOperation {
                completion()
            }
        }
    }
}
