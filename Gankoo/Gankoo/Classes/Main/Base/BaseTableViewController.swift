//
//  BaseTableViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    public var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        addTableView()
//        addLoadingView()
    }

    func addTableView() {
        let rect = CGRect(x: 0, y: 64, width: self.view.bounds.width, height: self.view.bounds.height-64)
        tableView = UITableView.init(frame: rect, style: .plain)
        self.view .addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView .dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        return cell!;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// 移除选中的状态
        tableView.deselectRow(at: indexPath, animated: true)


    }


}





