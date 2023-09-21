//
//  StateObject.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/8.
//

import UIKit
import Combine

@propertyWrapper
struct KYLegoStateObject<Value: KYLegoObservableObject> {
    
    @available(*, unavailable,
               message: "This property wrapper can only be applied to ``LegoContainer``")
    var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }
    
    private class Box {
        weak var container: KYLegoContainer?
        var cancellable: AnyCancellable?
    }
    
    private var storage: Value
    private var box: Box = .init()
    
    init(wrappedValue: Value) {
        self.storage = wrappedValue
    }
    
    private func bind(to instance: KYLegoContainer) {
        guard box.container !== instance else { return }
        box.container = instance
        box.cancellable = storage.objectDidChange.print().receive(on: DispatchQueue.main).sink { _ in
            guard let container = box.container else {
                return
            }
            container.legoRenderer.apply(lego: container.lego, animatingDifferences: false)
        }
    }
    
    static subscript<T: KYLegoContainer>(
        _enclosingInstance instance: T,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<T, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<T, KYLegoStateObject>
    ) -> Value {
        get {
            instance[keyPath: storageKeyPath].bind(to: instance)
            return instance[keyPath: storageKeyPath].storage
        }
        set {
            instance[keyPath: storageKeyPath].storage = newValue
        }
    }
}
