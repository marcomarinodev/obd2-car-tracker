//
//  SelectModeViewController.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 29/06/21.
//

import UIKit

public protocol SelectModeViewControllerDelegate: AnyObject {
    
    func selectModeViewController(didCurrentInfoPressed request: Endpoint)
    
    func selectModeViewController(didHistoryPressed request: Endpoint)
    
}

protocol SelectModeViewControllerInterface: AnyObject {
    
    func prepareTransitionTo(carInfoVC: CarInfoViewController)
    
    func prepareTransitionTo(hystoryVC: UIViewController)
    
    func prepareTransitionTo(plottingVC: UIViewController)
    
    func prepareTransitionTo(settingsVC: UIViewController)
    
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
    
    public var colorSet: Set<UIColor> = Set<UIColor>()
    
    // didSelectItemAt modifies this variable
    internal var selectedMenuItem: Mode? = nil
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // an object that represents the view of this collectionViewController
        selectModeView = SelectModeView(cv: self, title: "⚙️ Diagnostic", colorSet: &colorSet)
        
        // getting the possible modes from the model
        menuItems = Mode.getModes()
        
        // calling the mosaic layout initializer
        selectModeView.setupMosaicCollectionView()
        
        // collection view protocols (embedded in UICollectionViewController)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

}

// MARK: - UICollectionViewDataSource
extension SelectModeViewController {
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // cardinality of menu items array
        menuItems.count
        
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard var cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModeCollectionViewCell.identifier, for: indexPath) as? ModeCollectionViewCell else {
            
            preconditionFailure("Failed to load collection view cell")
        }
        
        // delegating to selectModeView the custom cell
        selectModeView.setupModeCollectionViewCell(&cell, items: menuItems, indexPath: indexPath, colorSet: &colorSet)
        
        return cell
        
    }
    
}

// MARK: - UICollectionViewDelegate
extension SelectModeViewController: SelectModeViewControllerInterface {
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let carInfoVc = storyboard.instantiateViewController(identifier: "CarInfoViewController") as! CarInfoViewController
        
        selectedMenuItem = menuItems[indexPath.item]
    
        
        prepareTransitionTo(carInfoVC: carInfoVc)
        
        // show the view controller
        show(carInfoVc, sender: self)
    }
    
    func prepareTransitionTo(carInfoVC: CarInfoViewController) {
    
        print("selected: \(selectedMenuItem!.endpoint)")
        
        // the delegate to perform the protocol functions is the destination vc (CarInfoViewController)
        self.delegate = carInfoVC
        
        if self.delegate != nil {
            var endpoint = Endpoint(rawValue: selectedMenuItem!.endpoint)
                
            if endpoint == nil {
                // default endpoint
                print("is default")
                endpoint = .Engine
            }
            
            self.delegate?.selectModeViewController(didCurrentInfoPressed: endpoint!)
            
        }
        
    }
    
    func prepareTransitionTo(hystoryVC: UIViewController) {
        // MARK: - hystoryVC
    }
    
    func prepareTransitionTo(plottingVC: UIViewController) {
        // MARK: - plottingVC
    }
    
    func prepareTransitionTo(settingsVC: UIViewController) {
        // MARK: - settingsVC
    }
    
}
