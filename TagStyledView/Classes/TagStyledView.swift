//
//  TagStyledView.swift
//  Pods-TagStyledView_Example
//
//  Created by Dave on 08/11/2018.
//

import Foundation
import UIKit

public protocol TagPresentable: class {
    var cell: UICollectionViewCell { get }
}
extension TagPresentable where Self: UICollectionViewCell {
    var cell: UICollectionViewCell { return self }
}

public protocol TagStyling: TagPresentable {
    var label: UILabel! { get }
}

