//
//  ItemBuilder.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

@resultBuilder
enum ItemBuilder {
    
    static func buildBlock(_ components: [CellViewModelProtocol]...) -> [CellViewModelProtocol] {
        components.flatMap { $0 }
    }
    
    static func buildArray(_ components: [[CellViewModelProtocol]]) -> [CellViewModelProtocol] {
        components.flatMap { $0 }
    }
    
    static func buildOptional(_ component: [CellViewModelProtocol]?) -> [CellViewModelProtocol] {
        component ?? []
    }
    
    static func buildEither(first component: [CellViewModelProtocol]) -> [CellViewModelProtocol] {
        component
    }
    
    static func buildEither(second component: [CellViewModelProtocol]) -> [CellViewModelProtocol] {
        component
    }
    
    static func buildExpression(_ expression: [CellViewModelProtocol]) -> [CellViewModelProtocol] {
        expression
    }
    
    static func buildExpression(_ expression: CellViewModelProtocol) -> [CellViewModelProtocol] {
        [expression]
    }

}
