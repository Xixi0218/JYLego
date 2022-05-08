//
//  StateObject.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/8.
//

import UIKit

@propertyWrapper
struct StateObject<Value> {
    
    @available(*, unavailable,
               message: "This property wrapper can only be applied to ``LegoContainer``")
    var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }
    
    private class Box {
        weak var container: LegoContainer?
        weak var observer: LegoObservableObject?
    }
    
    private var storage: Value
    private let box: Box = .init()
    
    init(wrappedValue: Value) {
        self.storage = wrappedValue
    }
    
    private func bind(to instance: LegoContainer, storage: LegoObservableObject) {
        guard box.container !== instance else { return }
        box.container = instance
        storage.objectDidChange.observe {
            guard let container = box.container else {
                return
            }
            container.legoRenderer.reloadData(lego: container.lego)
        }
    }
    
    private func bind(to instance: LegoObservableObject, storage: LegoObservableObject) {
        guard box.observer !== instance else { return }
        box.observer = instance
        storage.objectDidChange.observe {
            guard let observer = box.observer else {
                return
            }
            observer.objectDidChange.send()
        }
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
//            if let storage = storage as? LegoObservableObject, let value = instance as? LegoObservableObject {
//                instance[keyPath: storageKeyPath].bind(to: value, storage: storage)
//            }
            return storage
        }
        set {
            instance[keyPath: storageKeyPath].storage = newValue
        }
    }
}
