//
//  ViewController.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 25/06/21.
//

import UIKit

/// This view controller is based on a table view that shows the current car data taken async from the server
class CarInfoViewController: UIViewController {

    /// UI drawer
    public var UIStrategy: CarInfoDrawer!
    
    /// It represents obtained car data
    public var group: CarInfoGroup!
    
    /// If it is true then there will be the initial drawing
    /// otherwise, reload table view data
    private var isFirstFetching = true
    
    /// Table View Cell Identifier
    private var cellIdentifier: String!
    
    /// If it is true then the view cell is different
    private var isPresentingTrouble: Bool = false
    
    /// Main table view
    var tableView: UITableView!
    
    /// Main title
    var titleLabel: UILabel!
    
    /// Primary color
    var primaryColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellIdentifier = "cellID"
        
        group = CarInfoGroup()
            
        tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        titleLabel = UILabel()
        
        registerTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /// It register a table view based on the delegate from previus vc.
    /// If it is presenting trouble codes then table view is recorded to show TroubleViewCell
    fileprivate func registerTableView() {
        if isPresentingTrouble {
            tableView.register(UINib(nibName: "TroubleViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        } else {
            tableView.register(CarInfoTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
            // tableView.register(UINib(nibName: "CarInfoViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    /// It gets data asynchronously (whenever data changes) from the database, it stores data in group
    /// variable. This function uses the strategy to initially draw the UI and then updates the UI in order
    /// to present data.
    /// - Parameter endpoint: Endpoint to send requests to
    private func getData(of endpoint: Endpoint?) {
        
        if (endpoint != nil)
        {
            
            CarInfoGroup.getDataOf(endpoint: endpoint!) { [self] group, response  in
                
                detectDifferencesAndDo(oldGroup: self.group, newGroup: group) { diff in
                    // diff is a set of CarInfo that has changed
                    for i in diff {
                        print("Changed \(i.name) to \(i.value!)")
                    }
                }
                
                // saving the group
                self.group = group
                
                fetchingDebug(group, response)
                
                drawUI(group, response)
                
                
            }
        } else {
            // simply no endpoint was chosen
            print("no endpoint was chosen")
        }
        
    }
    
    /// It detects differences between the old information group and the newest one, and do a completion, in order
    /// to visually update only the mutant info
    /// - Parameters:
    ///   - oldGroup: Group previously fetched
    ///   - newGroup: Current fetched group
    ///   - completion: What to do with differences as CarInfo
    fileprivate func detectDifferencesAndDo(oldGroup: CarInfoGroup, newGroup: CarInfoGroup, completion: (Set<CarInfo>) -> Void) {
        
        var oldSet: Set = Set<CarInfo>()
        var newSet: Set = Set<CarInfo>()
        var diff: Set = Set<CarInfo>()
        
        for attr in oldGroup.attributes {
            oldSet.insert(attr)
        }
        
        for attr in newGroup.attributes {
            newSet.insert(attr)
        }
        
        diff = newSet.subtracting(oldSet)
        
        // diff now contains the CarInfo object that has changed, do what the user want to do with the difference
        completion(diff)
        
    }
    
    /// It draws and initialize the UI based on the response and the fetched group
    /// - Parameters:
    ///   - group: Fetched group
    ///   - response: Response call
    fileprivate func drawUI(_ group: CarInfoGroup, _ response: FetchingResponse) {
        // we do not really care about how the UI is represented
        // if there's an error, the controller does not care
        // because there is the strategy that will draw UI for us
        if isFirstFetching {
            // First time: we need to rewrite the UI
            
            print("is first fetching")
            
            self.UIStrategy.drawCarInfoUI(of: group, with: response, on: &self.view, &self.tableView, &self.titleLabel)
            
            tableView.reloadData()
            
        } else {
            // Not the first time: just update UI DataSource
            isFirstFetching = false
            // self.UIStrategy.updateCarInfoUI(group)
        }
    }
    
    /// Series of response prints
    /// - Parameters:
    ///   - group: Received data from the database
    ///   - response: Response code
    private func fetchingDebug(_ group: CarInfoGroup, _ response: FetchingResponse) {
        for i in group.attributes {
            print("Parameter: \(i.name)\nValue: \(i.value ?? "")\nType: \(i.infoType.rawValue)\n")
            
        }
    }
    
}

/// Masking history button handler
extension SelectModeViewControllerDelegate {
    func selectModeViewController(didHistoryPressed request: Endpoint) {}
}

/// Implementing the delegate from SelectModeViewControllerDelegate
extension CarInfoViewController: SelectModeViewControllerDelegate {
    
    func selectModeViewController(didCurrentInfoPressed request: Endpoint) {
        
        print("performing \(request.rawValue) request")
        
        isPresentingTrouble = (request == .ErrorCodes) ? true : false
        
        // attempt trying to get data
        getData(of: request)
        
        // Set the drawer
        self.UIStrategy = CurrentDataDrawer()
        
    }
}

// MARK: - TV Delegate and Datasource
extension CarInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.group.attributes.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let info = self.group.attributes[indexPath.row]
        
        print("setting cell")
        
        /*if isPresentingTrouble {
            // trouble codes
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TroubleViewCell else {
                
                fatalError()
                
            }
            
            cell.errorCode.text = info.name
            
            return cell
        }*/

        // engine, chassis, other endpoints
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CarInfoTableViewCell else {
                
            fatalError()
                
        }
        
        let infoUnit = info.infoType.rawValue
        let infoValue = info.value
        
        cell.detailTextLabel?.text = "\(infoValue ?? "-") \(infoUnit)"
        cell.textLabel?.text = info.name
        cell.accessoryType = .detailDisclosureButton
            
        return cell
        
    }
    
    
}

// MARK: Testing purposes
extension CarInfoViewController {
    
    public func callDetectDifferences(old: CarInfoGroup, new: CarInfoGroup, completion: (Set<CarInfo>) -> Void) {
        detectDifferencesAndDo(oldGroup: old, newGroup: new, completion: completion)
    }
    
}

