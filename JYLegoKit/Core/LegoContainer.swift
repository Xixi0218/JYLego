//
//  LegoContainer.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/8.
//

import UIKit

protocol LegoContainer: AnyObject {
    var lego: Lego { get }
    var legoRenderer: LegoRender { get }
}
