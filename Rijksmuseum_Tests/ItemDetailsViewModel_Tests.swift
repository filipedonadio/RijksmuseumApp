//
//  ItemDetailsViewModel_Tests.swift
//  Rijksmuseum_Tests
//
//  Created by Filipe Donadio on 15/05/2023.
//

import XCTest
@testable import Rijksmuseum

final class ItemDetailsViewModel_Tests: XCTestCase {
    
    var viewModel: ItemDetailsViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor func test_ItemDetailsViewModel_formattedObjectNumber_shouldBeExpectedValue() {
        // Given
        let testData = CollectionObject.testData
        
        // When
        let vm = ItemDetailsViewModel(collectionObject: testData, favoriteDataService: FavoriteDataService())
        let expectedOutput = "Object number: en-SK-A-1718"
        
        // Then
        XCTAssertEqual(vm.formattedObjectNumber, expectedOutput)
    }
    
    @MainActor func test_ItemDetailsViewModel_formatMultipleInformation_shouldBeExpectedValue() {
        // Given
        let materials = ["panel", "oil paint (paint)"]
        
        // When
        let vm = ItemDetailsViewModel(collectionObject: CollectionObject.testData, favoriteDataService: FavoriteDataService())
        let expectedOutput = "Panel, oil paint (paint)".capitalized
        
        // Then
        XCTAssertEqual(vm.formatMultipleInformation(materials), expectedOutput)
    }
}
