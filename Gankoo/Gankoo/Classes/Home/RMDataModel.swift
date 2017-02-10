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

    override init() {
        super.init()
    }

     var realm = { () -> Realm in
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let dbPath = docPath?.appending("/Gankoo.realm")
        let dbUrl = URL(fileURLWithPath: dbPath!)
        let rm = try! Realm(fileURL: dbUrl)
        return rm
    }()

    func getAllDatas()  -> [DataModel]{//
        let arrs = realm.objects(RMDataModel.self).sorted(byKeyPath: "date")

        var models = [DataModel]()
        for res  in arrs {
            let m = getModel(res)
            models.append(m)
        }
        return models
    }

    func addData(_ model:DataModel?){
        guard let model = model else {
            return
        }

        //已经存过了
        if isDataExist(model) == true {
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

        let predicate = NSPredicate(format: "_id = '\(model._id ?? "")'")

        guard let rsm = realm.objects(RMDataModel.self).filter(predicate).first else {
            return
        }

        realm.beginWrite()

//        let m = getDbModel(model)

        realm.delete(rsm)

        try! realm.commitWrite()
    }


    func isDataExist(_ model:DataModel?) -> Bool{
        guard let model = model else {
            return false
        }

        let predicate = NSPredicate(format: "_id = '\(model._id ?? "")'")
        let rsm = realm.objects(RMDataModel.self).filter(predicate).first

        if rsm == nil {
            return false
        }

         return true
    }

    func getDbModel(_ model:DataModel) -> RMDataModel{
        let m = RMDataModel()
        m._id = model._id ?? ""
        m.desc = model.desc ?? ""
        m.type = model.type ?? "未知"
        m.iconUrl = model.images?.first ?? ""
        m.who = model.who ?? "未知"
        m.date = Date()
        m.url = model.url ?? "https://github.com/darren90"
        return m
    }

    func getModel(_ model:RMDataModel) -> DataModel{
        let m = DataModel()
        m._id = model._id
        m.desc = model.desc
        m.type = model.type
        m.who = model.who
        m.images = [model.iconUrl]
        if model.iconUrl.characters.count == 0 {
            m.images = nil
        }
        m.url = model.url
        return m
    }


}

