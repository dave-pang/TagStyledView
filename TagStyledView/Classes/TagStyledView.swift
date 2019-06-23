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

public extension TagPresentable where Self: UICollectionViewCell {
    var cell: UICollectionViewCell { return self }
}

public protocol TagStyling: TagPresentable {
    var tagLabel: UILabel! { get }
}

extension TagStyling {
    var fittingSize: CGSize {
        return cell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}

public extension TagStyledView {
    struct Options {
        public let sectionInset: UIEdgeInsets
        public let lineSpacing: CGFloat
        public let interitemSpacing: CGFloat
        public let align: TagStyledView.Options.Alignment
        
        public init(sectionInset: UIEdgeInsets = .zero,
                    lineSpacing: CGFloat = 10.0,
                    interitemSpacing: CGFloat = 10.0,
                    align: TagStyledView.Options.Alignment = .justified) {
            self.sectionInset = sectionInset
            self.lineSpacing = lineSpacing
            self.interitemSpacing = interitemSpacing
            self.align = align
        }
    }
}

public extension TagStyledView.Options {
    enum Alignment {
        case justified
        case left
        case center
        case right
    }
}

public class TagStyledView: UIView {
    
    public var tags: [String]? {
        didSet { attributedStrings = tags?.compactMap{ $0 }.map{ NSAttributedString(string: $0) } }
    }
    
    public var attributedStrings: [NSAttributedString]? {
        didSet { collectionView?.reloadData() }
    }
    
    public var options: TagStyledView.Options? {
        didSet {
            guard let options = options else { return }
            layout.sectionInset = options.sectionInset
            layout.minimumInteritemSpacing = options.interitemSpacing
            layout.minimumLineSpacing = options.lineSpacing
            layout.align = options.align
            
            collectionView.reloadData()
        }
    }
    
    public var cellForItem: (((cell: TagStyling, indexPath: IndexPath)) -> Void)?
    public var didSelectItemAt: ((IndexPath) -> Void)?
    
    private let layout = TagStyleFlowLayout()
    private var collectionView: UICollectionView!
    
    private var reseource: (cell: TagStyling, identifier: String)?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    public func register(_ nib: UINib, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        reseource = (nib.instantiate(withOwner: nil, options: nil).first as! TagStyling, identifier)
    }
    
    private func setup() {
        collectionView = ContentsWrappingCollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        
        addConstraint(collectionView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(collectionView.trailingAnchor.constraint(equalTo: trailingAnchor))
        addConstraint(collectionView.leadingAnchor.constraint(equalTo: leadingAnchor))
        addConstraint(collectionView.bottomAnchor.constraint(equalTo: bottomAnchor))
        
    }
    
    private func configureCell(_ cell: TagStyling, forIndexPath indexPath: IndexPath) {
        guard let attributedStrings = attributedStrings else { return }
        cell.tagLabel.attributedText = attributedStrings[indexPath.row]
    }
}

extension TagStyledView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let attributedStrings = attributedStrings else { return 0 }
        return attributedStrings.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let resource = reseource,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resource.identifier, for: indexPath) as? TagStyling else {
                return UICollectionViewCell()
        }
        
        configureCell(cell, forIndexPath: indexPath)
        
        cellForItem?((cell, indexPath))
        
        return cell as! UICollectionViewCell
    }
}

extension TagStyledView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = reseource?.cell else { return .zero }
        
        configureCell(cell, forIndexPath: indexPath)
        return cell.fittingSize
    }
}

extension TagStyledView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        didSelectItemAt?(indexPath)
    }
}


final class ContentsWrappingCollectionView: UICollectionView {
    override func reloadData() {
        super.reloadData()
        
        invalidateIntrinsicContentSize()
        superview?.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
        superview?.layoutIfNeeded()
    }
}
