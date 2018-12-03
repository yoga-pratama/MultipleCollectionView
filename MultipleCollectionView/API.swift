//
//  API.swift
//  MultipleCollectionView
//
//  Created by Yoga Pratama on 30/11/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation

typealias  MusicJSON = [String:Any]
typealias  filmJSON = [String:Any]
typealias  bookJSON = [String:Any]
struct  API {
   
    
    static func getMusicAPI(completion : @escaping (MusicJSON?) -> Void){
        
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/id/apple-music/hot-tracks/all/10/explicit.json")
        
        let session = URLSession.shared
        
        guard let unwrappedURL = url else { print("Error unwrapping URL"); return }
        
        let dataTask = session.dataTask(with: unwrappedURL){(data,response , error) in
            
            guard let unwrappedDAta = data else { print("Error unwrapping data"); return }
            
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedDAta, options: []) as? MusicJSON
                
                
                completion(responseJSON)
            } catch {
                print("Could not get API data. \(error), \(error.localizedDescription)")
            }
            
        }
        dataTask.resume()
    }
    
    
    static func getFilmAPI(completion : @escaping (filmJSON?) -> Void){
        
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/id/movies/top-movies/all/10/explicit.json")
        
        let session = URLSession.shared
        
        guard let unwrappedURL = url else { print("Error unwrapping URL"); return }
        
        let dataTask = session.dataTask(with: unwrappedURL){(data,response , error) in
            
            guard let unwrappedDAta = data else { print("Error unwrapping data"); return }
            
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedDAta, options: []) as? filmJSON
                
                
                completion(responseJSON)
            } catch {
                print("Could not get API data. \(error), \(error.localizedDescription)")
            }
            
        }
        dataTask.resume()
    }
    
    static func getBookAPI(completion : @escaping (bookJSON?) -> Void){
        
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/id/books/top-free/all/10/explicit.json")
        
        let session = URLSession.shared
        
        guard let unwrappedURL = url else { print("Error unwrapping URL"); return }
        
        let dataTask = session.dataTask(with: unwrappedURL){(data,response , error) in
            
            guard let unwrappedDAta = data else { print("Error unwrapping data"); return }
            
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedDAta, options: []) as? bookJSON
                
                
                completion(responseJSON)
            } catch {
                print("Could not get API data. \(error), \(error.localizedDescription)")
            }
            
        }
        dataTask.resume()
    }
}
