//
//  ObjectDidChangePublisher.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/8.
//

import UIKit
import Combine

protocol KYLegoObservableObject: AnyObject {
    var objectDidChange: PassthroughSubject<Void, Never> { get }
}

private enum AssociatedKeys {
    static var publisher = "LegoKit.ObjectDidChangePublisher"
}

extension KYLegoObservableObject {
    var objectDidChange: PassthroughSubject<Void, Never> {
        var publisher = objc_getAssociatedObject(self, &AssociatedKeys.publisher) as? PassthroughSubject<Void, Never>
        if publisher == nil {
            publisher = .init()
            objc_setAssociatedObject(self, &AssociatedKeys.publisher, publisher, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return publisher!
    }
}
