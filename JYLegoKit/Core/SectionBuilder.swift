//
//  SectionBuilder.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/6.
//

import UIKit

@resultBuilder
enum SectionBuilder {
    
    static func buildExpression(_ expression: Section) -> [Section] {
        [expression]
    }
    
    static func buildArray(_ components: [[Section]]) -> [Section] {
        components.flatMap { $0 }
    }
    
    static func buildBlock(_ components: [Section]...) -> [Section] {
        components.flatMap{ $0 }
    }
    
    static func buildOptional(_ component: [Section]?) -> [Section] {
        component ?? []
    }
    
    static func buildEither(first component: [Section]) -> [Section] {
        component
    }
    
    static func buildEither(second component: [Section]) -> [Section] {
        component
    }
    
    static func buildExpression(_ expression: [Section]) -> [Section] {
        expression
    }
    
    static func buildExpression(_ expression: ()) -> [Section] {
        return []
    }
    
}
