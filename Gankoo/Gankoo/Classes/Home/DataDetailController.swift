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

        //判断
        if RMDBTools.shareInstance.isDataExist(model) {//已经收藏
            btn.setImage(UIImage(named:"home_sc_n"), for: .highlighted)
            btn.setImage(UIImage(named:"home_sc_h"), for: .normal)
        }else{  //没有收藏
            btn.setImage(UIImage(named:"home_sc_n"), for: .normal)
            btn.setImage(UIImage(named:"home_sc_h"), for: .highlighted)
        }

        btn.addTarget(self, action: #selector(self.collectionAction(_:)), for: .touchUpInside)
    }


    func collectionAction(_ btn:UIButton){

        RMDBTools.shareInstance.addData(model)

          UIView.animate(withDuration: 0.25, animations: {
            btn.transform = CGAffineTransform(scaleX: 1.3, y: 1.3);//放大
          }) { (_) in
            if RMDBTools.shareInstance.isDataExist(self.model) {//已经收藏
                btn.setImage(UIImage(named:"home_sc_n"), for: .highlighted)
                btn.setImage(UIImage(named:"home_sc_h"), for: .normal)
            }else{  //没有收藏
                btn.setImage(UIImage(named:"home_sc_n"), for: .normal)
                btn.setImage(UIImage(named:"home_sc_h"), for: .highlighted)
            }

            UIView.animate(withDuration: 0.25, animations: {
                btn.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.25, animations: { 
                    btn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            })
        }

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
