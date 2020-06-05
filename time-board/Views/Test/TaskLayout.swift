//
//  TaskLayout.swift
//  time-board
//
//  Created by Tianid on 05.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol TaskLayoutDelegate: AnyObject {
    func collectionView(_ cpllectionView: UICollectionView, heightForTableAtIndexPath indexPath: IndexPath) -> CGFloat
    func collectionView(_ cpllectionView: UICollectionView, widthForTableAtIndexPath indexPath: IndexPath) -> CGFloat
    
}



import UIKit

class TaskLayout: UICollectionViewLayout {
    
    weak var delegate: TaskLayoutDelegate?
    
    var numberOfColumn = 1
    private let cellPadding: CGFloat = 14
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
//    private var contentWidth: CGFloat {
//        guard let collectionView = collectionView else { return 0 }
//        let insets = collectionView.contentInset
//        return collectionView.bounds.width - (insets.left + insets.right)
//    }
    
    //    private var contentHeight: CGFloat  {
    //        guard let collectionView = collectionView else { return 0 }
    ////        let insets = collectionView.contentInset
    //        return collectionView.bounds.height
    //    }
    //
    //    private var contentWidth: CGFloat = 255
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else { return }
        
        //                let columnWidth = contentWidth / CGFloat(numberOfColumn)
        let columnWidth: CGFloat = 255
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumn {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumn)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let tableHeight = delegate?.collectionView(collectionView, heightForTableAtIndexPath: indexPath) ?? 180
            let height = cellPadding * 2 + tableHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            column = column < (numberOfColumn - 1) ? (column + 1) : 0
        }
        
    }
    
    //    override func prepare() {
    //        guard cache.isEmpty, let collectionView = collectionView else { return }
    //
    //        let columnHeight = contentHeight / CGFloat(numberOfColumn)
    //        var yOffset: [CGFloat] = []
    //        for column in 0..<numberOfColumn {
    //            yOffset.append(CGFloat(column) * columnHeight)
    //        }
    //        var column = 0
    //        var xOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumn)
    //
    //        for item in 0..<collectionView.numberOfItems(inSection: 0) {
    //            let indexPath = IndexPath(item: item, section: 0)
    //            let tableWidth = delegate?.collectionView(collectionView, heightForTableAtIndexPath: indexPath) ?? 255
    //            let width = cellPadding * 2 + tableWidth
    //            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: width, height: columnHeight)
    //            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
    //
    //            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
    //            attributes.frame = insetFrame
    //            cache.append(attributes)
    //
    //            contentWidth = max(contentWidth, frame.maxX)
    //            xOffset[column] = xOffset[column] + width
    //
    //            column = column < (numberOfColumn - 1) ? (column + 1) : 0
    //        }
    //    }
    
    //    override func prepare() {
    //        guard cache.isEmpty, let collectionView = collectionView else { return }
    //
    //        let columnHeight = contentHeight / CGFloat(numberOfColumn)
    //        //        let columnHeight = contentHeight
    //
    //        var xOffset: [CGFloat] = []
    //        var column = 0
    //        let yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumn)
    //
    //        for item in 0..<collectionView.numberOfItems(inSection: 0) {
    //            let indexPath = IndexPath(item: item, section: 0)
    //
    ////            let height = (delegate?.collectionView(collectionView, heightForTableAtIndexPath: indexPath))!
    //            //                xOffset.append(CGFloat(column) * columnHeight)
    //
    //
    //            var tableHeight = delegate?.collectionView(collectionView, heightForTableAtIndexPath: indexPath) ?? 50
    //            let tableWidth = delegate?.collectionView(collectionView, widthForTableAtIndexPath: indexPath) ?? 255
    //
    //
    //            let paddingBetweenColumns = tableWidth * 0.92
    //            xOffset.append(paddingBetweenColumns * CGFloat(column))
    //            if tableHeight > contentHeight {
    //                tableHeight = contentHeight
    //            }
    //            let frame = CGRect(x:xOffset[column] , y:yOffset[column], width: tableWidth, height: tableHeight)
    //            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
    //
    //            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
    //            attributes.frame = insetFrame
    //
    //            cache.append(attributes)
    //
    //            contentWidth = max(contentWidth, frame.maxX)
    ////            contentHeight = max(contentHeight, frame.maxY)
    //
    //            xOffset[column] = xOffset[column] + paddingBetweenColumns
    //
    //            column = column < (numberOfColumn - 1) ? (column + 1) : 0
    //        }
    //
    //        print()
    //    }
    
    
    //    override func prepare() {
    //        guard cache.isEmpty, let collectionView = collectionView else { return }
    //
    //        let columnWidth = contentWidth
    //        var xOffset: [CGFloat] = []
    //        for column in 0..<numberOfColumn {
    //            xOffset.append(CGFloat(column) * columnWidth)
    //        }
    //        var column = 0
    //        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumn)
    //
    //        for item in 0..<collectionView.numberOfItems(inSection: 0) {
    //            let indexPath = IndexPath(item: item, section: 0)
    //
    //            let tableHeight = delegate?.collectionView(collectionView, heightForTableAtIndexPath: indexPath) ?? 180
    //            let height = cellPadding * 2 + tableHeight
    //            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
    //            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
    //
    //            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
    //            attributes.frame = insetFrame
    //            cache.append(attributes)
    //
    //            contentHeight = max(contentHeight, frame.maxY)
    //            contentWidth = max(contentWidth, frame.maxX)
    //            yOffset[column] = yOffset[column] + height
    //            column = column < (numberOfColumn - 1) ? (column + 1) : 0
    //        }
    //
    //    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
}
