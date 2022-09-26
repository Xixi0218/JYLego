//
//  Section.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

class KYLegoSection {
    
    var sectionHeader: KYLegoReusableViewModelProtocol?
    var sectionFooter: KYLegoReusableViewModelProtocol?
    var minimumLineSpacing: CGFloat = 0
    var minimumInteritemSpacing: CGFloat = 0
    
    var items = [KYLegoCellViewModelProtocol]()
    
    init(@KYLegoItemBuilder items: () -> [KYLegoCellViewModelProtocol]) {
        self.items = items()
    }
    
    func sectionHeader(_ sectionHeader: KYLegoReusableViewModelProtocol) -> KYLegoSection {
        self.sectionHeader = sectionHeader
        return self
    }
    
    func minimumLineSpacing(_ minimumLineSpacing: CGFloat) -> KYLegoSection {
        self.minimumLineSpacing = minimumLineSpacing
        return self
    }
    
    func minimumInteritemSpacing(_ minimumInteritemSpacing: CGFloat) -> KYLegoSection {
        self.minimumInteritemSpacing = minimumInteritemSpacing
        return self
    }
    
}
