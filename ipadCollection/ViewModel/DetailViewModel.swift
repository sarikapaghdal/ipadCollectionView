//
//  DetailViewModel.swift
//  ipadCollection
//
//  Created by Dhaval_G_S on 12.07.19.
//  Copyright © 2019 Dhaval_G_S. All rights reserved.
//

import UIKit

class DetailViewModel {
    weak var delegate: DetailViewController?
    
    var imageURL: String = ""
    var titleIS: String = ""
    var listClient = ListClient()
    
    init(_ viewController: DetailViewController) {
        delegate = viewController
    }
    
    func getAPIData(from: URL,completion: @escaping (Data) -> ()) {
        listClient.fetchDataFromURL(searchURL: from) {(resultData) in
            switch resultData {
            case .success(let data):
                    completion(data)
            case .failure(let error):
                    print(error)
            }
        }
    }
}
