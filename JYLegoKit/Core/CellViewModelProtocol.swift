//
//  CellViewModel.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

protocol CellViewModelProtocol: AnyObject {
    func cellSize() -> CGSize
    func cellClass() -> AnyClass
    func cellIdentifier() -> String
}

extension CellViewModelProtocol {
    func cellIdentifier() -> String {
        return NSStringFromClass(cellClass())
    }
}
