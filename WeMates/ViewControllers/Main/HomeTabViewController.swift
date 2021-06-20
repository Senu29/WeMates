//
//  HomeTabViewController.swift
//  
//
//  Created by Senuda Ratnayake on 6/10/21.
//

import UIKit
import Parse
import AlamofireImage

class HomeTabViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var bubbles = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //retrive data stored in Parse
        callinData()
        self.collectionView.reloadData()
        print(bubbles)
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bubbles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpaceCollectionViewCell", for: indexPath) as! SpaceCollectionViewCell
//        cell.bubbleNameLabel.text = bubbles["bubbleName"] as? String
//
//        let imageFile = bubbles["postImage"] as! PFFileObject
//        let urlString = imageFile.url!
//        let url = URL(string: urlString)!
//
//        cell.recipeImageView.af_setImage(withURL: url)
        return cell
    }
    
    func callinData(){
        let query = PFQuery(className:"Bubbles")
        query.includeKeys(["admin"])
        query.limit = 20
        
        query.findObjectsInBackground { (bubbles, error) in
            if bubbles != nil{
                self.bubbles = bubbles!
                print("count", bubbles!.count)
                self.collectionView.reloadData()
//                print(bubbles as Any)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
