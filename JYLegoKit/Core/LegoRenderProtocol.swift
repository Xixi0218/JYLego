//
//  LegoProtocol.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

protocol LegoRenderProtocol: AnyObject {
    func flowLayout() -> UICollectionViewLayout
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

extension LegoRenderProtocol {
    func scrollViewDidScroll(_ scrollView: UIScrollView) { }
    func flowLayout() -> UICollectionViewLayout {
        return UICollectionViewFlowLayout()
    }
}
