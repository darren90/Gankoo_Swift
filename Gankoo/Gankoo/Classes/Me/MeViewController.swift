//
//  MeViewController.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/7.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController {

    lazy var tableView:UITableView = UITableView(frame: self.view.bounds, style: .plain)

    var dataArray:[DataModel] = [DataModel](){
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false

        initTableView()

        //最底部的空间，设置距离底部的间距（autolayout），然后再设置这两个属性，就可以自动计算高度
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        dataArray = RMDBTools.shareInstance.getAllDatas()
    }

    func initTableView(){
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 64, width: view.frame.size.width, height: view.frame.height - 64 - 49)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white

        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.loadNew))
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
//        tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(self.loadMore))

//        tableView.isEditing
        //多行编辑
//        tableView.allowsMultipleSelectionDuringEditing = true
    }


    func loadNew() {
        endReresh()

        dataArray = RMDBTools.shareInstance.getAllDatas()
    }

    func endReresh(){
        self.tableView.mj_header.endRefreshing()
//        self.tableView.mj_footer.endRefreshing()
    }
}

extension MeViewController : UITableViewDataSource,UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noDataView.isHidden = !(dataArray.count == 0)
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
        if urlStr.characters.count == 0 {
            return
        }
        let url = URL(string: urlStr)
        let vc = DataDetailController(url: url!, entersReaderIfAvailable: true)
        present(vc, animated: true, completion: nil)

        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {//删除操作

        }
    }


    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleAction = UITableViewRowAction(style: .destructive, title: "取消收藏", handler: { (action, indexPath) in
            let model = self.dataArray[indexPath.row]
            RMDBTools.shareInstance.deleData(model)
            self.dataArray.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .left)

//            self.noDataView.isHidden = !(self.dataArray.count == 0)
        })
        return [deleAction]
    }

}





















