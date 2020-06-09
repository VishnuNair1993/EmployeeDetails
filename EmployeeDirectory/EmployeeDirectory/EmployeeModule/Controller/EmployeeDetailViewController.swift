//
//  EmployeeDetailViewController.swift
//  EmployeeDirectory
//
//  Created by Vishnu Nair on 09/06/20.
//  Copyright © 2020 Vishnu Nair. All rights reserved.
//

import UIKit

class EmployeeDetailViewController: UIViewController {
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var lblEmail : UILabel!
    @IBOutlet weak var lblAddress : UILabel!
    @IBOutlet weak var lblPhone : UILabel!
    @IBOutlet weak var lblWebsite : UILabel!
    @IBOutlet weak var lblCompany : UILabel!
    @IBOutlet weak var profileImg : UIImageView!
    var employeeDetail:EmployeeResponse?
    var image: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = image {
            self.profileImg.image = image
             
        }
        lblName.text = employeeDetail?.name ?? "NA"
        lblUserName.text = employeeDetail?.username ?? "NA"
        lblEmail.text = employeeDetail?.email ?? "NA"
        lblAddress.text = employeeDetail?.address?.street ?? "NA"
        lblPhone.text = employeeDetail?.phone ?? "NA"
        lblWebsite.text = employeeDetail?.website ?? "NA"
        lblCompany.text = employeeDetail?.company?.name ?? "NA"
         
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
        self.profileImg.makeRounded()
        }
    }
}
