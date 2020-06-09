//
//  Resources.swift
//  EmployeeDirectory
//
//  Created by Vishnu Nair on 09/06/20.
//  Copyright © 2020 Vishnu Nair. All rights reserved.
//

import Foundation
enum HttpMethod : String{
    case get = "GET"
    case post = "POST"
}

struct Resources <T : Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
    var header:[String:String]? = nil
}
extension Resources{
    init(url: URL) {
        self.url = url
    }
}
