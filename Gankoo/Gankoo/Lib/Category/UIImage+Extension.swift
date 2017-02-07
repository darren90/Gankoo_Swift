//
//  UIImage+Extension.swift
//  01_ProjectBase
//
//  Created by Fengtf on 2016/12/2.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

extension UIImage {

    func imageWithTintColor(color:UIColor) -> UIImage {
        return imageWithTintColor(color: color, benModel: .destinationIn)
    }

    func imageWithTintColor(color:UIColor,benModel:CGBlendMode) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        color .setFill()
        let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)

        self.draw(in: bounds, blendMode: benModel, alpha: 1.0)

        if benModel != .destinationIn{
            self.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        }

        let tintImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return tintImg!
    }
}
