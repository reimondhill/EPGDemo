//
//  EPGViewController.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 21/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import UIKit
import SnapKit


class EPGViewController: UIViewController {

    //MARK: - Properties
    var viewModel: EPGViewModelInterface
    
    //MARK: UI
    private lazy var collectionView: UICollectionView = {
        let flowLayout = EPGFlowLayout()
        flowLayout.delegate = self
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.defaultReuseIdentifier)
        view.register(EPGCollectionViewCell.self, forCellWithReuseIdentifier: EPGCollectionViewCell.defaultReuseIdentifier)
        
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    
    //MARK: - Constructor
    init(viewModel: EPGViewModelInterface = EPGViewModel() ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//MARK: - Lifecycle methods
extension EPGViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchEPG()
    }

}


//MARK: - Private methods
private extension EPGViewController {
    
    func setupUI() {
        view.backgroundColor = .red
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    func updateUI() {
        
    }
    
}


//MARK: - EPGViewModelDelegate implementation
extension EPGViewController: EPGViewModelDelegate {
    
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            //(self?.collectionView.collectionViewLayout as! EPGFlowLayout).prepareBeforeReload()
            //self?.collectionView.reloadData()
        }
    }
    
}


//MARK: - UICollectionView implementation
//MARK: UICollectionViewDataSource implementation
extension EPGViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.indefitier(at: indexPath), for: indexPath)
        
        switch cell {
        case (let epgCollectionViewCell as EPGCollectionViewCellInterface):
            viewModel.setup(epgCollectionViewCell: epgCollectionViewCell, at: indexPath)
        default:
            break
        }
        
        return cell
    }

}


//MARK: UICollectionViewDelegate implementation
extension EPGViewController: UICollectionViewDelegate {
    
}


//MARK: - EPGFlowLayoutDelegate
extension EPGViewController: EPGFlowLayoutDelegate {
    
    func epgFlowLayout(_ epgFlowLayout: EPGFlowLayout, originFromStartReferenceAt indexPath: IndexPath) -> CGFloat {
        //return CGFloat(indexPath.row) * 500
        return CGFloat(viewModel.minutesFromCurrentDayAtMidnight(at: indexPath))
    }

    
    func epgFlowLayout(_ epgFlowLayout: EPGFlowLayout, minutesDurationAt indexPath: IndexPath) -> CGFloat {
        //return CGFloat(500)
        return CGFloat(viewModel.minutesDuration(at: indexPath))
    }
    
}
