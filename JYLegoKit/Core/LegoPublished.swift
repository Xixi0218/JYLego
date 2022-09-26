//
//  LegoPublished.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/8.
//

import UIKit
import Combine

@propertyWrapper
struct LegoPublished<Value> {
    
    public static subscript<T: AnyObject>(
        _enclosingInstance instance: T,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<T, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<T, Self>
    ) -> Value {
        get {
            return instance[keyPath: storageKeyPath].wrappedValue
        }
        set {
            instance[keyPath: storageKeyPath].wrappedValue = newValue
            if let object = instance as? LegoObservableObject {
                object.objectDidChange.send()
            }
        }
    }

    public var wrappedValue: Value {
        didSet {
            projectedValue.send(wrappedValue)
        }
    }
    public var projectedValue: CurrentValueSubject<Value, Never>

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
        self.projectedValue = .init(wrappedValue)
    }

}
