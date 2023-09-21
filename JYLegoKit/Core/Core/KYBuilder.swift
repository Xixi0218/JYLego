//
//  KYBuilder.swift
//  JYLegoKit
//
//  Created by mac on 2023/9/21.
//

import Foundation

@resultBuilder
struct AISBuilder<T> {
    static func buildBlock(_ components: [T]...) -> [T] {
        return components.flatMap { $0 }
    }
    
    static func buildOptional(_ component: [T]?) -> [T] {
        return component ?? []
    }
    
    static func buildExpression(_ expression: T) -> [T] {
        return [expression]
    }
    
    static func buildExpression(_ expression: [T]) -> [T] {
        return expression
    }
    
    static func buildArray(_ components: [[T]]) -> [T] {
        return components.flatMap { $0 }
    }
    
    static func buildEither(first component: [T]) -> [T] {
        return component
    }
    
    static func buildEither(second component: [T]) -> [T] {
        return component
    }
}

typealias KYAnytSectionBuilder = AISBuilder<KYLegoSection>
typealias KYAnytItemBuilder = AISBuilder<KYCellModelProtocol>
