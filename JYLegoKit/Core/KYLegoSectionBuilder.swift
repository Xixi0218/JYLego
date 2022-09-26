//
//  SectionBuilder.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/6.
//

import UIKit

@resultBuilder
enum KYLegoSectionBuilder {
    
    static func buildExpression(_ expression: KYLegoSection) -> [KYLegoSection] {
        [expression]
    }
    
    static func buildArray(_ components: [[KYLegoSection]]) -> [KYLegoSection] {
        components.flatMap { $0 }
    }
    
    static func buildBlock(_ components: [KYLegoSection]...) -> [KYLegoSection] {
        components.flatMap{ $0 }
    }
    
    static func buildOptional(_ component: [KYLegoSection]?) -> [KYLegoSection] {
        component ?? []
    }
    
    static func buildEither(first component: [KYLegoSection]) -> [KYLegoSection] {
        component
    }
    
    static func buildEither(second component: [KYLegoSection]) -> [KYLegoSection] {
        component
    }
    
    static func buildExpression(_ expression: [KYLegoSection]) -> [KYLegoSection] {
        expression
    }
    
    static func buildExpression(_ expression: ()) -> [KYLegoSection] {
        return []
    }
    
}
