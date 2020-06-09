//
//  ImageDownloaderManager.swift
//  EmployeeDirectory
//
//  Created by Vishnu Nair on 09/06/20.
//  Copyright © 2020 Vishnu Nair. All rights reserved.
//

import UIKit
typealias CompletionHandlerImage = (_ image:UIImage) -> Void

class ImageDownloaderManager {
    static let shared = ImageDownloaderManager()
    private init(){}
    let session = URLSession.shared
    func downloadImage(imgUrl:String , onResponse: @escaping (UIImage) -> Void) {
        guard let url = URL(string: imgUrl) else {return}
        session.dataTask(with: url) { (data, statuResponse, error) in
            if let data = data {
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else {return}
                    onResponse(image)
                }
                
            }else{
                print("ERRRROOORRRRRRRR   :  \n error =  \(String(describing: error ))   \n   imgUrl = \(imgUrl) \n")
                onResponse(UIImage.noImageFound!)
                
            }
            }.resume()
    }
    
}
class FetchImage{
    static let shared = FetchImage()
    let imageCache = NSCache<NSString,UIImage>()
    
    func getImage(imageUrl:String?,completion:@escaping CompletionHandlerImage)   {
        guard let imageUrl = imageUrl else{
            completion(UIImage(named: "img_image_not_found")!)
            return
        }
        if let cachedImage = imageCache.object(forKey: imageUrl as NSString){
            DispatchQueue.main.async {
                completion(cachedImage)
            }
        }
        else
        {
            ImageDownloaderManager.shared.downloadImage(imgUrl: imageUrl) { (downloadedImage) in
                DispatchQueue.main.async {
                    self.imageCache.setObject(downloadedImage, forKey: imageUrl as NSString)
                    completion(downloadedImage)
                }
            }
            
            
            
        }
    }
    
}

extension UIImage
{
    static let loadingImage = UIImage(named: "img_image_loading")
    static let noImageFound = UIImage(named: "img_image_not_found")
}
