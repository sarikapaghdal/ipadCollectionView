//
//  ListViewModel.swift
//  ipadCollection
//
//  Created by Dhaval_G_S on 12.07.19.
//  Copyright © 2019 Dhaval_G_S. All rights reserved.
//

import UIKit

class ListViewModel {
    
    var listClient = ListClient()
    
    weak var delegate: ListViewController?

    var urlOfImageArray = [String](){
    didSet {
            DispatchQueue.main.async {
                self.delegate?.listCollectionView.reloadData()
            }
        }
    }
    
    var titleArray = [String]()

    init(_ viewController: ListViewController) {
        delegate = viewController
    }

    func getUrlFormate() -> URL? {
        if let searchURL = listClient.flickrURLFromParameters() {
            return searchURL
        }
        return nil
    }
    
    func getAPIData(from: URL,completion: @escaping (Data) -> ()) {
        listClient.fetchDataFromURL(searchURL: from) { (resultData) in
            switch resultData {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSearchAPIData(){
        
     if let searchURL = getUrlFormate() {
        
            // Send the request
            listClient.fetchDataFromURL(searchURL: searchURL) { [weak self](resultObject) in
                switch resultObject {
                    case .success(let data):
                        do{
                            let resulData = try JSONDecoder().decode(Results.self, from: data)
                            let fetchPhotos = resulData.photos
                            if let fetchPhoto = fetchPhotos?.photo {
                                for (_, element) in fetchPhoto.enumerated() {
                                    self?.titleArray.append(element.title ?? "")
                                    self?.urlOfImageArray.append(element.urlString ?? "")
                                }
                            }
                        }
                        catch let jsonError{
                            print("can't serialize data", jsonError)
                    }
                    case .failure(let error): print(error)
                }
            }
        }
    }
}
