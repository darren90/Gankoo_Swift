//
//  HomeViewController.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/7.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray:[DataListModel]? {
        didSet{
            //            tableView.reloadData()
            tableView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        GankooApi.shareInstance.getHomeData { ( result : [DataListModel]?, error : NSError?) in
            if error == nil{
                
                self.dataArray = result
            }else{
            }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "123")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "123")
        }
        cell?.backgroundColor = UIColor.brown
        return cell!
    }
    
}





