//
//  DataDetailController.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/8.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit
import SafariServices

class DataDetailController: SFSafariViewController {

    lazy var btn = UIButton(type: .custom)

    var listId:String?

    var model:DataModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        addCollectBtn()
        delegate = self
    }


    func addCollectBtn(){
        view.addSubview(btn)

        btn.frame = CGRect(x: UIScreen.main.bounds.width-30-50, y:UIScreen.main.bounds.height-30-60, width: 30, height: 30)
//        btn.backgroundColor = UIColor.red
        btn.setImage(UIImage(named:"add"), for: .normal)
        btn.addTarget(self, action: #selector(self.collectionAction), for: .touchUpInside)
    }


    func collectionAction(){
        print("收藏文字的id:\(listId)")

        RMDBTools.shareInstance.addData(model)
        RMDBTools.shareInstance.getAllDatas()
    }

}

extension DataDetailController : SFSafariViewControllerDelegate {
    //关闭
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {

    }
    //加载完毕
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {

        if didLoadSuccessfully {
            self.view.bringSubview(toFront: btn)
        }

    }

    

}
