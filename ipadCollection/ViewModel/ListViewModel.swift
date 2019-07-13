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

    var urlOfImageArray = [String]()
    var urlOfTitleArray = [String]()

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
                            let photosAre = resulData.photos
                            if let finalPhoto = photosAre?.photo {
                                for (_, element) in finalPhoto.enumerated() {
                                    self?.urlOfTitleArray.append(element.title ?? "")
                                    self?.urlOfImageArray.append(element.urlString ?? "")
                                }
                            }
                            DispatchQueue.main.async {
                                self?.delegate?.listCollectionView.reloadData()
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
