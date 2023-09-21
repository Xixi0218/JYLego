//
//  CollectionViewCellViewModel.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

class CollectionViewCellViewModel: KYCellModelProtocol {
    
    var person = JYPerson()
    
    func cellSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 300)
    }
    
    func cellClass() -> AnyClass {
        CollectionViewCell.self
    }
}
