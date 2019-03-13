//
//  ProgressView.swift
//  niuniu
//
//  Created by 范腾飞 on 2019/3/13.
//  Copyright © 2019 taffy. All rights reserved.
//

import UIKit
import SnapKit

class ProgressView: UIView {

    let progress = UIProgressView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layout() {
        self.addSubview(progress)
        progress.progress = 0.5
        progress.layer.cornerRadius = 3.5
        progress.clipsToBounds = true
        progress.tintColor = UIColor.blue
        progress.snp.makeConstraints { (make) in
            make.centerY.left.right.equalTo(self)
            make.height.equalTo(7)
        }
    }
}
