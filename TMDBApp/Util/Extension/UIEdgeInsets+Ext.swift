//
//  UIEdgesInset+Ext.swift
//  TMDBApp
//
//  Created by Mac on 25/01/21.
//

import Foundation
import UIKit

extension UIEdgeInsets {
    var updateEdgeInsets: UIEdgeInsets {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else {
            return UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
}
