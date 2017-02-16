//
//  HomeViewController.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/7.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit
import SafariServices

class HomeViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!

    var getDate:Date = Date()
    var refreshControl = UIRefreshControl()

    var dataArray:[DataListModel]? {
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        launchAnimation() 

        automaticallyAdjustsScrollViewInsets = false
        registerForPreviewing(with: self, sourceView: view)

        tableView.separatorStyle = .none
        //最底部的空间，设置距离底部的间距（autolayout），然后再设置这两个属性，就可以自动计算高度
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
 
        
        //添加刷新
        refreshControl.addTarget(self, action: #selector(self.loadNew),
                                 for: .valueChanged)
        tableView.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        loadNew()
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
        self.refreshControl.endRefreshing()
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
        noDataView.isHidden = !(dataArray?.count == 0)
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
        vc.model = model
        present(vc, animated: true, completion: nil)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController {
    //播放启动画面动画
    func launchAnimation() {
        //获取启动视图
        let vc = UIStoryboard(name: "LaunchScreen", bundle: nil)
            .instantiateViewController(withIdentifier: "launch")
        let launchview = vc.view!
        let delegate = UIApplication.shared.delegate
        delegate?.window!!.addSubview(launchview)
        //self.view.addSubview(launchview) //如果没有导航栏，直接添加到当前的view即可

        //播放动画效果，完毕后将其移除
        UIView.animate(withDuration: 1, delay: 1.2, options: .curveLinear,
                       animations: {
                        launchview.alpha = 0.0
                        let transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
                        launchview.layer.transform = transform
        }) { (finished) in
            launchview.removeFromSuperview()
        }
    }
}



extension HomeViewController : UIViewControllerPreviewingDelegate{


    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {

        guard let indexPath = tableView.indexPathForRow(at: location) , let cell = tableView.cellForRow(at: indexPath) else {
            return nil
        }

        let listModel = dataArray?[indexPath.section]
        let model = listModel?.dataArray?[indexPath.row]
        guard let urlStr = model?.url else {
            return nil
        }
        let url = URL(string: urlStr)
        let detailVc = DataDetailController(url: url!, entersReaderIfAvailable: true)
        detailVc.model = model

        detailVc.preferredContentSize = CGSize(width: 0, height: 0)
        previewingContext.sourceRect = cell.frame
        return detailVc

    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
}




