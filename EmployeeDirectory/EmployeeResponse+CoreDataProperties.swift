//
//  EmployeeResponse+CoreDataProperties.swift
//  EmployeeDirectory
//
//  Created by Vishnu Nair on 09/06/20.
//  Copyright © 2020 Vishnu Nair. All rights reserved.
//
//

import Foundation
import CoreData


extension EmployeeResponse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeResponse> {
        return NSFetchRequest<EmployeeResponse>(entityName: "EmployeeResponse")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var username: String?
    @NSManaged public var email: String?
    @NSManaged public var profileImage: String?
    @NSManaged public var phone: String?
    @NSManaged public var website: String?
    @NSManaged public var address: Address?
    @NSManaged public var company: Company?

}
