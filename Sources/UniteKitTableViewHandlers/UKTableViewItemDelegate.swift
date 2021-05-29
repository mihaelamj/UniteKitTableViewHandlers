//
//  UKTableViewItemDelegate.swift
//  
//
//  Created by Mihaela Mihaljevic Jakic on 29.05.2021..
//

import Foundation

public protocol UKTableViewItemDelegate: AnyObject {
  func didTapOn(dataSource: Any, item: Any)
}
