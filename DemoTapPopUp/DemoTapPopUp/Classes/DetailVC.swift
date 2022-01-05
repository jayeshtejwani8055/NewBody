//
//  DetailVC.swift
//  DemoTapPopUp
//
//  Created by Jayesh Tejwani on 05/01/22.
//

import UIKit

class DetailCell: UICollectionViewCell {
    
}


class DetailVC: UIViewController {
    var delegate: ViewController?
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tabs = 6
    
    var totalRows: Int {
        return tabs / 6
    }
  
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bounds.size.height = UIScreen.main.bounds.size.height * 0.7
        view.bounds.size.width = UIScreen.main.bounds.size.width * 0.8
        view.layer.cornerRadius = 40
        view.layer.masksToBounds = true
        collectionView.isScrollEnabled = totalRows > 1
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}


extension DetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailCell
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as! DetailCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collWidth = _screenSize.width * 0.8
        return CGSize(width: collWidth, height: _screenSize.height * 0.7)
    }
    
    
    
}

