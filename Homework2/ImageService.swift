//
//  ImageService.swift
//  Homework2
//
//  Created by Michael Bolot on 10/14/17.
//  Copyright © 2017 Michael Bolot. All rights reserved.
//

import UIKit

class ImageService {
    //Class fetches the images when needed
    
    static var shared = ImageService()
    
    var cache:[URL:UIImage] = [:]
    //Cache for holding the images
    
    func imageForURL(url: URL?, completion: @escaping (UIImage?, URL?) -> ()) {
        guard let url = url else { completion(nil, nil); return }
        if let image = cache[url] {
            completion(image, url)
            return
        }
        let task = URLSession(configuration: .ephemeral).dataTask(with: url) { (data, response, error) in
            guard data != nil else { completion(nil, nil); return}
            if error != nil { completion(nil, nil); return }
            let image = UIImage(data: data!)
            if let img = image {
                self.cache[url] = img
            }
            DispatchQueue.main.async {
                completion(image, url)
            }
        }
        task.resume()
    }
    
}
