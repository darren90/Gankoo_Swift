//
//  TFCycleScrollView.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/7.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

protocol TFCycleScrollViewDelegate {
//    func cycleScrollViewDidSelectAtIndex
}

class TFCycleScrollView: UIView {

    var imgsArray:[String]?{
        didSet{

        }
    }

    var dataArray:[String]?
    lazy var waterView:UICollectionView = UICollectionView(frame: self.frame, collectionViewLayout: UICollectionViewFlowLayout())

    lazy var pageControl:UIPageControl = UIPageControl()

    override init(frame: CGRect) {
        super.init(frame: frame)

        initSubViews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func initSubViews(){
        self .addSubview(waterView)
        waterView.isPagingEnabled = true
        waterView.delegate = self
        waterView.dataSource = self
        waterView.showsHorizontalScrollIndicator = false
        waterView.backgroundColor = UIColor.white
        
    }


}


extension TFCycleScrollView : UICollectionViewDataSource,UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataArray?.count)!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

}











