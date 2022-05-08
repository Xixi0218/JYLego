//
//  VCViewModel.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/7.
//

import UIKit

class VCViewModel: LegoObservableObject {
    
    @LegoPublished var items = [Item]()
    @LegoPublished var flag = true
    @LegoPublished var person = JYPerson()
    
    func requestData() {
        for _ in 0..<5 {
            items.append(Item())
        }
    }
    
    func buttonClick() {
        person = JYPerson()
    }
    
    func flagButtonClick() {
        flag.toggle()
    }
    
    func personClick() {
        items.first?.person.name = "Keyon"
//        person.name = "Keyon"
    }
    
}
