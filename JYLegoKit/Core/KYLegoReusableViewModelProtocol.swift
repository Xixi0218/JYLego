//
//  ReusableViewModelProtocol.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

protocol KYLegoReusableViewModelProtocol {
    func viewSize() -> CGSize
    func viewClass() -> AnyClass
    func viewIdentifier() -> String
    func viewKind() -> String
}

extension KYLegoReusableViewModelProtocol {
    func viewIdentifier() -> String {
        return NSStringFromClass(viewClass())
    }
}
