//
//  TFCycleScrollView.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/7.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

let TFSection = 100

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

    var timer : Timer?

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
        waterView.frame = self.bounds

        let flowLayout = waterView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = self.frame.size
        flowLayout.scrollDirection = .horizontal
    }


    override func layoutSubviews() {
        super.layoutSubviews()


    }

    func addTimer(){
        if timer != nil {
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.goToNext), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .commonModes)
        }
    }


    func goToNext(){

    }

}


extension TFCycleScrollView : UICollectionViewDataSource,UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TFSection
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











