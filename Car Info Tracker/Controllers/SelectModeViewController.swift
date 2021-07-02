//
//  SelectModeViewController.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 29/06/21.
//

import UIKit

public class SelectModeViewController: UICollectionViewController {
    
    var menuItems = [Mode]()
    var selectModeView: SelectModeView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        selectModeView = SelectModeView(cv: self)
        
        menuItems = Mode.getModes()
        
        selectModeView.setupMosaicCollectionView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
    
}
