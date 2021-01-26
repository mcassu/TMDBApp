//
//  UICollectionView+Ext.swift
//  TMDBApp
//
//  Created by Cassu on 25/01/21.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func scrollTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.scrollToItem(at: indexPath, at: .top, animated: true)
    }

}
