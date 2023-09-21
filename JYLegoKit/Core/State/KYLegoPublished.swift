//
//  LegoPublished.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/8.
//

import UIKit
import Combine

@propertyWrapper
public struct KYLegoPublished<Value> {
    
    public static subscript<T: KYLegoObservableObject>(
        _enclosingInstance instance: T,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<T, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<T, Self>
    ) -> Value {
        get {
            return instance[keyPath: storageKeyPath].storage
        }
        set {
            instance[keyPath: storageKeyPath].storage = newValue
            instance.objectDidChange.send()
        }
    }

    public var storage: Value
    
    @available(*, unavailable,
               message: "@LegoPublished can only be applied to classes")
    public var wrappedValue: Value {
        get { fatalError() }
        // swiftlint:disable unused_setter_value
        set { fatalError() }
        // swiftlint:enable unused_setter_value
    }

    public init(wrappedValue: Value) {
        self.storage = wrappedValue
    }

}
