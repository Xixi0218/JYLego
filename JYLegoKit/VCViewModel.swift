//
//  VCViewModel.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

class VCViewModel: LegoObservableObject {
    
    @LegoPublished var items = [CollectionViewCellViewModel]()
    @LegoPublished var flag = true
    
    func requestData() {
        for _ in 0..<5 {
            items.append(CollectionViewCellViewModel())
        }
    }
    
    func buttonClick() {
        items.append(CollectionViewCellViewModel())
    }
    
    func flagButtonClick() {
        flag.toggle()
    }
    
    func personClick() {
        items.first?.person.name = "Keyon"
    }
    
}
