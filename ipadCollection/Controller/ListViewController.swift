//
//  ViewController.swift
//  ipadCollection
//
//  Created by Dhaval_G_S on 11.07.19.
//  Copyright © 2019 Dhaval_G_S. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    private let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

    //MARK: lazy loading
    lazy var viewModel: ListViewModel = {
        return ListViewModel(self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getSearchAPIData()
    }
}

// MARK: UICollectionViewDelegate

extension ListViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let viewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            viewController.viewModel.titleIS = viewModel.titleArray[indexPath.row]
            viewController.viewModel.imageURL = viewModel.urlOfImageArray[indexPath.row]
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: UICollectionViewDataSource

extension ListViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.urlOfImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.titleLabel.text = viewModel.titleArray[indexPath.row]
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        
        guard let imageURL = URL(string: viewModel.urlOfImageArray[indexPath.row])
            else { return UICollectionViewCell() }
        
        viewModel.getAPIData(from: imageURL) { (data) in
            DispatchQueue.main.async{cell.thumbImageView.image = UIImage(data: data)}
        }
        return cell
    }
}
