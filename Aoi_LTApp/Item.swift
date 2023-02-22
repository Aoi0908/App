//
//  Item.swift
//  Aoi_LTApp
//
//  Created by ひがしもとあおい on 2023/02/22.
//

import Foundation
import SwiftUI
import Firebase

struct Item: Codable {
    let name: String
    let description: String
}

class FirebaseManager{
    static let shared = FirebaseManager()
    
    
    private let database = Database.database().reference()
    
    func upload(items: [Item]) {
        let itemRef = database.child("items")
        for item in items {
            let itemRef = itemRef.childByAutoId()
            itemRef.setValue([
                "name": item.name,
                "description": item.description
            ])
        }
    }
}

