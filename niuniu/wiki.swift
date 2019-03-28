//
//  wiki.swift
//  BangcleCryptoTool
//
//  Created by 范腾飞 on 2019/3/19.
//

import UIKit

@objc
public class wiki: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black

        let v = grid()
        self.view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
    }
}


class grid: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    let itemLayout = 5
    var itemSize = CGSize.init(width: 60, height: 60)

    var itemCount: Int = 0
    var items: [Int] = []

    override init(frame: CGRect) {
        super.init(frame: frame)

        let length = (UIScreen.main.bounds.size.width - 20) / CGFloat(itemLayout)
        itemSize = CGSize(width: length, height: length)
        itemCount = itemLayout * 6

        while items.count < itemCount {
            let n1 = randomInt()
            items.append(n1)
            items.append(10 - n1)

            if items.count >= itemCount {
                break
            }

            let n2 = n1 / 2 + 5
            items.append(n2)
            items.append(10 - n2)
        }

        itemCount = items.count
        items = shuffleArray(arr: items)

        self.addSubview(clv)
        clv.snp.makeConstraints { (make) in
            make.width.equalTo(min(UIScreen.main.bounds.size.width, 600))
            make.height.equalTo((length) * 6 + 20)
            make.edges.equalTo(0)
        }
    }

    private func randomInt() -> Int {
        return Int(arc4random() % (9-1) + 1)
    }

    private func shuffleArray(arr:[Int]) -> [Int] {
        var data:[Int] = arr
        for i in 1..<arr.count {
            let index:Int = Int(arc4random()) % i
            if index != i {
                data.swapAt(i, index)
            }
        }
        return data
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var clv: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = itemSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        let v = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        v.delegate = self
        v.dataSource = self
        v.isPagingEnabled = false
        v.isScrollEnabled = false
        v.isPrefetchingEnabled = false
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        v.allowsMultipleSelection = true
        v.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.description())
        return v
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.description(), for: indexPath) as? ItemCell else {
            return UICollectionViewCell()
        }

        cell.bindData(count: items[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath) as! ItemCell
        if cell.isDestroies == true {
            return false
        }

        guard let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.count >= 1 else {
            return true
        }

        let cell1 = collectionView.cellForItem(at: selectedItems[0]) as! ItemCell
        collectionView.deselectItem(at: selectedItems[0], animated: true)

        if cell.numberValue + cell1.numberValue != 10 {
            // failure

        } else {
            // success

            cell.isDestroies = true
            cell1.isDestroies = true
        }
        
        return false
    }
}




