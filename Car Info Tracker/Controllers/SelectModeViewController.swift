//
//  SelectModeViewController.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 29/06/21.
//

import UIKit

public class SelectModeViewController: UICollectionViewController {
    
    var menuItems = [Mode]()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        menuItems = Mode.getModes()
        setupMosaicCollectionView()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if collectionView.numberOfItems(inSection: 0) > 0 {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        }
    }

    // MARK: - UICollectionViewDataSource
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        menuItems.count
        
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModeCollectionViewCell.identifier, for: indexPath) as? ModeCollectionViewCell else {
            
            preconditionFailure("Failed to load collection view cell")
        }
        
        cell.imageView.image = UIImage(named: menuItems[indexPath.item].imageName)
        
        return cell
        
    }
    
    private func setupMosaicCollectionView() {
        // create an instance of the cv layout
        let mosaicLayout = MosaicMenuLayout()
        
        // init
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: mosaicLayout)
        
        // properties
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.alwaysBounceVertical = true
        collectionView.indicatorStyle = .default
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // register the custom cell
        collectionView.register(ModeCollectionViewCell.self, forCellWithReuseIdentifier: ModeCollectionViewCell.identifier)
        
        // add collection view as subview of this view
        self.view.addSubview(collectionView)
        
        // set the navigation title
        self.navigationItem.title = "Car Info Tracker"
    }
    
}
