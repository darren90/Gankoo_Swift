//
//  SpotlightTool.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/10.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

import CoreSpotlight
import MobileCoreServices
import YYWebImage

class SpotlightTool: NSObject {

    static let shareInstance:SpotlightTool = SpotlightTool()

    func addCSImgItem(title:String,imageUrl:String?,keyword:[String]){
        //用kUTTypeImage 或者 kUTTypeText 没啥影响
        let attr = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
        
        attr.title = title
        attr.keywords = keyword
//        attr.contentDescription = "描述信息"

        if imageUrl != nil {
            let cache = YYWebImageManager.shared().cache
            let image = cache?.getImageForKey(imageUrl!)

            if image != nil {
                attr.thumbnailData = UIImagePNGRepresentation(image!)
            }
        }

        let sm = CSSearchableItem(uniqueIdentifier: "gankoo", domainIdentifier: "open-file-2", attributeSet: attr)

        CSSearchableIndex.default().indexSearchableItems([sm], completionHandler: { error in
            if error != nil{
                print("创建Spotlight索引失败:\(error?.localizedDescription)")
            }
        })
    }

    func addCSAll(){
        deleAllCS()
        
        //获取所有可用的数据
        let allModels = RMDBTools.shareInstance.getAllDatas()

        if allModels.count == 0 { return  }

        var items = [CSSearchableItem]()

        for model in allModels{
            //用kUTTypeImage 或者 kUTTypeText 没啥影响
            let attr = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
            
            let keywords = [model.who ?? "",model.type ?? ""]
            attr.title = model.desc
            attr.keywords = keywords

            let imageUrl = model.images?.first
            if imageUrl != nil {
                let cache = YYWebImageManager.shared().cache
                let image = cache?.getImageForKey(imageUrl!)

                if image != nil {
                    attr.thumbnailData = UIImagePNGRepresentation(image!)
                }
            }

            let sm = CSSearchableItem(uniqueIdentifier: "gankoo", domainIdentifier: "open-file+\(model._id)", attributeSet: attr)

            items.append(sm)
        }

        CSSearchableIndex.default().indexSearchableItems(items, completionHandler: { error in
            if error != nil{
                print("创建Spotlight索引失败:\(error?.localizedDescription)")
            }
        })

    }


    func deleAllCS(){
        CSSearchableIndex.default().deleteAllSearchableItems { (error) in
            if error != nil{
                print("删除所有Spotlight索引失败:\(error?.localizedDescription)")
            }else{
                print("删除所有Spotlight索引成功")
            }
        }
    }

}
