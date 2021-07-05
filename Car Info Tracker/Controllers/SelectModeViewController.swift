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
    func selectModeViewController(didCurrentInfoPressed request: Endpoint, mode: ModeType)
    
    // when an hystorical button is pressed: (data plot, damages preditcion)
    func selectModeViewController(didHystoricalInfoPressed hystoricalInfoType: HystoricalInfoType, mode: ModeType)
    
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
extension SelectModeViewController {
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(menuItems[indexPath.item].name)
        
        selectedMenuItem = menuItems[indexPath.item]
        
        // based on the selectedMenuItem got to CarInfoViewController or SettingsViewController
        // MARK: - Can we abuse of the Strategy Design Pattern here?
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let carInfoVc = storyboard.instantiateViewController(identifier: "CarInfoViewController") as! CarInfoViewController

        prepareTransitionTo(carInfoVC: carInfoVc)
        
        show(carInfoVc, sender: self)
    }
    
    private func prepareTransitionTo(carInfoVC: CarInfoViewController) {
    
        print("selected: \(selectedMenuItem!.endpoint)")
        
        // the delegate to perform the protocol functions is the destination vc (CarInfoViewController)
        self.delegate = carInfoVC
        
        if self.delegate != nil {
            
            if (selectedMenuItem!.modeType == .endpoint) {
                
                var endpoint = Endpoint(rawValue: selectedMenuItem!.endpoint)
                
                if endpoint == nil {
                    // default endpoint
                    print("is default")
                    endpoint = .Engine
                }
                
                self.delegate?.selectModeViewController(didCurrentInfoPressed: endpoint!, mode: .endpoint)
            } else {
                
                var hystoric = HystoricalInfoType(rawValue: selectedMenuItem!.name)
                
                if hystoric == nil {
                    // default hystoric operation
                    hystoric = .Plot
                }
                
                self.delegate?.selectModeViewController(didHystoricalInfoPressed: hystoric!, mode: .hystorical)
                
            }
        }
        
    }
    
}
