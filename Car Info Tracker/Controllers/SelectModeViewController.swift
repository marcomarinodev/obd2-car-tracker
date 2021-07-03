//
//  SelectModeViewController.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 29/06/21.
//

import UIKit

public protocol SelectModeViewControllerDelegate: AnyObject {
    
    // what view controllers that conform to this protocol have to do
    // when an info button is pressed: (current engine, chassis and trouble codes)
    func selectModeViewController(didCurrentInfoPressed request: Endpoint)
    
    // when an hystorical button is pressed: (data plot, damages preditcion)
    func selectModeViewController(didHystoricalInfoPressed hystoricalInfoType: HystoricalInfoType)
    
}

public class SelectModeViewController: UICollectionViewController {
    
    // menu items taken from the model
    var menuItems = [Mode]()
    
    // SelectModeViewController view: defined at SelectModeView.swift
    var selectModeView: SelectModeView!
    
    // selectModeViewControllerDelegate
    // set as weak in order to avoid retain cycles
    public weak var delegate: SelectModeViewControllerDelegate? = nil
    
    let segueIdentifier = "toInfo"
    
    // didSelectItemAt modifies this variable
    internal var selectedMenuItem: Mode? = nil
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // an object that represents the view of this collectionViewController
        selectModeView = SelectModeView(cv: self)
        
        // getting the possible modes from the model
        menuItems = Mode.getModes()
        
        // calling the mosaic layout initializer
        selectModeView.setupMosaicCollectionView()
        
        // collection view protocols (embedded in UICollectionViewController)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // scrolls the collection view contents until the specified item is visible
        if collectionView.numberOfItems(inSection: 0) > 0 {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension SelectModeViewController {
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // cardinality of menu items array
        menuItems.count
        
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModeCollectionViewCell.identifier, for: indexPath) as? ModeCollectionViewCell else {
            
            preconditionFailure("Failed to load collection view cell")
        }
        
        // set the image for the imageView
        cell.imageView.image = UIImage(named: menuItems[indexPath.item].imageName)
        
        return cell
        
    }
    
}

// MARK: - UICollectionViewDelegate
extension SelectModeViewController {
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(menuItems[indexPath.item].name)
        
        selectedMenuItem = menuItems[indexPath.item]
        
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let carInfoVC = segue.destination as? CarInfoViewController else { return }
        
        print("selected: \(selectedMenuItem!.name)")
        
        // the delegate to perform the protocol functions is the destination vc (CarInfoViewController)
        self.delegate = carInfoVC
        
        if self.delegate != nil {
            
            if (selectedMenuItem!.modeType == .endpoint) {
                
                var endpoint = Endpoint(rawValue: selectedMenuItem!.name)
                
                
                
                if endpoint == nil {
                    // default endpoint
                    print("is default")
                    endpoint = .Engine
                }
                
                self.delegate?.selectModeViewController(didCurrentInfoPressed: endpoint!)
            } else {
                
                var hystoric = HystoricalInfoType(rawValue: selectedMenuItem!.name)
                
                if hystoric == nil {
                    // default hystoric operation
                    hystoric = .Plot
                }
                
                self.delegate?.selectModeViewController(didHystoricalInfoPressed: hystoric!)
                
            }
        }
    }
    
}
