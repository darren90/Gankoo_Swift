//
//  BaseTabBarController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        if selectedViewController != nil {
            return (selectedViewController!.supportedInterfaceOrientations)
        }
        return .portrait
    }


    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if selectedViewController != nil {
            return (selectedViewController!.preferredInterfaceOrientationForPresentation)
        }
        return .portrait
    }


}
