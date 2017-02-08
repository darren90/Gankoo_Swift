//
//  HomeModel.swift
//  Gankoo
//
//  Created by Tengfei on 2017/2/7.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class DataModel: NSObject {

//    "_id":"56cc6d23421aa95caa707c68",
//    "createdAt":"2015-08-06T13:06:17.211Z",
//    "desc":"听到就心情大好的歌，简直妖魔哈哈哈哈哈，原地址 http://v.youku.com/v_show/id_XMTQxODA5NDM2.html",
//    "publishedAt":"2015-08-07T03:57:48.104Z",
//    "type":"休息视频",
//    "url":"http://www.zhihu.com/question/21778055/answer/19905413?utm_source=weibo&utm_medium=weibo_share&utm_content=share_answer&utm_campaign=share_button",
//    "used":true,
//    "who":"lxxself"
    
    var _id:String?
    var createdAt:String?
    var desc:String?
    var publishedAt:String?
    var type:String?
    var url:String?
    var used:Bool = false
    var who:String?
    var images:[String]?
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)

//        if let imgs = dict["images"] as? [String] {
//            var arr:[String] = [String]()
//            print(imgs)
//            for img in imgs {
//                arr.append(img)
//            }
//            images = arr
//        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    
    
    
    
    
}
