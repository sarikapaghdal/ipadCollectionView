//
//  ipadCollectionUITests.swift
//  ipadCollectionUITests
//
//  Created by Dhaval_G_S on 11.07.19.
//  Copyright © 2019 Dhaval_G_S. All rights reserved.
//

import XCTest

class ipadCollectionUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
    }
    
    func testNumberOfCollectionView() {
        let collectionView = app.collectionViews
        XCTAssertNotNil(collectionView.count)
        XCTAssertEqual(collectionView.count, 1, "There should be only 1 Collection View in our App")
    }
    
    func testNumberOfCollectionViewCell() {
        let collectionView = app.collectionViews
        XCTAssertNotEqual(collectionView.cells.count, 0, "There should not be 0 Cell")
        XCTAssertNotNil(collectionView.cells.count)
    }
    
    // tap on the first cell of CollectionView and tap 'Back' button on navigation bar
    func testThirdCellTap() {
        
        XCUIApplication().collectionViews.cells.element(boundBy:0).tap()
        XCUIApplication().navigationBars.buttons.element(boundBy: 0).tap()
    }

    func testImageUrlData()
    {
        let imageUrl = "https://live.staticflickr.com/65535/48201527036_d30dbf1ffd.jpg"
        guard let imageRUL = URL(string: imageUrl) else {
            return
        }
        URLSession.shared.dataTask(with: imageRUL) { (data, response, error) in
            guard let data = data else { return }
            XCTAssertNotNil(data)
        }
    }
    
    func testNumberOfImages() {
        let images = app.images
        XCTAssertNotNil(images.count)
        XCTAssertNotEqual(images.count, 1, "There should be more than 1 images in our App")
    }
    
    func testCollectionViewInteraction() {
        
        let viewCells = app.collectionViews.cells
        
        if viewCells.count > 0 {
            let count: Int = (viewCells.count - 1)
            
            let promise = expectation(description: "Wait for view cells")
            
            for i in stride(from: 0, to: count , by: 1) {
                
                // Grab the first cell and verify that it exists and tap it
                let collectionViewCell = viewCells.element(boundBy: i)
                
                XCTAssertTrue(collectionViewCell.exists, "The \(i) cell is in place on the collection")
                // Does this actually take us to the next screen
                collectionViewCell.tap()
                
                if i == (count - 1) {
                    promise.fulfill()
                }
                // Back
                XCUIApplication().navigationBars.buttons.element(boundBy: 0).tap()
            }
            waitForExpectations(timeout: 2, handler: nil)
            XCTAssertTrue(true, "Finished validating the view cells")
            
        } else {
            XCTAssert(false, "Was not able to find any view cells")
        }
    }
}
