//
//  CollectionObject_Tests.swift
//  Rijksmuseum_Tests
//
//  Created by Filipe Donadio on 15/05/2023.
//

import XCTest
@testable import Rijksmuseum

final class CollectionObject_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_CollectionObject_id_shouldBeEqualObjectNumber() {
        // When
        let collection = CollectionObject.testData
        
        // Then
        XCTAssertEqual(collection.objectNumber, collection.id)
    }
    
    func test_CollectionObject_updateFavorite_shouldToggleIsFavorite() {
        for _ in 0..<10 {
            // Given
            let isFavorite = Bool.random()
            let collection: CollectionObject = CollectionObject(
                objectNumber: "en-SK-A-1718",
                title: "Winter Landscape with Ice Skaters",
                principalOrFirstMaker: "Hendrick Avercamp",
                webImage: WebImage.testData,
                isFavorite: isFavorite
            )
            
            // When
            let updatedCollection = collection.updateFavorite()
            
            // Then
            XCTAssert(updatedCollection.isFavorite == !isFavorite)
        }
    }
}
