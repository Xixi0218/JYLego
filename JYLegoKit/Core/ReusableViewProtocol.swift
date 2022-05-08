//
//  ReusableViewProtocol.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

protocol ReusableViewProtocol {
    func viewDelegate(delegate: AnyObject?)
    func updateViewModel(viewModel: ReusableViewModelProtocol)
}

extension ReusableViewProtocol {
    func viewDelegate(delegate: AnyObject?) { }
}

