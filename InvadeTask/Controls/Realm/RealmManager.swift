//
//  RealmManager.swift
//  FootballLeague
//
//  Created by Adam on 10/16/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    private init(){}
    static var shared = RealmManager()
    enum AddResult {
        case success, fail
    }
    
    typealias addRealmObjectCompletionType = (AddResult)-> ()
    
    func addObject(realmObject: Object, andCompletion compleion: addRealmObjectCompletionType){
        do { let realm = try Realm()
            try realm.write {
                realm.add(realmObject)
                compleion(.success)
            }
        }
        catch {
            print(error)
            compleion(.fail)
        }
    }
    
    func getObjectOf<T>(type : T.Type) -> [T] where T: Object {
        do { let realm = try Realm()
            let result = realm.objects(type)
            return Array(result)
        }
        catch {
            print(error)
            return []
        }
    }
    
   func removeObject(realmObject: Object, andCompletion compleion: addRealmObjectCompletionType){
        do { let realm = try Realm()
            try realm.write {
                realm.delete(realmObject)
                compleion(.success)
            }
        }
        catch {
            print(error)
            compleion(.fail)
        }
    }
    
    
    func convertRealmListToArray<T>(list: List<T>) -> [T] {
        
        do {
            let realm = try Realm()
            let realmObjects = realm.objects(RealmListingModel.self)
            let realmObjectsArray = Array(list)
            return realmObjectsArray
            // Now realmObjectsArray contains your Realm objects as a Swift array
            print(realmObjectsArray)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        return Array(list)
    }

    // Usage:

    

}
