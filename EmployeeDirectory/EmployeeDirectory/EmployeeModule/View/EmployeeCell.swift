//
//  EmployeeCell.swift
//  EmployeeDirectory
//
//  Created by Vishnu Nair on 09/06/20.
//  Copyright © 2020 Vishnu Nair. All rights reserved.
//

import UIKit
class EmployeeCell: UICollectionViewCell , ReusableView , NibLoadableView{
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var imageView : UIImageView!
    var image : UIImage?
//    var imgId:String?{
//        didSet{
//            guard let unwrappedImage = imgId else {return}
//            FetchImage.shared.getImage(imageUrl: unwrappedImage) { (image) in
//                DispatchQueue.main.async {
//                    self.imageView.image = image
//                }
//            }
//        }
//    }
    
    func setView(name : String? , image : UIImage?){
        self.image = image
        self.lblTitle.text = name ?? "NA"
        self.imageView.image = image ?? UIImage(named: "img_image_not_found")
         
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        DispatchQueue.main.async {
           self.imageView.image = UIImage.loadingImage
        }
    }
}

