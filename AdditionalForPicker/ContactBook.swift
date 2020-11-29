//
//  ContactBook.swift
//  AdditionalForPicker
//
//  Created by Korlan Omarova on 30.11.2020.
//

import Foundation
import Realm
import RealmSwift

class ContactBook: Object{
    @objc dynamic var name = ""
    @objc dynamic var number = ""
    @objc dynamic var image: NSData?
}
