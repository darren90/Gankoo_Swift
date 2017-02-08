//
//  HomeViewController.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/7.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var getDate:Date = Date()

    var dataArray:[DataListModel]? {
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false

        tableView.separatorStyle = .none
        //最底部的空间，设置距离底部的间距（autolayout），然后再设置这两个属性，就可以自动计算高度
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.loadNew))
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
    }

    func loadNew() {
        GankooApi.shareInstance.getHomeData(date:getDate) { ( result : [DataListModel]?, error : NSError?) in
            self.endReresh()

            if error == nil{
                self.dataArray = result
            }else{

            }
            
        }
    }

    func endReresh(){
        self.tableView.mj_header.endRefreshing()
        self.tableView.mj_header.isHidden = true
//        self.tableView.mj_footer.endRefreshing()
    }

    @IBAction func dateAction(_ sender: UIBarButtonItem) {
        datePickAction()
    }

    func datePickAction() {
        let current = Date()
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 15)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 15)
        let picker = DateTimePicker.show(selected: current, minimumDate: min, maximumDate: max)
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.doneButtonTitle = "!! DONE DONE !!"
        picker.todayButtonTitle = "Today"
        picker.completionHandler = { date in
            //            self.current = date
            self.getDate = date
            self.loadNew()
        }
    }
    
}

extension HomeViewController : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = dataArray?[section].dataArray
        return array?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = DataSectionHeaderView.headerWithTableView(tableView: tableView)
        let listModel = dataArray?[section]
        header.title = listModel?.name
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DataListCell.cellWithTableView(tableView: tableView)

        let listModel = dataArray?[indexPath.section]
        let model = listModel?.dataArray?[indexPath.row]
        cell.model = model
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listModel = dataArray?[indexPath.section]
        let model = listModel?.dataArray?[indexPath.row]
        guard let urlStr = model?.url else {
             return
        }
        let url = URL(string: urlStr)
        let vc = DataDetailController(url: url!, entersReaderIfAvailable: true)
        vc.listId = model?._id
        present(vc, animated: true, completion: nil)

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}





