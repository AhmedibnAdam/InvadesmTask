//
//  TestRealmManager.swift
//  InvadeMSTaskTests
//
//  Created by Ahmad on 05/05/2024.
//

import XCTest
@testable import InvadeMSTask

class TestRealmManager: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        // Use an in-memory Realm for testing

    }

    
    func testAddObjectSuccess() {
        // Given
        let realmMock = RealmManager.shared // Assuming you have a mock for Realm
        
        let objectToAdd = RealmListTest()
        let realmList = RealmListingModelTest()
        realmList.alphaTwoCode = "item.alphaTwoCode!"
        realmList.name =  "item.name!"
        realmList.country = "item.country!"
        objectToAdd.list.append(realmList)
        
        let sut = RealmManager.shared
        
        // When
        sut.addObject(realmObject: objectToAdd) { result in
            // Then
            XCTAssertEqual(result, .success) // Assert that the completion is success
            
        }
    }
        
        
}
