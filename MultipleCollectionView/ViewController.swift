//
//  ViewController.swift
//  MultipleCollectionView
//
//  Created by Yoga Pratama on 30/11/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    
    
    @IBOutlet var tableViewList : UITableView!
     let store = DataStore.sharedInstance
    
    var musicList : [Music] = []
    var coverList : [UIImage] = []
    var Count : Int = 0
    
    static let sharedInstance = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       //tableViewList.rowHeight = 44
      // tableViewList.estimatedRowHeight = 150
        
         NotificationCenter.default.addObserver(self, selector: #selector(loadList), name:NSNotification.Name(rawValue: "load"), object: nil)
        
        store.getCoverImages {
            print("data music complete")
         //   self.musicList = self.store.musicList
           // self.coverList = self.store.musicAlbum
          //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            
            self.store.getPoster {
                print("data film complete")
                print("poster : \(self.store.moviePoster.count)")
                
                self.store.getCover {
                    print("data book complete")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                }
                
            }
        }
        
       
        
        
    }


}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
          return "Top Tracks In AppleMusic"
        case 1:
          return  "Top Film In Itunes"
        case 2 :
          return "Top Book In Books"
        default:
          return ""
        }
        
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        Count += 1
        
        
        print("index: \(Count)")
       if  Count == 1 {
           cell.count = Count
           cell.collView.reloadSections(IndexSet(integer: 0))
        }else if Count == 2 {
             cell.count = Count
            cell.collView.reloadSections(IndexSet(integer: 0))
       }else if Count == 3 {
            cell.count = Count
            cell.collView.reloadSections(IndexSet(integer: 0))
        }
        
        if  Count == indexPath.row
        {
            Count = 0
        }
        
        
        return cell
    }
    
    
    
    @objc func loadList(notification: NSNotification){
        //self.favoritesCV.reloadData()
      //  self.collView.reloadSections(IndexSet(integer: 0))
        self.tableViewList.reloadData()
        Count = 0
        print("reload data")
    }
    
    
}



