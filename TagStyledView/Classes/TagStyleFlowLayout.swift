//
//  ParkingMainCardTicketFlowLayout.swift
//  KakaoMobility
//
//  Created by Dave on 07/11/2018.
//  Copyright © 2018 Mobility-iOS. All rights reserved.
//

import UIKit

public class TagStyleFlowLayout: UICollectionViewFlowLayout {
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            if layoutAttribute.frame.origin.x + layoutAttribute.frame.size.width > collectionView.bounds.size.width {
                layoutAttribute.frame.size.width = collectionView.bounds.size.width - sectionInset.left - sectionInset.right
            }
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        
        return attributes
    }
}
