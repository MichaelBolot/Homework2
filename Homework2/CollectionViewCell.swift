//
//  CollectionViewCell.swift
//  Homework2
//
//  Created by Michael Bolot on 10/12/17.
//  Copyright © 2017 Michael Bolot. All rights reserved.
//

import UIKit
class CollectionViewCell: UICollectionViewCell {
    //Class for the cells in the CollectionView
    @IBOutlet weak var imageView: UIImageView!
    
    
    var picture: Picture?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    //configures the view cell using the url of the picture
    //ImageServices handles the fetching of the images
    func configure(picture: Picture) {
        self.picture = picture
        ImageService.shared.imageForURL(url: picture.url) { (image, url) in
            if url == self.picture?.url {
                self.imageView.image = image
            }
        }
    }
    
}

