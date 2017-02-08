//
//  DataListCell.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/8.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class DataListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!

    class func cellWithTableView(tableView:UITableView) -> DataListCell{
        let id = "DataListCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? DataListCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("DataListCell", owner: nil, options: nil)?.first as? DataListCell
        }
        return cell!
    }

    var model:DataModel?{
        didSet{
            nameLabel.text = model?.desc
            if model?.images != nil {
                let url = URL(string: (model?.images!.first)!)
                iconView.yy_setImage(with: url, placeholder: UIImage(named:"nopic_780x420"), options:  .setImageWithFadeAnimation, completion: nil)// .progressiveBlur
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
