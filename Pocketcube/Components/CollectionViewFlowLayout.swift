//
//  CollectionViewFlowLayout.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 17/11/20.
//

import UIKit

class CollectionViewFlowLayout: UICollectionViewFlowLayout {

    required init(itemSize: CGSize, minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        super.init()

        self.itemSize = itemSize
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
        sectionInsetReference = .fromSafeArea
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        guard scrollDirection == .vertical else { return layoutAttributes }

        let cellAttributes = layoutAttributes.filter({ $0.representedElementCategory == .cell })

        for (_, attributes) in Dictionary(grouping: cellAttributes, by: { ($0.center.y / 10).rounded(.up) * 10 }) {
            let cellsTotalWidth = attributes.reduce(CGFloat(0)) { (partialWidth, attribute) -> CGFloat in
                partialWidth + attribute.size.width
            }

            let totalInset = collectionView!.safeAreaLayoutGuide.layoutFrame.width - cellsTotalWidth - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(attributes.count - 1)
            var leftInset = (totalInset / 2 * 10).rounded(.down) / 10 + sectionInset.left

            for attribute in attributes {
                attribute.frame.origin.x = leftInset
                leftInset = attribute.frame.maxX + minimumInteritemSpacing
            }
        }

        return layoutAttributes
    }

}
