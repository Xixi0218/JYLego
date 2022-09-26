//
//  StateObject.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/8.
//

import UIKit
import Combine

@propertyWrapper
struct StateObject<Value> {
    
    @available(*, unavailable,
               message: "This property wrapper can only be applied to ``LegoContainer``")
    var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }

    private var cancelAbles = Set<AnyCancellable>()
    
    private class Box {
        weak var container: LegoContainer?
        weak var observer: LegoObservableObject?
    }
    
    private var storage: Value
    private let box: Box = .init()
    
    init(wrappedValue: Value) {
        self.storage = wrappedValue
    }
    
    private mutating func bind(to instance: LegoContainer, storage: LegoObservableObject) {
        guard box.container !== instance else { return }
        box.container = instance
        storage.objectDidChange.sink { [box] _ in
            guard let container = box.container else {
                return
            }
            container.legoRenderer.reloadData(lego: container.lego)
        }.store(in: &cancelAbles)
    }
    
    static subscript<T>(
        _enclosingInstance instance: T,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<T, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<T, StateObject>
    ) -> Value {
        get {
            let storage = instance[keyPath: storageKeyPath].storage
            if let storage = storage as? LegoObservableObject, let value = instance as? LegoContainer {
                instance[keyPath: storageKeyPath].bind(to: value, storage: storage)
            }
            return storage
        }
        set {
            instance[keyPath: storageKeyPath].storage = newValue
        }
    }
}
