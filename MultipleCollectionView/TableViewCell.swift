//
//  TableViewCell.swift
//  MultipleCollectionView
//
//  Created by Yoga Pratama on 30/11/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell ,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet var collView : UICollectionView!
    let store = DataStore.sharedInstance
    let vc = ViewController.sharedInstance
    var count : Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collView.delegate = self
        self.collView.dataSource = self
        
        print("enter collection view")
        
       // self.collView.reloadSections(IndexSet(integer: 0))
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
     /*   switch count {
        case 1:
            print("music list : \(store.musicList.count)")
            return store.musicList.count
        case 2 :
            print("film list : \(store.filmList.count)")
            return store.filmList.count
        default:
          break
        } */
       return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collViewCell", for: indexPath) as! CollectionViewCell
        
        print("enter CollectionView")
        print("vc \(count)")
        switch count {
        case 1:
             if  store.musicList.count != 0 {
                let music = store.musicList[indexPath.row]
                //   cell.label.text = "TEST LABEL \(indexPath.row)"
                //  cell.image.image =  UIImage(named: "4.jpeg")
                cell.image.image = store.musicAlbum[indexPath.row]
                cell.title.text =  music.name
                cell.detail.text = music.artistName
                cell.image.layer.cornerRadius = 10
             }
         
        case 2 :
           if store.filmList.count != 0 && store.moviePoster.count != 0{
                let film = store.filmList[indexPath.row]
            print("moviePoster : \(store.moviePoster)")
                cell.image.image = store.moviePoster[indexPath.row]
                cell.title.text =  film.name
                cell.detail.text = film.artistName
                cell.image.layer.cornerRadius = 5
           }
        
        case 3 :
            if store.bookList.count != 0 {
                let book = store.bookList[indexPath.row]
                cell.image.image = store.bookCover[indexPath.row]
                cell.title.text =  book.name
                cell.detail.text = book.artistName
                cell.image.layer.cornerRadius = 5
            }
        default: break
           
        }
     
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: 200, height: 250)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        print(cell.title.text)
        print(cell.detail.text)
        
    }
    
    
   
  

}
