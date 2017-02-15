
//
//  SortDataViewController.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/8.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class SortDataViewController: BaseViewController {

    lazy var tableView:UITableView = UITableView(frame: self.view.bounds, style: .plain)

    var sortName:String? 
    var page:Int = 1
    var dataArray:[DataModel] = [DataModel]()

    //刷新控制器
    var refreshControl = UIRefreshControl()
    let activityViewIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)

    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()

        //最底部的空间，设置距离底部的间距（autolayout），然后再设置这两个属性，就可以自动计算高度
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
    }


    func initTableView(){
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height - 34 - 64 - 49)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
    
        setupRefreshcontrol()
    }
    //上拉刷新
    fileprivate func setupRefreshcontrol() {
        //添加下拉刷新
        refreshControl.addTarget(self, action: #selector(self.loadNew),
                                 for: .valueChanged)
        tableView.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        loadNew()
        
        //添加下拉加载更多
        let loadMoreView:UIView = UIView(frame: CGRect(x: 0, y: self.tableView.contentSize.height, width: self.tableView.bounds.size.width, height: 40))
        loadMoreView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        loadMoreView.backgroundColor = UIColor.white
        activityViewIndicator.color = UIColor.darkGray
        activityViewIndicator.frame = CGRect(x: loadMoreView.frame.size.width/2-activityViewIndicator.frame.width/2, y: loadMoreView.frame.size.height/2-activityViewIndicator.frame.height/2, width: activityViewIndicator.frame.width, height: activityViewIndicator.frame.height)
        //        activityViewIndicator.startAnimating()
        loadMoreView.addSubview(activityViewIndicator)
        
        self.tableView.tableFooterView = loadMoreView
    }


    func loadNew() {
        page = 1

        loadDatas(isNewData: true)
    }

    func loadMore(){
        self.activityViewIndicator.startAnimating()
        
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
        self.refreshControl.endRefreshing()
        self.activityViewIndicator.stopAnimating()
    }
}

extension SortDataViewController : UITableViewDataSource,UITableViewDelegate{

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
        let url = URL(string: urlStr)
        let vc = DataDetailController(url: url!, entersReaderIfAvailable: true)
        vc.model = model
        present(vc, animated: true, completion: nil)

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //判断上拉加载更多的触发时机
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollView.contentOffset.y:\(scrollView.contentOffset.y)")
        
        if self.page == 1, scrollView.contentOffset.y <= 0 { return }
        
        let y1 = scrollView.contentOffset.y + scrollView.frame.height
        let y2 = scrollView.contentSize.height
        print("scrollViewDidEndDragging--y1:\(y1),y2:\(y2)")
        if scrollView.contentOffset.y + scrollView.frame.height >= scrollView.contentSize.height {
            print("begain refresh")
            
            self.loadMore()
        }
    }

    
}






























