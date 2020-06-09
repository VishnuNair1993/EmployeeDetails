//
//  Address+CoreDataClass.swift
//  EmployeeDirectory
//
//  Created by Vishnu Nair on 09/06/20.
//  Copyright © 2020 Vishnu Nair. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Address)
public class Address: NSManagedObject ,Codable{
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(street, forKey: .street)
        try container.encodeIfPresent(suite, forKey: .suite)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(zipcode, forKey: .zipcode)
    }
    enum CodingKeys: String, CodingKey {
        case street = "street"
        case suite = "suite"
        case city = "city"
        case zipcode = "zipcode"
        //case geo = "geo"
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Address", in: managedObjectContext)
            else {
                fatalError("decode failure Address")
        }
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        suite = try values.decodeIfPresent(String.self, forKey: .suite)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        zipcode = try values.decodeIfPresent(String.self, forKey: .zipcode)
        //geo = try values.decode(Geo.self, forKey: .geo)
    }
}
