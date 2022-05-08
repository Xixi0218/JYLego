//
//  JYLego.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

struct Lego {
    
    private(set) var sections: [Section]
    
    init(@SectionBuilder sections: () -> [Section]) {
        self.sections = sections()
    }
}
