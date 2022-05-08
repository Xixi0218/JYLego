//
//  LegoRender.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/8.
//

import UIKit

class LegoRender: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private(set) var lego: Lego
    weak var delegate: LegoRenderProtocol?
    private var cellIdentifier = Set<String>()
    private var reusableViewIdentifier = Set<String>()
    
    init(lego: Lego, delegate: LegoRenderProtocol? = nil) {
        self.lego = lego
        self.delegate = delegate
    }
    
    func reloadData(lego: Lego) {
        self.lego = lego
        self.collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return lego.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lego.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = lego.sections[indexPath.section].items[indexPath.row]
        if !cellIdentifier.contains(cellViewModel.cellIdentifier()) {
            cellIdentifier.insert(cellViewModel.cellIdentifier())
            collectionView.register(cellViewModel.cellClass(), forCellWithReuseIdentifier: NSStringFromClass(cellViewModel.cellClass()))
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellIdentifier(), for: indexPath)
        if let cell = cell as? CellProtocol {
            cell.cellDelegate(delegate: delegate)
            cell.updateCellViewModel(cellViewModel: cellViewModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView = UICollectionReusableView()
        if let headerViewModel = lego.sections[indexPath.section].sectionHeader, headerViewModel.viewKind() == kind {
            reusableView = createReusableView(with: headerViewModel, collectionView: collectionView, indexPath: indexPath)
        }
        
        if let footerViewModel = lego.sections[indexPath.section].sectionFooter, footerViewModel.viewKind() == kind {
            reusableView = createReusableView(with: footerViewModel, collectionView: collectionView, indexPath: indexPath)
        }
        
        return reusableView
    }
    
    private func createReusableView(with viewModel: ReusableViewModelProtocol, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
        let identifier = viewModel.viewKind() + viewModel.viewIdentifier()
        if !reusableViewIdentifier.contains(identifier) {
            reusableViewIdentifier.insert(identifier)
            collectionView.register(viewModel.viewClass(), forSupplementaryViewOfKind: viewModel.viewKind(), withReuseIdentifier: viewModel.viewIdentifier())
        }
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: viewModel.viewKind(), withReuseIdentifier: viewModel.viewIdentifier(), for: indexPath)
        if let reusableView = reusableView as? ReusableViewProtocol {
            reusableView.viewDelegate(delegate: delegate)
            reusableView.updateViewModel(viewModel: viewModel)
        }
        return reusableView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return lego.sections[indexPath.section].items[indexPath.row].cellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let headerViewModel = lego.sections[section].sectionHeader {
            return headerViewModel.viewSize()
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if let footerViewModel = lego.sections[section].sectionFooter {
            return footerViewModel.viewSize()
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lego.sections[section].minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return lego.sections[section].minimumInteritemSpacing
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
    }
    
    private(set) lazy var collectionView: UICollectionView = {
        let flowLayout = delegate?.flowLayout() ?? UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
}
