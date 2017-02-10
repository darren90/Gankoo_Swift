//
//  BaseViewController.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/10.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    lazy var noDataView = UIImageView(image: UIImage(named: "no_data_image"))

    override func viewDidLoad() {
        super.viewDidLoad()

        initNoDataView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        view.bringSubview(toFront: noDataView)
    }

    func initNoDataView(){
        view.addSubview(noDataView)
        noDataView.isHidden = true
        noDataView.center = view.center
        var frame = noDataView.frame
        frame.size.width = frame.size.width*0.8
        frame.size.height = frame.size.height*0.8
        frame.origin.y = frame.origin.y - 60
        noDataView.frame = frame
    }

    
    

    

}
