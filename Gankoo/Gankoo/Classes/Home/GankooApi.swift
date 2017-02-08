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
    

    func getHomeData(date:Date,finish:@escaping(_ models:[DataListModel]?,_ error:NSError?)->()){

        //https://gank.io/api/day/2017/02/08
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        let dateStr = formatter.string(from: date)
        let url = "https://gank.io/api/day/" + dateStr

        APINetTools.GET(urlStr: url, parms: nil)  {(result : AnyObject?, error: NSError?) -> () in
            
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



    func getSortDatas(sortName:String , page:Int , finish:@escaping(_ models:[DataModel]?,_ error:NSError?)->()){
        //http://gank.io/api/data/数据类型/请求个数/第几页  https://gank.io/api/data/福利/18/1
        var url = "https://gank.io/api/data/"
        var sort = sortName
        if sortName == "全部" {
            sort = "all"
        }
        let cs=NSCharacterSet(charactersIn:"`#%^{}\"[]|\\<>//").inverted
        url = url + sort.addingPercentEncoding(withAllowedCharacters: cs)! +  "/18/\(page)"

        APINetTools.GET(urlStr: url, parms: nil)  {(result : AnyObject?, error: NSError?) -> () in

            if(error != nil){
                finish(nil,error)
            }else{
                let arr = result?["results"] as? [[String : AnyObject]]
                if let arr = arr {
                    var arrModels = [DataModel]()
                    for dict in arr {
                        let model = DataModel.init(dict: dict)
                        arrModels.append(model)
                    }
                    finish(arrModels, nil)
                }else{
                    finish(nil,error)
                }
            }
        }
    }

    
//    https://gank.io/api/day/history
    //获取发过干活的日期

}




















