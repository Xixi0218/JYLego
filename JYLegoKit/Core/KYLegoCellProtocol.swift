//
//  CellProtocol.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

protocol KYLegoCellProtocol {
    func cellDelegate(delegate: AnyObject?)
    func updateCellViewModel(cellViewModel: KYLegoCellViewModelProtocol)
}

extension KYLegoCellProtocol {
    func cellDelegate(delegate: AnyObject?) { }
}
