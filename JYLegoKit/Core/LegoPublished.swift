//
//  LegoPublished.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/8.
//

import UIKit

@propertyWrapper
struct LegoPublished<Value> {
    
    public static subscript<T: LegoObservableObject>(
        _enclosingInstance instance: T,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<T, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<T, Self>
    ) -> Value {
        get {
            if let storage = instance[keyPath: storageKeyPath].storage as? LegoObservableObject, storage.objectDidChange.actions.isEmpty {
                storage.objectDidChange.observe {
                    instance.objectDidChange.send()
                }
            }
            return instance[keyPath: storageKeyPath].storage
        }
        set {
            if let storage = instance[keyPath: storageKeyPath].storage as? [LegoObservableObject] {
                for item in storage {
                    if item.objectDidChange.actions.isEmpty {
                        item.objectDidChange.observe {
                            instance.objectDidChange.send()
                        }
                    }
                }
            }
            instance[keyPath: storageKeyPath].storage = newValue
            instance.objectDidChange.send()
        }
    }

    @available(*, unavailable,
               message: "@LegoPublished can only be applied to classes")
    public var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }

    private var storage: Value

    public init(wrappedValue: Value) {
        storage = wrappedValue
    }
}
