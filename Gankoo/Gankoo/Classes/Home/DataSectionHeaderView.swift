//
//  DataSectionHeaderView.swift
//  Gankoo
//
//  Created by Tengfei on 2017/2/9.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class DataSectionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
   
    class func headerWithTableView(tableView:UITableView) -> DataSectionHeaderView{
        let id = "header"
        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: id) as? DataSectionHeaderView
        if header == nil {
            header = Bundle.main.loadNibNamed("DataSectionHeaderView", owner: nil, options: nil)?.first as? DataSectionHeaderView
        }
        return header!
    }


    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = UIColor.white
    }
    
    var title:String?{
        didSet{
            titleLabel.text = title
        }
    }
}
