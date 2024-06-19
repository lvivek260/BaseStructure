//
//  UICollectionView+Extension.swift
//  LMS
//
//  Created by PHN MAC 1 on 08/01/24.
//

import UIKit

extension UICollectionView {
  var visibleCurrentCellIndexPath: IndexPath? {
    for cell in self.visibleCells {
      let indexPath = self.indexPath(for: cell)
      return indexPath
    }
    
    return nil
  }
}
