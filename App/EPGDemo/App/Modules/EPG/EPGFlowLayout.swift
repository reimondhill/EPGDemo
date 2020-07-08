//
//  EPGFlowLayout.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 25/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import UIKit

protocol EPGFlowLayoutDelegate: class {
    
    func epgFlowLayout(_ epgFlowLayout: EPGFlowLayout, minutesDurationAt indexPath: IndexPath) -> CGFloat
    
    func epgFlowLayout(_ epgFlowLayout: EPGFlowLayout, originFromStartReferenceAt indexPath: IndexPath) -> CGFloat
}


class EPGFlowLayout: UICollectionViewFlowLayout {
    // MARK: - Class model
    struct Style {
        var widthMinute: CGFloat
        var height: CGFloat
        
        static var defaultStyle: Style = Style(widthMinute: 50, height: 82)
    }
    
    
    // MARK: - Properties
    private let style: Style
    
    weak var delegate: EPGFlowLayoutDelegate?
    private var itemAttributesCache: [UICollectionViewLayoutAttributes] = []
    
    private var contentWidth: CGFloat = 0
    private var contentHeight: CGFloat = 0
    
    
    // MARK: - Constructor
    init(style: Style = Style.defaultStyle) {
        self.style = style
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Lifecycle methods
extension EPGFlowLayout {
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard itemAttributesCache.isEmpty,
            let collectionView = collectionView,
            let delegate = delegate else {
            return
        }
        
        var maxX: CGFloat = 0
        var maxY: CGFloat = 0
                
        for section in 0..<collectionView.numberOfSections {
            for row in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                    
                let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                layoutAttributes.frame = .init(x: delegate.epgFlowLayout(self, originFromStartReferenceAt: indexPath),
                                               y: CGFloat(indexPath.section) * style.height,
                                               width: delegate.epgFlowLayout(self, minutesDurationAt: indexPath),
                                               height: style.height)
                
                if layoutAttributes.frame.maxX >= maxX {
                    maxX = layoutAttributes.frame.maxX
                }
                if layoutAttributes.frame.maxY >= maxY {
                    maxY = layoutAttributes.frame.maxY
                }

                itemAttributesCache.append(layoutAttributes)
            }
        }
        
        contentWidth = maxX
        contentHeight = maxY
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return itemAttributesCache.filter( { $0.frame.intersects(rect) })
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return itemAttributesCache.first(where: { $0.indexPath == indexPath })
    }
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if scrollDirection == .vertical,
            let oldWidth = collectionView?.bounds.width {
            return oldWidth != newBounds.width
        } else if scrollDirection == .horizontal,
            let oldHeight = collectionView?.bounds.height {
            return oldHeight != newBounds.height
        }

        return false
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()

        itemAttributesCache = []
        contentWidth = 0
        contentHeight = 0
    }
    
}

