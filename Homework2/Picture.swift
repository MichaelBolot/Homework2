//
//  Picture.swift
//  Homework2
//
//  Created by Michael Bolot on 10/11/17.
//  Copyright © 2017 Michael Bolot. All rights reserved.
//

import Foundation
class Picture{
    //Stores values necessary to form a url, as well as the title
    let farm : Int
    let server: String
    let id: String
    let secret: String
    let title: String
    let url: URL
    
    init(dictionary: [String: Any]){
        //uses one constructor for brevity
        self.farm = dictionary["farm"] as! Int
        self.server = dictionary["server"] as! String
        self.id = dictionary["id"] as! String
        self.secret = dictionary["secret"] as! String
        let urlString: String = "https://farm" + String(self.farm) + ".static.flickr.com/" + self.server + "/" + self.id + "_" + self.secret + ".jpg"
        self.url = URL(string: urlString)!
        let title: String? = dictionary["title"] as? String
        self.title = title ?? "default title" //I have not seen "default title" ever used
    }
}
