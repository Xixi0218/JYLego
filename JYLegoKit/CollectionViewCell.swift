//
//  CollectionViewCell.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit
import Combine

class CollectionViewCell: UICollectionViewCell, KYLegoCellProtocol {

    private var cancelables = Set<AnyCancellable>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCellViewModel(cellViewModel: KYLegoCellViewModelProtocol) {
        guard let cellVM = cellViewModel as? CollectionViewCellViewModel else { return }
        cellVM.person.$name.assign(on: titleLabel, to: \.text).store(in: &cancelables)
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 30)
        label.textColor = .systemPink
        return label
    }()
}
