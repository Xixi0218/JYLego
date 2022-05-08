//
//  CollectionViewCell.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

class CollectionViewCell: UICollectionViewCell, CellProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCellViewModel(cellViewModel: CellViewModelProtocol) {
        guard let cellVM = cellViewModel as? CollectionViewCellViewModel else { return }
        titleLabel.text = cellVM.person.name
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 30)
        label.textColor = .systemPink
        return label
    }()
}
