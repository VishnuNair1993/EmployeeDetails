//
//  Company+CoreDataProperties.swift
//  EmployeeDirectory
//
//  Created by Vishnu Nair on 09/06/20.
//  Copyright © 2020 Vishnu Nair. All rights reserved.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String?
    @NSManaged public var catchPhrase: String?
    @NSManaged public var bs: String?

}
