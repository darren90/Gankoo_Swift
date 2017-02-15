//
//  SortViewController.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/7.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class SortViewController: UIViewController {

//    @IBOutlet weak var tableView: UITableView!
    let sorts = ["全部", "iOS", "Android", "App", "前端", "拓展资源", "瞎推荐", "休息视频","福利"]

    lazy var slideView:DLCustomSlideView = DLCustomSlideView(frame: self.view.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
 
        initTabbar()

//        }
    }


//    func initSegmet(){
//        let w = view.frame.width
//        let s = PinterestSegment(frame: CGRect(x: 10, y: 64, width: w - 20, height: 40), titles:sorts)
//        s.style.titleFont = UIFont.systemFont(ofSize: 14, weight: 5)
//        view.addSubview(s)
//
//        s.valueChange = { index in
//            print(index)
//        }
//    }


    func initTabbar(){
        automaticallyAdjustsScrollViewInsets = false

        view.addSubview(slideView)
        slideView.frame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height-64-49)

        let cache = DLLRUCache.init(count: 6)
        let tabbar = DLScrollTabbarView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 34))
        let holeColor = UIColor(colorLiteralRed: 61/255.0, green: 168/255.0, blue: 245/255.0, alpha: 1.0)
        tabbar.tabItemNormalColor = UIColor.black
        tabbar.tabItemSelectedColor = holeColor
        tabbar.trackColor = holeColor
        tabbar.tabItemNormalFontSize = 14.0

        var arrs = [DLScrollTabbarItem]()
        for name in sorts {
            var w = CGFloat(name.characters.count*22)
            if name == "iOS" || name == "App" {
                w = 50
            }else if name == "Android"{
                w = 60
            }
            let item = DLScrollTabbarItem(title: name, width: w)
            arrs.append(item!)
        }

        slideView.delegate =  self
        tabbar.tabbarItems = arrs
        slideView.tabbar = tabbar
        slideView.cache = cache
        slideView.tabbarBottomSpacing = 0.0
        slideView.baseViewController = self
        slideView.setup()
        slideView.selectedIndex = 0
    }
}


extension SortViewController : DLCustomSlideViewDelegate{
    public func numberOfTabs(in sender: DLCustomSlideView!) -> Int {
        return sorts.count
    }

    func dlCustomSlideView(_ sender: DLCustomSlideView!, controllerAt index: Int) -> UIViewController! {
        let name = sorts[index]
        let vc = SortDataViewController()
        vc.sortName = name
        return vc
    }

    func dlCustomSlideView(_ sender: DLCustomSlideView!, didSelectedAt index: Int) {
        let name = sorts[index]
        navigationItem.title = name
    }
}






















