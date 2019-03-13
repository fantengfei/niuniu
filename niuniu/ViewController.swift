//
//  ViewController.swift
//  niuniu
//
//  Created by 范腾飞 on 2019/3/13.
//  Copyright © 2019 taffy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let progress = ProgressView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(progress)
        progress.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaInsets.top).offset(30 + 64)
            make.centerX.equalTo(self.view)
            make.width.equalTo(200)
        }

    }


}

