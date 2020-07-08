//
//  EPGCollectionViewCell.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 25/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import UIKit
import SnapKit

protocol EPGCollectionViewCellInterface {
    var viewModel: EPGCollectionViewModelInterface? { get set }
}


class EPGCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    private var _viewModel: EPGCollectionViewModelInterface? {
        didSet {
            updateUI()
        }
    }
    
    
    //MARK: UI
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    
    //MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: - Lifecycle methods
extension EPGCollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        backgroundColor = context.nextFocusedView == self ? .yellow:.clear
    }
    
}


//MARK: - Public methods
//MARK: EPGCollectionViewCellInterface implementation
extension EPGCollectionViewCell: EPGCollectionViewCellInterface {
    
    var viewModel: EPGCollectionViewModelInterface? {
        get { return _viewModel }
        set { _viewModel = newValue }
    }
    
}


//MARK: - Private methods
private extension EPGCollectionViewCell {
    
    func setupUI() {
        clipsToBounds = true
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    func updateUI() {
        
        titleLabel.text = viewModel?.title
        
    }
    
}
