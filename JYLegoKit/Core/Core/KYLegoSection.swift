//
//  Section.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

struct KYLegoSection {
    
    var id: UUID = .init()
    var header: KYReusableModelProtocol?
    var footer: KYReusableModelProtocol?
    var items = [KYCellModelProtocol]()
    var layout: (NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection
    
    init(
        @KYAnytItemBuilder items: () -> [KYCellModelProtocol],
        header: KYReusableModelProtocol? = nil,
        footer: KYReusableModelProtocol? = nil,
        layout: NSCollectionLayoutSection
    ) {
        self.items = items()
        self.header = header
        self.footer = footer
        self.layout = { _ in layout }
    }
    
}
