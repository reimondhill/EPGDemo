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
    override var clipsToBounds: Bool {
        get { return true }
        set {}
    }
    
    private lazy var titlePeriodStackView: VStackView = {
        let view = VStackView(spacing: 0,
                              alignment: .leading,
                              distribution: .fillEqually)
        
        view.addSubview(titleLabel)
        view.addSubview(periodLabel)
        
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .black
        view.numberOfLines = 1
        
        return view
    }()
    private lazy var periodLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .black
        view.numberOfLines = 1
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
        periodLabel.text = nil
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
        
        addSubview(titlePeriodStackView)
        titlePeriodStackView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.height.equalTo(21)
        }
    }
    
    func updateUI() {
        
        titleLabel.text = viewModel?.title
        periodLabel.text = viewModel?.periodString
        
    }
    
}
