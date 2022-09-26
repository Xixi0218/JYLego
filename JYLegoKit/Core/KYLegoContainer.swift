//
//  LegoContainer.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/8.
//

import UIKit

protocol KYLegoContainer: AnyObject {
    var lego: KYLego { get }
    var legoRenderer: KYLegoRender { get }
}
