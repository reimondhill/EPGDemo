//
//  StackView.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 12/07/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import UIKit

class CustomStackView: UIStackView {
    
    init(axis: NSLayoutConstraint.Axis = .horizontal,
         spacing: CGFloat = 8,
         alignment: UIStackView.Alignment = .fill,
         distribution: UIStackView.Distribution = .fillProportionally) {
        
        super.init(frame: .zero)
        
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class VStackView: CustomStackView {
    
    override var axis: NSLayoutConstraint.Axis {
        get { return .vertical }
        set { super.axis = .vertical }
    }
    
    
    init(spacing: CGFloat = 0,
         alignment: UIStackView.Alignment = .fill,
         distribution: UIStackView.Distribution = .fillProportionally){
        
        super.init(axis: .vertical, spacing: spacing, alignment: alignment, distribution: distribution)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HStackView: CustomStackView {
    
    override var axis: NSLayoutConstraint.Axis {
        get { return .horizontal }
        set { super.axis = .horizontal }
    }
    
    init(spacing: CGFloat = 0,
         alignment: UIStackView.Alignment = .fill,
         distribution: UIStackView.Distribution = .fillProportionally) {
        
        super.init(axis: .horizontal, spacing: spacing, alignment: alignment, distribution: distribution)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
