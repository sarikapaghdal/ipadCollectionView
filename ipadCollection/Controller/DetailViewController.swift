//
//  DetailViewController.swift
//  ipadCollection
//
//  Created by Dhaval_G_S on 11.07.19.
//  Copyright © 2019 Dhaval_G_S. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var thumbImageView: CustomImageView!
    
    //MARK: lazy loading
    lazy var viewModel: DetailViewModel = {
        return DetailViewModel(self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titelLabel.text = viewModel.titleIS
        guard let imageURL = URL(string: viewModel.imageURL) else {
            return
        }
        
        viewModel.getAPIData(from: imageURL) { [weak self] (data) in
            DispatchQueue.main.async{self?.thumbImageView.image = UIImage(data: data)}
        }
    }
}
