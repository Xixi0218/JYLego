//
//  CollectionReusableView.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

class CollectionReusableView: UICollectionReusableView, ReusableViewProtocol {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    func updateViewModel(viewModel: ReusableViewModelProtocol) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
