//
//  ObjectDidChangePublisher.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/8.
//

import UIKit

class ObjectDidChangePublisher {
    private var currentID: Int = 0
    private(set) var actions: [Int: () -> ()] = [:]

    public func send() {
        actions.forEach { $0.value() }
    }

    func observe(_ action: @escaping () -> ()) {
        let id = currentID
        currentID += 1
        actions[id] = action
    }
}

protocol LegoObservableObject: AnyObject {
    var objectDidChange: ObjectDidChangePublisher { get }
}

private enum AssociatedKeys {
    static var publisher = "LegoKit.ObjectDidChangePublisher"
}

extension LegoObservableObject {
    var objectDidChange: ObjectDidChangePublisher {
        var publisher = objc_getAssociatedObject(self, &AssociatedKeys.publisher) as? ObjectDidChangePublisher
        if publisher == nil {
            publisher = .init()
            objc_setAssociatedObject(self, &AssociatedKeys.publisher, publisher, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return publisher!
    }
}
