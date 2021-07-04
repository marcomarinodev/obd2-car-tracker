//
//  MosaicMenuLayout.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 29/06/21.
//

import UIKit

private enum MosaicSegmentStyle {
    case fullWidth
    // case fullSize
    case fiftyFifty
    case oneThirdTwoThirds
    case twoThirdsOneThird
}

public class MosaicMenuLayout: UICollectionViewLayout {
    
    var contentBounds = CGRect.zero
    var cachedAttributes = [UICollectionViewLayoutAttributes]()
    
    // tells the layout object to update the current layout
    public override func prepare() {
        super.prepare()
        
        guard let cv = collectionView else {
            return
        }
        
        // Reset cached information
        cachedAttributes.removeAll()
        contentBounds = CGRect(origin: .zero, size: cv.bounds.size)
        
        // For every item in the collection view:
        //  - Prepare the attributes.
        //  - Store attributes in the cachedAttributes array.
        //  - Combine contentBounds with attributes.frame.
        
        // number of items in section
        let count = cv.numberOfItems(inSection: 0)
        
        var currentIndex = 0
        var segment: MosaicSegmentStyle = .twoThirdsOneThird
        var lastFrame: CGRect = .zero
        
        // Padding between tiles
        let verticalSpacing: CGFloat = 15.0
        let horizontalSpacing: CGFloat = 15.0
        
        let cvWidth = cv.bounds.size.width - 30
        
        while currentIndex < count {
            
            // 20 due to rounded corners
            var segmentFrame = CGRect(x: 20, y: lastFrame.maxY + verticalSpacing, width: cvWidth, height: 250.0)
            
            var segmentRects = [CGRect]()
            
            switch segment {
            case .fullWidth:
                // Padding for a full width tile
                segmentFrame = CGRect(
                    origin: segmentFrame.origin,
                    size: CGSize(
                        width: segmentFrame.width - horizontalSpacing,
                        height: segmentFrame.height - verticalSpacing
                    )
                )
                
                segmentRects = [segmentFrame]
                
            case .fiftyFifty:
                var horizontalSlices = segmentFrame.dividedIntegral(fraction: 0.5, from: .minXEdge)
                
                // Paddings two 1/2 tiles
                horizontalSlices.first = CGRect(
                    origin: horizontalSlices.first.origin,
                    size: CGSize(
                        width: horizontalSlices.first.width - horizontalSpacing,
                        height: horizontalSlices.first.height - verticalSpacing
                    )
                )
                
                horizontalSlices.second = CGRect(
                    origin: horizontalSlices.second.origin,
                    size: CGSize(
                        width: horizontalSlices.second.width - horizontalSpacing,
                        height: horizontalSlices.second.height - verticalSpacing
                    )
                )
                
                segmentRects = [horizontalSlices.first, horizontalSlices.second]
                
            case .twoThirdsOneThird:
                
                var horizontalSlices = segmentFrame.dividedIntegral(fraction: (2.0 / 3.0), from: .minXEdge)
                
                horizontalSlices.first = CGRect(
                    origin: horizontalSlices.first.origin,
                    size: CGSize(
                        width: horizontalSlices.first.width - horizontalSpacing,
                        height: horizontalSlices.first.height - verticalSpacing
                    )
                )
                
                var verticalSlices = horizontalSlices.second.dividedIntegral(fraction: 0.5, from: .minYEdge)
                
                verticalSlices.first = CGRect(
                    origin: verticalSlices.first.origin,
                    size: CGSize(
                        width: verticalSlices.first.width - horizontalSpacing,
                        height: verticalSlices.first.height - verticalSpacing
                    )
                )
                
                verticalSlices.second = CGRect(
                    origin: verticalSlices.second.origin,
                    size: CGSize(
                        width: verticalSlices.second.width - horizontalSpacing,
                        height: verticalSlices.second.height - verticalSpacing
                    )
                )
                
                segmentRects = [horizontalSlices.first, verticalSlices.first, verticalSlices.second]
                
            case .oneThirdTwoThirds:
                
                var horizontalSlices = segmentFrame.dividedIntegral(fraction: (1.0 / 3.0), from: .minXEdge)
                
                horizontalSlices.first = CGRect(
                    origin: horizontalSlices.first.origin,
                    size: CGSize(
                        width: horizontalSlices.first.width - horizontalSpacing,
                        height: horizontalSlices.first.height - verticalSpacing
                    )
                )
                
                var verticalSlices = horizontalSlices.first.dividedIntegral(fraction: 0.5, from: .minYEdge)
                
                verticalSlices.first = CGRect(
                    origin: verticalSlices.first.origin,
                    size: CGSize(
                        width: verticalSlices.first.width - horizontalSpacing,
                        height: verticalSlices.first.height - verticalSpacing
                    )
                )
                
                verticalSlices.second = CGRect(
                    origin: verticalSlices.second.origin,
                    size: CGSize(
                        width: verticalSlices.second.width - horizontalSpacing,
                        height: verticalSlices.second.height - verticalSpacing
                    )
                )
                
                segmentRects = [verticalSlices.first, verticalSlices.second, horizontalSlices.second]
            }
            
            // Create and cache layout attributes for calculated frames.
            for rect in segmentRects {
                let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: currentIndex, section: 0))
                attributes.frame = rect
                
                cachedAttributes.append(attributes)
                contentBounds = contentBounds.union(lastFrame)
                
                currentIndex += 1
                lastFrame = rect
            }
            
            // Determine the next segment style.
            // MARK: - FIX THE TILES ORDER
            switch count - currentIndex {
            case 1:
                segment = .fullWidth
            case 2:
                segment = .fiftyFifty
            default:
                switch segment {
                case .fullWidth:
                    segment = .fiftyFifty
                case .fiftyFifty:
                    segment = .twoThirdsOneThird
                case .twoThirdsOneThird:
                    segment = .oneThirdTwoThirds
                case .oneThirdTwoThirds:
                    segment = .fiftyFifty
                }
            }
            
        }
    }
    
    /// - Tag: CollectionViewContentSize
    /**
        It provides a size for the colletion view
     */
    public override var collectionViewContentSize: CGSize {
        return contentBounds.size
    }
    
    /// - Tag: ShouldInvalidateLayout
    /**
        This function is called for every bounds change from the collection view. It returns true when size and origin change, false otherwise.
     */
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }
    
    /// - Tag: LayoutAttributesForItem
    /**
        The collection view calls this function periodically to display one particular item, which is known as querying by index path
     */
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }
    
    /// - Tag: LayoutAttributesForElements
    /**
        Defining layout attributes for a geometric region (querying by geometric region) (called periodically to display items)
     */
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()
        
        // Find any cell that sits within the query rect.
        guard let lastIndex = cachedAttributes.indices.last,
              let firstMatchIndex = binSearch(rect, start: 0, end: lastIndex) else { return attributesArray }
        
        // Starting from the match, loop up and down through the array until all the attributes
        // have been added within the query rect.
        for attributes in cachedAttributes[..<firstMatchIndex].reversed() {
            guard attributes.frame.maxY >= rect.minY else { break }
            attributesArray.append(attributes)
        }
        
        for attributes in cachedAttributes[firstMatchIndex...] {
            guard attributes.frame.minY <= rect.maxY else { break }
            attributesArray.append(attributes)
        }
        
        return attributesArray
    }
    
    // Perform a binary search on the cached attributes array.
    func binSearch(_ rect: CGRect, start: Int, end: Int) -> Int? {
        if end < start { return nil }
        
        let mid = (start + end) / 2
        let attr = cachedAttributes[mid]
        
        if attr.frame.intersects(rect) {
            return mid
        } else {
            if attr.frame.maxY < rect.minY {
                return binSearch(rect, start: (mid + 1), end: end)
            } else {
                return binSearch(rect, start: start, end: (mid - 1))
            }
        }
    }
    
}
