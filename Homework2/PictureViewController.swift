//
//  PictureViewController.swift
//  Homework2
//
//  Created by Michael Bolot on 10/15/17.
//  Copyright © 2017 Michael Bolot. All rights reserved.
//
//Class for the PictureViewController that comes up when you select an image

import UIKit

class PictureViewController: UIViewController{
    //Class for the Enlarged view of each picture
    
    @IBOutlet weak var imageTitle: UILabel!
    var picture: Picture?
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageService.shared.imageForURL(url: picture?.url) { (image, url) in
            self.imageView.image = image
        }
        self.imageTitle.text = picture?.title
    }
    
    
}
