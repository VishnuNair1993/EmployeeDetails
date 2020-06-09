//
//  EmployeeResponse.swift
//  EmployeeDirectory
//
//  Created by Vishnu Nair on 09/06/20.
//  Copyright © 2020 Vishnu Nair. All rights reserved.
//

import Foundation
struct EmployeeResponse: Codable {

    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let profileImage: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case profileImage = "profile_image"
        case address = "address"
        case phone = "phone"
        case website = "website"
        case company = "company"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        address = try values.decodeIfPresent(Address?.self, forKey: .address) as? Address
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        company = try values.decodeIfPresent(Company?.self, forKey: .company) as? Company
    }

    

}
