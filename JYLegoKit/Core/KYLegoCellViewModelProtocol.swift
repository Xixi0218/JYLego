//
//  CellViewModel.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

protocol KYLegoCellViewModelProtocol: AnyObject {
    func cellSize() -> CGSize
    func cellClass() -> AnyClass
    func cellIdentifier() -> String
}

extension KYLegoCellViewModelProtocol {
    func cellIdentifier() -> String {
        return NSStringFromClass(cellClass())
    }
}
