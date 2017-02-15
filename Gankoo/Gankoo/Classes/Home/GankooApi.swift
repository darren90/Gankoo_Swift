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
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY/MM/dd"
//        let dateStr = formatter.string(from: date)
//        let url = "https://gank.io/api/day/" + dateStr

        let dateStr = getHistoryAvalidDatas(date: date)
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
                //排个序，，，
                datas = datas.sorted(by: { (m1, m2) -> Bool in
                    return m1.name! < m2.name!
                })

                finish(datas, nil)
            }
        }
    }

    func getHomeData(dateStr:String,finish:@escaping(_ models:[DataListModel]?,_ error:NSError?)->()){

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


    func getFilePath() -> String{
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
        let result = (path as NSString).appendingPathComponent("history_data.plist")
        return result
    }


    func getHistoryDatas() -> [String]?{
        let filePath = self.getFilePath()
        let array = NSArray(contentsOfFile: filePath)
        return array as! [String]?
    }


    func getHistoryAvalidDatas(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        let dateStr = formatter.string(from: date)
        
        let defaultDateStr = "2017/02/08"

        guard let avalids = getHistoryDatas() else{
            return defaultDateStr
        }

        if (avalids as NSArray).contains(dateStr) {
            return dateStr
        }

        return avalids.first!
    }

    //获取发过干活的日期
    func getSeverHistoryDates(){
        //http://gank.io/api/data/数据类型/请求个数/第几页  https://gank.io/api/data/福利/18/1
        let url = "https://gank.io/api/day/history"

        APINetTools.GET(urlStr: url, parms: nil)  {(result : AnyObject?, error: NSError?) -> () in

            if(error != nil){
//                finish(nil,error)
            }else{
                let arr = result?["results"] as? [String]
                if let arr = arr {
                    var arrStr = [String]()
                    for var str in arr {
                        str = str.replacingOccurrences(of: "-", with: "/")
                        arrStr.append(str)
                    }
                    let filePath = self.getFilePath()
                    NSArray(array: arrStr).write(toFile: filePath, atomically: true)
//                    finish(arrStr, nil)
                }else{
//                    finish(nil,error)
                }
            }
        }
    }

    


}






































