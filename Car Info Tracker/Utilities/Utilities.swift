//
//  Utilities.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 29/06/21.
//

import UIKit

// Extension for mosaic layout
extension CGRect {
    func dividedIntegral(fraction: CGFloat, from fromEdge: CGRectEdge) -> (first: CGRect, second: CGRect) {
        let dimension: CGFloat
        
        switch fromEdge {
        case .minXEdge, .maxXEdge:
            dimension = self.size.width
        case .minYEdge, .maxYEdge:
            dimension = self.size.height
        }
        
        let distance = (dimension * fraction).rounded(.up)
        var slices = self.divided(atDistance: distance, from: fromEdge)
        
        switch fromEdge {
        case .minXEdge, .maxXEdge:
            slices.remainder.origin.x += 1
            slices.remainder.size.width -= 1
        case .minYEdge, .maxYEdge:
            slices.remainder.origin.y += 1
            slices.remainder.size.height -= 1
        }
        
        return (first: slices.slice, second: slices.remainder)
    }
}

// Adjust the weight of a text
extension UIFont {
    var weight: UIFont.Weight {
        guard let weightNumber = traits[.weight] as? NSNumber else { return .regular }
        let weightRawValue = CGFloat(weightNumber.doubleValue)
        let weight = UIFont.Weight(rawValue: weightRawValue)
        return weight
    }

    private var traits: [UIFontDescriptor.TraitKey: Any] {
        return fontDescriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any]
            ?? [:]
    }
}

extension CGFloat {
    
    public func computePercent(_ percentage: CGFloat, of number: CGFloat) -> CGFloat {
        
        return (percentage / 100) * number;
        
    }
    
}

extension UIColor {
    static let appBackgroundColor = #colorLiteral(red: 0.05882352941, green: 0.09019607843, blue: 0.1098039216, alpha: 1)
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
    
    static var colorSet: Set<UIColor> {
        return [
            .systemRed,
            .systemBlue,
            .systemTeal,
            .systemGreen,
            .systemOrange,
            .systemIndigo
        ]
    }
    
    public func getColor(set colorSet: inout Set<UIColor>) -> UIColor {
        
        if colorSet.capacity <= 0 {
            return .systemRed
        }
        
        let chosen = colorSet.randomElement()
        
        colorSet.remove(chosen!)
        
        return chosen!
        
    }
}
