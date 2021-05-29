//
//  File.swift
//  
//
//  Created by Mihaela Mihaljevic Jakic on 29.05.2021..
//

import UniteKit
@testable import UniteKitTableViewHandlers

// MARK: -
// MARK: Class for TableViewItemDelegate -

class TableViewItemDelegateClass {
  var tapCounter = 0
}

extension TableViewItemDelegateClass: UKTableViewItemDelegate {
  func didTapOn(dataSource: Any, item: Any) {
    tapCounter += 1
  }
}
