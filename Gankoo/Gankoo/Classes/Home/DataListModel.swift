//
//  DataListModel.swift
//  Gankoo
//
//  Created by Tengfei on 2017/2/7.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class DataListModel: NSObject {

    var name:String?
    
    var dataArray:[DataModel]?
    
    
    init(name:String,dataArray:[DataModel]) {
        self.name = name
        self.dataArray = dataArray
    }
    
}
