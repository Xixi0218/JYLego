//
//  KYCellModelProtocol.swift
//  JYLegoKit
//
//  Created by mac on 2023/9/21.
//

import UIKit

protocol KYCellProtocol {
    func cellDelegate(delegate: AnyObject?)
    func update(with item: KYCellModelProtocol)
}

extension KYCellProtocol {
    func cellDelegate(delegate: AnyObject?) { }
}

private var KYCellModelIdKey: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "AISCellModelIdKey".hashValue)

protocol KYCellModelProtocol: AnyObject {
    var diffId: AnyHashable { get set }
    func cellClass() -> AnyClass
    func cellIdentifier() -> String
    func didSelected(collectionView: UICollectionView, indexPath: IndexPath)
}

extension KYCellModelProtocol {
    var diffId: AnyHashable {
        get {
            if let diffId = objc_getAssociatedObject(self, &KYCellModelIdKey) as? AnyHashable {
                return diffId
            }
            let diffId = UUID()
            objc_setAssociatedObject(self, &KYCellModelIdKey, diffId, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return diffId
        }
        set {
            objc_setAssociatedObject(self, &KYCellModelIdKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func cellIdentifier() -> String { return NSStringFromClass(cellClass()) }
    func didSelected(collectionView: UICollectionView, indexPath: IndexPath) { }
}
