//
//  SectionHeaderViewModel.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

class SectionHeaderViewModel: KYLegoReusableViewModelProtocol {
    
    func viewSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 40)
    }
    
    func viewClass() -> AnyClass {
        return CollectionReusableView.self
    }
    
    func viewKind() -> String {
        return UICollectionView.elementKindSectionHeader
    }
    
}
