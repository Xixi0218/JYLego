//
//  ItemBuilder.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

@resultBuilder
enum KYLegoItemBuilder {
    
    static func buildBlock(_ components: [KYLegoCellViewModelProtocol]...) -> [KYLegoCellViewModelProtocol] {
        components.flatMap { $0 }
    }
    
    static func buildArray(_ components: [[KYLegoCellViewModelProtocol]]) -> [KYLegoCellViewModelProtocol] {
        components.flatMap { $0 }
    }
    
    static func buildOptional(_ component: [KYLegoCellViewModelProtocol]?) -> [KYLegoCellViewModelProtocol] {
        component ?? []
    }
    
    static func buildEither(first component: [KYLegoCellViewModelProtocol]) -> [KYLegoCellViewModelProtocol] {
        component
    }
    
    static func buildEither(second component: [KYLegoCellViewModelProtocol]) -> [KYLegoCellViewModelProtocol] {
        component
    }
    
    static func buildExpression(_ expression: [KYLegoCellViewModelProtocol]) -> [KYLegoCellViewModelProtocol] {
        expression
    }
    
    static func buildExpression(_ expression: KYLegoCellViewModelProtocol) -> [KYLegoCellViewModelProtocol] {
        [expression]
    }

}
