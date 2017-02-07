//
//  GankooApi.swift
//  Gankoo
//
//  Created by Tengfei on 2017/2/7.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class GankooApi: NSObject {

    static let shareInstance:GankooApi = GankooApi()
    

    func getHomeData(finish:@escaping(_ models:[DataListModel]?,_ error:NSError?)->()){
        APINetTools.GET(urlStr: "https://gank.io/api/day/2015/08/07", parms: nil)  {(result : AnyObject?, error: NSError?) -> () in
            
            if(error != nil){
                finish(nil,error)
            }else{
                let categorys = result?["category"] as! [String]
                let dict = result?["results"] as! [String :AnyObject]
  
                var datas = [DataListModel]()
                for key in categorys {
                    let arr = dict[key] as? [[String : AnyObject]]
                    if let arr = arr {
                        var arrModels = [DataModel]()
                        for dict in arr {
                            let model = DataModel.init(dict: dict)
                            arrModels.append(model)
                        }
                        let dataModel = DataListModel(name: key, dataArray: arrModels)
                        datas.append(dataModel)
                    }
                }
                finish(datas, nil)
            }
            
        }
    }
    
    
}
