//
//  ViewController.swift
//  JYLegoKit
//
//  Created by keyon on 2022/5/6.
//

import UIKit

class ViewController: UIViewController, KYLegoContainer {

    var lego: KYLego {
        KYLego {
            KYLegoSection {
                viewModel.items
            }.sectionHeader(SectionHeaderViewModel())
            if viewModel.flag {
                KYLegoSection {
                    CollectionViewCellViewModel()
                    CollectionViewCellViewModel()
                }.sectionHeader(SectionHeaderViewModel())
            }
        }
    }
    
    @KYLegoStateObject private var viewModel = VCViewModel()
    lazy var legoRenderer: KYLegoRender = {
        let render = KYLegoRender(lego: lego)
        return render
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestData()
        view.addSubview(legoRenderer.collectionView)
        view.addSubview(button)
        view.addSubview(flagButton)
    }
    
    @objc private func buttonClick() {
        viewModel.buttonClick()
    }
    
    @objc private func flagButtonClick() {
        viewModel.personClick()
    }
    
    override func viewDidLayoutSubviews() {
        legoRenderer.collectionView.frame = view.bounds
    }

    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var flagButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(flagButtonClick), for: .touchUpInside)
        return button
    }()
}

