//
//  RMDataModel.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/9.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

import RealmSwift

class RMDataModel: Object {

    dynamic var _id = ""
    dynamic var desc = ""
    dynamic var type = ""
    dynamic var iconUrl = ""
    dynamic var url = ""
    dynamic var who = ""
    dynamic var date = Date()

}


class RMDBTools: NSObject {
    static let shareInstance:RMDBTools = RMDBTools()


    var realm = try! Realm()

    func getAllDatas(){// -> [DataModel]
        let arrs = realm.objects(RMDataModel.self).sorted(byKeyPath: "date")
//        Results
        print(arrs)
//        return arrs
    }

    func addData(_ model:DataModel?){
        guard let model = model else {
            return
        }

        realm.beginWrite()

        let m = getDbModel(model)

        realm.add(m)

        try! realm.commitWrite()
    }

    func deleData(_ model:DataModel?){
        guard let model = model else {
            return
        }

        realm.beginWrite()

        let m = getDbModel(model)

        realm.delete(m)

        try! realm.commitWrite()
    }


    func getDbModel(_ model:DataModel) -> RMDataModel{
        let m = RMDataModel()
        m._id = model._id ?? ""
        m.desc = model.desc ?? ""
        m.type = model.type ?? "未知"
        m.iconUrl = model.images?.first ?? ""
        m.who = model.who ?? "未知"
        m.date = Date()
        return m
    }

    func getModel(_ model:DataModel) -> RMDataModel{
        let m = RMDataModel()
        m._id = model._id ?? ""
        m.desc = model.desc ?? ""
        m.type = model.type ?? "未知"
        m.iconUrl = model.images?.first ?? ""
        m.who = model.who ?? "未知"
        m.date = Date()
        return m
    }


}

