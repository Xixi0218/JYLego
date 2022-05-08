//
//  CellProtocol.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

protocol CellProtocol {
    func cellDelegate(delegate: AnyObject?)
    func updateCellViewModel(cellViewModel: CellViewModelProtocol)
}

extension CellProtocol {
    func cellDelegate(delegate: AnyObject?) { }
}
