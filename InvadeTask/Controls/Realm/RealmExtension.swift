//
//  RealmExtension.swift
//  FootballLeague
//
//  Created by Adam on 10/16/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//

import Foundation
import  RealmSwift

extension Object {
    func safeWrite (operation: ()->()){
        if let realm = realm {
            do {
                try realm.write {
                    operation()
                }
            }
            catch {
                print(error)
            }
        }
        else {
            operation()
        }
    }
}
