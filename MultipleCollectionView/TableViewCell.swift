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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collView.delegate = self
        self.collView.dataSource = self
        
        store.getCoverImages {
            self.collView.reloadSections(IndexSet(integer: 0))
        }
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.musicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collViewCell", for: indexPath) as! CollectionViewCell
        
        let music = store.musicList[indexPath.row]
     //   cell.label.text = "TEST LABEL \(indexPath.row)"
      //  cell.image.image =  UIImage(named: "4.jpeg")
        cell.image.image = store.musicAlbum[indexPath.row]
        cell.title.text =  music.artistName
        cell.detail.text = music.name
        cell.image.layer.cornerRadius = 5
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: 100, height: 200)
        return size
    }
    
   
    
   
    

}
