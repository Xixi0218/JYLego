//
//  SectionHeaderViewModel.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

class SectionHeaderViewModel: KYReusableModelProtocol {
    
    func resuableClass() -> AnyClass {
        return CollectionReusableView.self
    }
    
    func resuableKind() -> String {
        return UICollectionView.elementKindSectionHeader
    }
    
}
