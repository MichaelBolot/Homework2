//
//  CollectionViewController.swift
//  Homework2
//
//  Created by Michael Bolot on 10/12/17.
//  Copyright © 2017 Michael Bolot. All rights reserved.
//

import UIKit
class CollectionViewController: UIViewController{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var pictures: [Picture] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        fetchData()
    }
    
    //handles the "custom" animation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "transitionSegue"{
            
            //fetches the necessary data from the individual Cell so that the right picture
            //can be displayed by the pictureViewController
            let pictureViewController = segue.destination as? PictureViewController
            let collectionCell = sender as! CollectionViewCell
            pictureViewController!.picture = collectionCell.picture
        }
    }
    func fetchData(){
        let url = URL(string: "https://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags=daffodil&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")!
        print("Test")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url){(data, response, err) in
            let data = data!
            
            //parses the json files to get to the individual photo metadata
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            let array = json as! [String: Any]
            let prephotos = array["photos"] as! [String: Any]
            let photos = prephotos["photo"] as! [[String: Any]]
            
            for photo in photos{
                self.pictures.append(Picture(dictionary: photo))
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(picture: pictures[indexPath.item])
        return cell
    }
    
    
}

