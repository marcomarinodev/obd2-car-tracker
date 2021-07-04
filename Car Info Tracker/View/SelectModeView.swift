//
//  SelectModeView.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 02/07/21.
//

import UIKit

class SelectModeView {
    
    private let collectionViewController: UICollectionViewController
    private let title: String
    
    internal func setupMosaicCollectionView() {
        // create an instance of the cv layout
        let mosaicLayout = MosaicMenuLayout()
        
        // init
        collectionViewController.collectionView = UICollectionView(frame: collectionViewController.view.bounds, collectionViewLayout: mosaicLayout)
        
        setupCollectionViewProperties()
        
        // register the custom cell
        collectionViewController.collectionView.register(ModeCollectionViewCell.self, forCellWithReuseIdentifier: ModeCollectionViewCell.identifier)
        
        // add collection view as subview of this view
        collectionViewController.view.addSubview(collectionViewController.collectionView)
        
        setupNavigationController(title: self.title)
        
    }
    
    private func setupCollectionViewProperties() {
        // properties
        collectionViewController.collectionView.backgroundColor = UIColor(named: "Color")
        collectionViewController.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionViewController.collectionView.alwaysBounceVertical = true
        collectionViewController.collectionView.indicatorStyle = .default
        collectionViewController.collectionView.showsVerticalScrollIndicator = false
        collectionViewController.collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupNavigationController(title: String) {
        // navigation controller style
        // set the navigation title
        // title
        collectionViewController.navigationItem.title = title
        // preferred large title
        collectionViewController.navigationController?.navigationBar.prefersLargeTitles = true
        collectionViewController.navigationController?.hidesBarsOnSwipe = true
        
        let styleAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40.0, weight: .heavy)
        ]
        
        // collectionViewController.navigationController?.navigationItem.titleView =
        
        collectionViewController.navigationController?.navigationBar.largeTitleTextAttributes = styleAttributes
        
    }
    
    init(cv: UICollectionViewController, title: String) {
        self.collectionViewController = cv
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
