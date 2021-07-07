//
//  CurrentDataDrawer.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 05/07/21.
//

import UIKit

public class CurrentDataDrawer: CarInfoDrawer {
    
    // MARK: - UI Properties
    
    // Group: titleLabel properties
    private let verticalSpacing: CGFloat = 15.0
    private let horizontalSpacing: CGFloat = 15.0
    
    private var titleLabelOrigin: CGPoint {
        CGPoint(x: horizontalSpacing, y: verticalSpacing)
    }
    
    private var titleLabelDim: CGSize {
        CGSize(width: UIScreen.main.bounds.width - (2*horizontalSpacing), height: CGFloat().computePercent(20, of: UIScreen.main.bounds.width - (2*horizontalSpacing)))
    }
    
    private var titleLabelFrame: CGRect {
        CGRect(origin: titleLabelOrigin, size: titleLabelDim)
    }
    
    private var titleLabelFont: UIFont {
        let fontSize: CGFloat = CGFloat().computePercent(8, of: titleLabelDim.width)
        return UIFont.systemFont(ofSize: fontSize, weight: .heavy)
    }
    
    // Group: tableView properties
    private var tableViewOrigin: CGPoint {
        CGPoint(x: 0, y: self.titleLabelDim.height + verticalSpacing)
    }
    
    private var tableViewDim: CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - self.titleLabelDim.height - verticalSpacing)
    }
    
    private var tableViewFrame: CGRect {
        CGRect(origin: tableViewOrigin, size: tableViewDim)
    }
    
    // Group: Drawers
    private func drawTableView(_ tableView: inout UITableView) {
        
        tableView.frame = tableViewFrame
        
    }
    
    private func drawTitleLabel(_ titleLabel: inout UILabel) {
        
        titleLabel = UILabel(frame: titleLabelFrame)
        titleLabel.font = titleLabelFont
        titleLabel.textColor = .white
        
    }
    
    // MARK: - Define Strategy
    public func drawCarInfoUI(of group: CarInfoGroup, with response: FetchingResponse, on mainView: inout UIView, _ tableView: inout UITableView, _ titleLabel: inout UILabel, tileColor: UIColor) {
        
        clearUI(&mainView)
        
        drawTableView(&tableView)
        drawTitleLabel(&titleLabel)
        
        // set title text
        if response != .Success {
            titleLabel.text = response.rawValue
        } else {
            titleLabel.text = group.description
        }
        
        mainView.backgroundColor = tileColor
        
        // adding layers to mainView
        mainView.addSubview(tableView)
        mainView.addSubview(titleLabel)
        
    }
    
    private func clearUI(_ view: inout UIView) {
        view.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    public func updateCarInfoUI(_ group: CarInfoGroup, with response: FetchingResponse, _ titleLabel: inout UILabel) {
        
        // set title text
        if response != .Success {
            titleLabel.text = response.rawValue
        } else {
            titleLabel.text = group.description
        }
        
    }
    
}

