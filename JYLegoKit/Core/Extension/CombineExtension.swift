//
//  CombineExtension.swift
//  JYLegoKit
//
//  Created by keyon on 2022/9/26.
//

import Foundation
import Combine

extension Publisher where Failure == Never {
    func assign<Root: AnyObject>(on instance: Root, to path: ReferenceWritableKeyPath<Root, Output?>) -> Cancellable {
        sink { instance[keyPath: path] = $0 }
    }
}
