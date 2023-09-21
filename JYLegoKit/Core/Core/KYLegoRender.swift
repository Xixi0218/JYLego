//
//  LegoRender.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/8.
//

import UIKit

class KYLegoRender: NSObject {
    
    weak var delegate: AnyObject?
    var isAnimationEnabled: Bool = true
    
    private(set) var lego: KYLego
    private var cellIdentifier = Set<String>()
    private var reusableViewIdentifier = Set<String>()
    private var layoutConfiguration: UICollectionViewCompositionalLayoutConfiguration?
    
    init(lego: KYLego, layoutConfiguration: UICollectionViewCompositionalLayoutConfiguration? = nil) {
        self.lego = lego
        self.layoutConfiguration = layoutConfiguration
    }
    
    @objc private func dismissKeyboard() {
        collectionView.endEditing(true)
    }
    
    func apply(lego: KYLego, animatingDifferences: Bool? = nil) {
        var snapshot = NSDiffableDataSourceSnapshot<AnyHashable, AnyHashable>()
        snapshot.appendSections(lego.sections.map { $0.id })
        lego.sections.forEach {
            snapshot.appendItems($0.items.map { $0.diffId }, toSection: $0.id)
        }
        let allIdentifiers = Set(snapshot.itemIdentifiers)
        for indexPath in collectionView.indexPathsForVisibleItems {
            guard let identifier = dataSource.itemIdentifier(for: indexPath),
                  allIdentifiers.contains(identifier),
                  let cell = collectionView.cellForItem(at: indexPath),
                  let newIndexPath = lego.indexPathForItem(with: identifier)
            else {
                continue
            }
            
            if let cell = cell as? KYCellProtocol {
                cell.cellDelegate(delegate: delegate)
                cell.update(with: lego[newIndexPath])
            }
        }
        self.lego = lego
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences ?? isAnimationEnabled)
    }
    
    func reloadItems(_ items: [AnyHashable]) {
        var snapshot = dataSource.snapshot()
        snapshot.reloadItems(items)
        // fix: 为了解决ios14 animatingDifferences为false时候会刷新全部的bug
        UIView.performWithoutAnimation {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func cellProvider(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        itemID: AnyHashable
    ) -> UICollectionViewCell? {
        let item = lego[indexPath]
        if !cellIdentifier.contains(item.cellIdentifier()) {
            cellIdentifier.insert(item.cellIdentifier())
            collectionView.register(item.cellClass(), forCellWithReuseIdentifier: item.cellIdentifier())
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellIdentifier(), for: indexPath)
        if let cell = cell as? KYCellProtocol {
            cell.cellDelegate(delegate: delegate)
            cell.update(with: item)
        }
        return cell
    }
    
    private func supplementaryViewProvider(
        collectionView: UICollectionView,
        kind: String,
        indexPath: IndexPath
    ) -> UICollectionReusableView? {
        let section = lego.sections[indexPath.section]
        if let header = section.header, header.resuableKind() == kind {
            let reusableView = getReusableView(with: header, collectionView: collectionView, indexPath: indexPath)
            return reusableView
        }
        
        if let footer = section.footer, footer.resuableKind() == kind {
            let reusableView = getReusableView(with: footer, collectionView: collectionView, indexPath: indexPath)
            return reusableView
        }
        return nil
    }
    
    private func getReusableView(
        with viewModel: KYReusableModelProtocol,
        collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> UICollectionReusableView {
        let identifier = viewModel.resuableKind() + viewModel.resuableIdentifier()
        if !reusableViewIdentifier.contains(identifier) {
            reusableViewIdentifier.insert(identifier)
            collectionView.register(
                viewModel.resuableClass(),
                forSupplementaryViewOfKind: viewModel.resuableKind(),
                withReuseIdentifier: viewModel.resuableIdentifier()
            )
        }
        let reusableView = collectionView.dequeueReusableSupplementaryView(
            ofKind: viewModel.resuableKind(),
            withReuseIdentifier: viewModel.resuableIdentifier(),
            for: indexPath
        )
        if let reusableView = reusableView as? KYReusableProtocol {
            reusableView.update(with: viewModel)
        }
        return reusableView
    }
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        collectionView.addGestureRecognizer(tap)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewCompositionalLayout = {
        let provider: UICollectionViewCompositionalLayoutSectionProvider = { [weak self] section, enviroment in
            guard let self = self else { return nil }
            return self.lego.sections[section].layout(enviroment)
        }
        if let layoutConfiguration = layoutConfiguration {
            return UICollectionViewCompositionalLayout(sectionProvider: provider, configuration: layoutConfiguration)
        } else {
            return UICollectionViewCompositionalLayout(sectionProvider: provider)
        }
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<AnyHashable, AnyHashable> = {
        let dataSource = UICollectionViewDiffableDataSource<AnyHashable, AnyHashable>(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, itemIdentifier in
            self?.cellProvider(collectionView: collectionView, indexPath: indexPath, itemID: itemIdentifier)
        }
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            self?.supplementaryViewProvider(collectionView: collectionView, kind: kind, indexPath: indexPath)
        }
        return dataSource
    }()
}

extension KYLegoRender: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = lego[indexPath]
        item.didSelected(collectionView: collectionView, indexPath: indexPath)
    }
}
