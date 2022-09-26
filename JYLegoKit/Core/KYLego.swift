//
//  JYLego.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

struct KYLego {
    
    private(set) var sections: [KYLegoSection]
    
    init(@KYLegoSectionBuilder sections: () -> [KYLegoSection]) {
        self.sections = sections()
    }
}
