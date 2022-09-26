//
//  VCViewModel.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

class VCViewModel: KYLegoObservableObject {
    
    @KYLegoPublished var items = [CollectionViewCellViewModel]()
    @KYLegoPublished var flag = true
    
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
