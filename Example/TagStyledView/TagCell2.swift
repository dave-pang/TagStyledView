//
//  TagCell2.swift
//  TagStyledView_Example
//
//  Created by Dave on 09/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import TagStyledView

extension TagCell2 {
    struct Resource {
        static let identifier = String(describing: TagCell2.self)
    }
}

class TagCell2: UICollectionViewCell, TagStyling {

    @IBOutlet weak var tagLabel: UILabel!
}
