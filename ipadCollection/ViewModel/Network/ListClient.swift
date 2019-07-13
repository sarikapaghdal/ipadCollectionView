//
//  ListClient.swift
//  ipadCollection
//
//  Created by Dhaval_G_S on 12.07.19.
//  Copyright © 2019 Dhaval_G_S. All rights reserved.
//

import UIKit

class ListClient {
    
    let searchString = "rose,flower"
   
    func flickrURLFromParameters() -> URL? {
        
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
        
        return components.url!
    }
    
    func fetchDataFromURL(searchURL: URL, completion: @escaping (Result<Data, Error >) -> ()) {
        
        let session = URLSession.shared
        let task = session.dataTask(with: searchURL) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(data!))
            }
        }
        task.resume()
    }
}
