//
//  ReusableViewProtocol.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

protocol KYLegoReusableViewProtocol {
    func viewDelegate(delegate: AnyObject?)
    func updateViewModel(viewModel: KYLegoReusableViewModelProtocol)
}

extension KYLegoReusableViewProtocol {
    func viewDelegate(delegate: AnyObject?) { }
}

