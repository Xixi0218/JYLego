//
//  CollectionReusableView.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

class CollectionReusableView: UICollectionReusableView, KYReusableProtocol {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    func update(with item: KYReusableModelProtocol) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
