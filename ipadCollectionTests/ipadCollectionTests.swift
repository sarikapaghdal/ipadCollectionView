//
//  ipadCollectionTests.swift
//  ipadCollectionTests
//
//  Created by Dhaval_G_S on 11.07.19.
//  Copyright © 2019 Dhaval_G_S. All rights reserved.
//

import XCTest
@testable import ipadCollection

class ipadCollectionTests: XCTestCase {
    
    override func setUp() {
    }

    override func tearDown() {
    }

    func testViewControllerInitialized() {
        let mainViewController = ListViewController()
        XCTAssertNotNil(mainViewController)
        XCTAssertNoThrow(mainViewController)
    }

    func testListViewModelInitialization(){
        let viewController = ListViewController()
        XCTAssertNoThrow(ListViewModel(viewController))
    }
    
    func testDetailViewModelInitialization(){
        let viewController = DetailViewController()
        XCTAssertNoThrow(DetailViewModel(viewController))
    }
    
    func testflickrURLFromParameters() {
        
        let searchString = "rose,flower"
        
        // Build base URL
        var components = URLComponents()
        components.scheme = Constants.FlickrURLParams.APIScheme
        components.host = Constants.FlickrURLParams.APIHost
        components.path = Constants.FlickrURLParams.APIPath
        
        // Build query string
        components.queryItems = [URLQueryItem]()
        
        // Query components
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.APIKey, value: Constants.FlickrAPIValues.APIKey));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.SearchMethod, value: Constants.FlickrAPIValues.SearchMethod));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.ResponseFormat, value: Constants.FlickrAPIValues.ResponseFormat));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.Extras, value: Constants.FlickrAPIValues.MediumURL));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.SafeSearch, value: Constants.FlickrAPIValues.SafeSearch));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.DisableJSONCallback, value: Constants.FlickrAPIValues.DisableJSONCallback));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.Text, value: searchString));
        
        XCTAssertNotNil(components.url!)
        XCTAssertNoThrow(components.url!)
        
        let session = URLSession.shared
        let task = session.dataTask(with: components.url!) { (data, response, error) in
            guard let data = data else { return }
            XCTAssertNotNil(data)
            do{
                let resulData = try JSONDecoder().decode(Results.self, from: data)
                XCTAssertNotNil(resulData)
                
                let photosAre = resulData.photos
                XCTAssertNotNil(photosAre)
                
                if let finalPhoto = photosAre?.photo {
                    XCTAssertNotNil(finalPhoto)
                    
                    for (_, element) in finalPhoto.enumerated() {
                        XCTAssertNotNil(element)
                        XCTAssertNotNil(element.urlString)
                    }
                }
        }
        catch let jsonError{
                print("can't serialize data", jsonError)}
        }
        task.resume()
    }
}
