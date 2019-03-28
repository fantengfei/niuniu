//
//  ItemCell.swift
//  ZHModuleKM
//
//  Created by 范腾飞 on 2019/3/19.
//

import UIKit
import SnapKit

enum ItemStyle: Int {
    case empty, animal
}

class ItemCell: UICollectionViewCell {
    public var numberValue: Int = 0

    var number: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 25)
        l.textColor = UIColor.white
        l.textAlignment = .center
        l.clipsToBounds = false
        l.layer.cornerRadius = 5.0
        l.layer.borderWidth = 1.5
        l.layer.borderColor = UIColor.white.cgColor
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentView.addSubview(number)
        number.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.left.equalTo(5)
            make.right.equalTo(-5)
        }

        scaleAnimation()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isSelected: Bool {
        didSet {
            isSelected == true ? shakeAnimation() : scaleAnimation()
        }
    }

    public var isDestroies: Bool? {
        didSet {
            if isDestroies == true {
                hideAnimation()
            }
        }
    }

    func bindData(count: Int, type: ItemStyle = .empty) {
        numberValue = count
        number.text = "\(count)"
    }

    private func shakeAnimation(){
        self.contentView.layer.removeAllAnimations()
        let momAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        momAnimation.fromValue = NSNumber(value: -0.08)
        momAnimation.toValue = NSNumber(value: 0.08)
        momAnimation.duration = 0.1
        momAnimation.repeatCount = HUGE
        momAnimation.autoreverses = true
        self.contentView.layer.add(momAnimation, forKey: "centerLayer")
    }

    private func scaleAnimation(){
        self.contentView.layer.removeAllAnimations()
        let momAnimation = CABasicAnimation(keyPath: "transform.scale")
        momAnimation.fromValue = NSNumber(value: 0.97)
        momAnimation.toValue = NSNumber(value: 1.02)
        momAnimation.duration = 0.4
        momAnimation.repeatCount = HUGE
        momAnimation.autoreverses = true
        self.contentView.layer.add(momAnimation, forKey: "centerLayer")
    }

    private func hideAnimation() {
        self.contentView.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = CGAffineTransform(rotationAngle: CGFloat(-Float.pi / 2))
            self.contentView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
    }

}
