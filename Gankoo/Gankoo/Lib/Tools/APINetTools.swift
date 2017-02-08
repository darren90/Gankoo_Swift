//
//  APINetTools.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/22.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

import Alamofire
//import Swif


enum RequestType:String{
    case GET = "GET"
    case POST = "POST"
}

class APINetTools: NSObject {
    static let cid = 11
    static let client = 1
    static let accesskey = "f1a1a3a891ccdcfd08038c8678dcab53"


    static func GET(urlStr:String,parms:[String : AnyObject]?,fininsh : @escaping (_ result:AnyObject? , _ error:NSError?) -> ()){

        Alamofire.request(urlStr, method: .get).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
//                print("-- get request data:\(response.result.value)")
                fininsh(response.result.value! as AnyObject,nil)
            case false:
//                print("-- get request error:\(response.result.error!)")
                 fininsh(nil,response.result.error as NSError?)
            }
        }
    }

    
    static func POST(urlStr:String,parms:[String : AnyObject]?,fininsh : @escaping (_ result:AnyObject? , _ error:NSError?) -> ()){


        Alamofire.request(urlStr, method: .post).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
//                print("-- post request data:\(response.result.value)")
                fininsh(response.result.value! as AnyObject,nil)
            case false:
//                print("-- post request error:\(response.result.error!)")
                fininsh(nil,response.result.error as NSError?)
            }
        }
    }

    static func getUrl(urlStr:String) -> String {
        let timestamp = Int(NSDate().timeIntervalSince1970)
        let md5Str = "\(cid)$$\(accesskey)&&\(timestamp)".md5!
        //        print("md5Str:\(md5Str),after:\(md5Str.md5!)")

        var url = urlStr
        if (urlStr.contains("?")){
            url = url + "&cid=\(cid)"+"&client=\(client)"+"&timestamp=\(timestamp)" + "&accesskey=\(md5Str)"
        } else {
             url = url + "?cid=\(cid)"+"&client=\(client)"+"&timestamp=\(timestamp)" + "&accesskey=\(md5Str)"
        }
        print("--timestamp:\(timestamp)--md5:\(md5Str),\n\n url:\(url)")

        return url
    }


}

/*
 


*/


















