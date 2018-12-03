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
    var filmList : [Film] = []
    var moviePoster : [UIImage] = []
    var bookList : [Book] = []
    var bookCover : [UIImage] = []
    
    func getDataMusic(completion: @escaping () -> Void){
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
        getDataMusic {
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
    
    
    func getDataFilm(completion: @escaping () -> Void){
        API.getFilmAPI{ (json) in
            let feed = json?["feed"] as? filmJSON
            if let results = feed?["results"] as? [filmJSON]{
                for dict in results{
                    let filmLists = Film(dictionary: dict)
                    self.filmList.append(filmLists)
                }
                completion()
            }
        }
    }
    
    func getPoster(completion : @escaping () -> Void){
        getDataFilm {
            for data in self.filmList{
                let url = URL(string: data.artworkUrl100)
                let data2 = try? Data(contentsOf: url!)
                if let imageData = data2{
                    print("receiving image.....")
                    let image = UIImage(data: imageData)
                    self.moviePoster.append(image!)
                }
            }
            
            OperationQueue.main.addOperation {
                completion()
            }
        }
    }
    
    
    func getBooks(completion: @escaping () -> Void){
        API.getBookAPI{ (json) in
            let feed = json?["feed"] as? bookJSON
            if let results = feed?["results"] as? [bookJSON]{
                for dict in results{
                    let  books = Book(dictionary: dict)
                    self.bookList.append(books)
                    
                }
                completion()
            }
        }
    }
    
    
    func getCover(completion : @escaping () -> Void){
        getBooks{
            for data in self.bookList{
                let url = URL(string: data.artworkUrl100)
                let data2 = try? Data(contentsOf: url!)
                if let imageData = data2{
                    print("receiving image.....")
                    let image = UIImage(data: imageData)
                    self.bookCover.append(image!)
                }
            }
            
            OperationQueue.main.addOperation {
                completion()
            }
        }
    }
}
