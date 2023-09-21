//
//  JYLego.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

struct KYLego {
    
    private(set) var sections: [KYLegoSection]
    
    init(@KYAnytSectionBuilder sections: () -> [KYLegoSection]) {
        self.sections = sections()
    }
    
    func indexPathForItem(with identifier: AnyHashable) -> IndexPath? {
        for (sectionIndex, section) in sections.enumerated() {
            for (itemIndex, item) in section.items.enumerated() where item.diffId == identifier {
                return IndexPath(item: itemIndex, section: sectionIndex)
            }
        }
        return nil
    }
    
    subscript(indexPath: IndexPath) -> KYCellModelProtocol {
        sections[indexPath.section].items[indexPath.item]
    }
}
