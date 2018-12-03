//
//  DataStore.swift
//  MultipleCollectionView
//
//  Created by Yoga Pratama on 30/11/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation
import UIKit
import CoreData

final class DataStore{
    static let sharedInstance = DataStore()
    fileprivate init(){}
    
    var musicList : [Music] = []
    var musicListObj: [Music] = []
    var musicAlbum: [UIImage] = []
    var filmList : [Film] = []
    var moviePoster : [UIImage] = []
    var bookList : [Book] = []
    var bookCover : [UIImage] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getDataMusic(completion: @escaping () -> Void){
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MusicCore")
        
  /*  let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "MusicCore")
       let requestdel = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do{
            try context.execute(requestdel)}
        catch let error as NSError{
            
        } */
    
        do{
           let result = try context.fetch(request)
            for data in result as! [MusicCore]{
                
                let musicData : [String : Any] = [
                    "artistName" : data.artistName,
                    "name"       : data.name,
                    "kind"       : data.kind,
                    "artworkUrl100" : data.artworkUrl100
                ]
                
                print("\(data.artworkUrl100)")
                
                let  musicLists = Music(dictionary: musicData)
                self.musicList.append(musicLists)
                
                let image = UIImage(data: data.imageData!)
                self.musicAlbum.append(image!)
            }
            completion()
           
        }catch let error as NSError{
            print("Error Fetching Core Data : \(error.localizedDescription)")
        }
        
        if  musicList.count == 0 {
            API.getMusicAPI{ (json) in
                let feed = json?["feed"] as? MusicJSON
                if let results = feed?["results"] as? [MusicJSON]{
                    
                    ///saving to core data
                   
                    
                    for dict in results{
                        let  musicLists = Music(dictionary: dict)
                        self.musicList.append(musicLists)
                        
                        
                        let entity = NSEntityDescription.entity(forEntityName: "MusicCore", in: context)
                        let newMusic = NSManagedObject(entity: entity!, insertInto: context)
                        
                        let url = URL(string: musicLists.artworkUrl100)
                        let imageData = try? Data(contentsOf: url!)
                        newMusic.setValue(musicLists.artistName, forKey: "artistName")
                        newMusic.setValue(musicLists.name, forKey: "name")
                        newMusic.setValue(musicLists.kind, forKey: "kind")
                        newMusic.setValue(musicLists.artworkUrl100, forKey: "artworkUrl100")
                        newMusic.setValue(imageData, forKey: "imageData")
                        
                        do{
                            print("saving datacore....")
                         //try context.save()
                        }catch(let error as NSError){
                            print("Error saving data \(error.localizedDescription)")
                        }
                    }
                    
                    //save core data
                    
                   
                    completion()
                }
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
                 //   let image = UIImage(data: imageData)
                //    self.musicAlbum.append(image!)
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
