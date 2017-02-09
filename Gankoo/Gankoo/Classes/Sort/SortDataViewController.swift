
//
//  SortDataViewController.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/8.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class SortDataViewController: UIViewController {

    lazy var tableView:UITableView = UITableView(frame: self.view.bounds, style: .plain)


    var sortName:String? 
    var page:Int = 1
    var dataArray:[DataModel] = [DataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()

        //最底部的空间，设置距离底部的间距（autolayout），然后再设置这两个属性，就可以自动计算高度
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

    }


    func initTableView(){
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height - 34 - 64 - 49)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.loadNew))
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()

        tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(self.loadMore))
    }


    func loadNew() {
        page = 1

        loadDatas(isNewData: true)
    }

    func loadMore(){
        page = page + 1

        loadDatas(isNewData: false)
    }

    func loadDatas(isNewData:Bool){
        GankooApi.shareInstance.getSortDatas(sortName: sortName ?? "全部", page: page) { (result :[DataModel]?, error : NSError?) in
            self.endReresh()
            if(error == nil){
                if isNewData {
                    self.dataArray = result!
                }else{
                    self.dataArray = self.dataArray + result!
                }
                self.tableView.reloadData()
            }else{

            }
        }
    }

    func endReresh(){
        self.tableView.mj_header.endRefreshing()
        self.tableView.mj_footer.endRefreshing()
    }
}

extension SortDataViewController : UITableViewDataSource,UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        let array = dataArray?[section].dataArray
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DataListCell.cellWithTableView(tableView: tableView)
        let model = dataArray[indexPath.row]
        cell.model = model
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataArray[indexPath.row]
        guard let urlStr = model.url else {
            return
        }
        let url = URL(string: urlStr)
        let vc = DataDetailController(url: url!, entersReaderIfAvailable: true)
        vc.listId = model._id
        present(vc, animated: true, completion: nil)

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}






























