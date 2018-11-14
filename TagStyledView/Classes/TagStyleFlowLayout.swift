//
//  ParkingMainCardTicketFlowLayout.swift
//  KakaoMobility
//
//  Created by Dave on 07/11/2018.
//  Copyright © 2018 Mobility-iOS. All rights reserved.
//

import UIKit

public class TagStyleFlowLayout: UICollectionViewFlowLayout {
    
    typealias AlignType = (lastRow: Int, lastMargin: CGFloat)
    
    var align: TagStyledView.Options.Alignment = .justified
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }

        let shifFrame: ((UICollectionViewLayoutAttributes) -> Void) = { [unowned self] layoutAttribute in
            if layoutAttribute.frame.origin.x + layoutAttribute.frame.size.width > collectionView.bounds.size.width {
                layoutAttribute.frame.size.width = collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right
            }
        }
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        var alignData: [AlignType] = []
        
        attributes.forEach { layoutAttribute in
            switch align {
            case .left, .center, .right:
                if layoutAttribute.frame.origin.y >= maxY {
                    alignData.append((lastRow: layoutAttribute.indexPath.row, lastMargin: leftMargin - minimumInteritemSpacing))
                    leftMargin = sectionInset.left
                }
                
                shifFrame(layoutAttribute)
                
                layoutAttribute.frame.origin.x = leftMargin
                
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                
                maxY = max(layoutAttribute.frame.maxY , maxY)
            case .justified:
                shifFrame(layoutAttribute)
            }
        }
        
        align(attributes: attributes, alignData: alignData, leftMargin: leftMargin - minimumInteritemSpacing)

        return attributes
    }
    
    private func align(attributes: [UICollectionViewLayoutAttributes], alignData: [AlignType], leftMargin: CGFloat) {
        guard let collectionView = collectionView else { return }
        
        switch align {
        case .left, .justified:
            break
        case .center:
            attributes.forEach { layoutAttribute in
                if let data = alignData.filter({ $0.lastRow > layoutAttribute.indexPath.row }).first {
                    layoutAttribute.frame.origin.x += ((collectionView.bounds.size.width - data.lastMargin - sectionInset.right) / 2)
                } else {
                    layoutAttribute.frame.origin.x += ((collectionView.bounds.size.width - leftMargin - sectionInset.right) / 2)
                }
            }
        case .right:
            attributes.forEach { layoutAttribute in
                if let data = alignData.filter({ $0.lastRow > layoutAttribute.indexPath.row }).first {
                    layoutAttribute.frame.origin.x += (collectionView.bounds.size.width - data.lastMargin - sectionInset.right)
                } else {
                    layoutAttribute.frame.origin.x += (collectionView.bounds.size.width - leftMargin - sectionInset.right)
                }
            }
        }
    }
}
