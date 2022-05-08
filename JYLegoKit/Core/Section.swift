//
//  Section.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

class Section {
    
    var sectionHeader: ReusableViewModelProtocol?
    var sectionFooter: ReusableViewModelProtocol?
    var minimumLineSpacing: CGFloat = 0
    var minimumInteritemSpacing: CGFloat = 0
    
    var items = [CellViewModelProtocol]()
    
    init(@ItemBuilder items: () -> [CellViewModelProtocol]) {
        self.items = items()
    }
    
    func sectionHeader(_ sectionHeader: ReusableViewModelProtocol) -> Section {
        self.sectionHeader = sectionHeader
        return self
    }
    
    func minimumLineSpacing(_ minimumLineSpacing: CGFloat) -> Section {
        self.minimumLineSpacing = minimumLineSpacing
        return self
    }
    
    func minimumInteritemSpacing(_ minimumInteritemSpacing: CGFloat) -> Section {
        self.minimumInteritemSpacing = minimumInteritemSpacing
        return self
    }
    
}
