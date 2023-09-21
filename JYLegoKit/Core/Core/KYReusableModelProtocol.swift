//
//  ReusableViewModelProtocol.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

protocol KYReusableProtocol {
    func viewDelegate(delegate: AnyObject?)
    func update(with item: KYReusableModelProtocol)
}

extension KYReusableProtocol {
    func viewDelegate(delegate: AnyObject?) { }
}

protocol KYReusableModelProtocol {
    func resuableClass() -> AnyClass
    func resuableIdentifier() -> String
    func resuableKind() -> String
}

extension KYReusableModelProtocol {
    func resuableIdentifier() -> String {
        return NSStringFromClass(resuableClass())
    }
}
