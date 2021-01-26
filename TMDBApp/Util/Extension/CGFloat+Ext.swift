//
//  CGFloat+Ext.swift
//  TMDBApp
//
//  Created by Cassu on 25/01/21.
//

import Foundation
import UIKit

extension CGFloat {
    
    mutating func updateCellSize(isInitial: Bool = false) {
            var Divisor: CGFloat = 0.0
            if UIDevice.current.userInterfaceIdiom == .pad {
                if UIScreen.main.bounds.height < UIScreen.main.bounds.width {
                    Divisor = 4.1
                }else {
                    Divisor = 3.1
                }
            }else {
                if isInitial {
                    if UIScreen.main.bounds.height < UIScreen.main.bounds.width {
                        Divisor = 3.1
                    }else {
                        Divisor = 2.1
                    }
                }else {
                    if UIDevice.current.orientation.isLandscape {
                        Divisor = 3.1
                    }else {
                        Divisor = 2.1
                    }
                }
            }
        self = Divisor
    }
}
