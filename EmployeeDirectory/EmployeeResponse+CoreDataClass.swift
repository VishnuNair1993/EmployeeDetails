//
//  EmployeeResponse+CoreDataClass.swift
//  EmployeeDirectory
//
//  Created by Vishnu Nair on 09/06/20.
//  Copyright © 2020 Vishnu Nair. All rights reserved.
//
//

import Foundation
import CoreData

@objc(EmployeeResponse)
public class EmployeeResponse: NSManagedObject,Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(username, forKey: .username)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(profileImage, forKey: .profileImage)
        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(website, forKey: .website)
        try container.encodeIfPresent(company, forKey: .company)
    }
    enum CodingKeys: String, CodingKey {
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
    required convenience public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "EmployeeResponse", in: managedObjectContext)
            else {
                fatalError("decode failure EmployeeResponse")
        }
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: managedObjectContext)
        
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int64.self, forKey: .id) ?? 0
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
