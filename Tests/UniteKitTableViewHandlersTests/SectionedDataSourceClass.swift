//
//  File.swift
//  
//
//  Created by Mihaela Mihaljevic Jakic on 29.05.2021..
//

import Foundation
import UniteKit
import MMJSectionedDataSource

#if os(iOS) || os(tvOS)
import UIKit
#endif

#if os(OSX)
import Cocoa
#endif

class SectionedDataSourceClass {
  let items = ["one", "two", "three", "four"]
  let checked = ["one", "four"]
}

extension SectionedDataSourceClass: SectionedDataSource {
  func numberOfSections() -> Int {
    return 1
  }
  
  func numberOfItemsInSection(_ section: Int) -> Int {
    return items.count
  }
  
  func sectionTitleAt(_ indexPath: IndexPath) -> String {
    return ""
  }
  
  func itemTitleAt(_ indexPath: IndexPath) -> String {
    return items[safe: indexPath.item] ?? "N/A"
  }
  
  func sectionlessItemTitleAt(_ index: Int) -> String {
    let indexPath = IndexPath(item: index, section: 0)
    return itemTitleAt(indexPath)
  }
  
  func sectionAt(_ indexPath: IndexPath) -> Any? {
    return nil
  }
  
  func itemAt(_ indexPath: IndexPath) -> Any? {
    return items[safe: indexPath.item]
  }
  
  func sectionlessItemAt(_ index: Int) -> Any? {
    let indexPath = IndexPath(item: index, section: 0)
    return itemAt(indexPath)
  }
  
  func itemIsCheckedAt(_ indexPath: IndexPath) -> Bool {
    if let item = itemAt(indexPath) as? String {
      return checked.contains(item)
    }
    return false
  }
  
  func sectionlessItemIsCheckedAt(_ index: Int) -> Bool {
    let indexPath = IndexPath(item: index, section: 0)
    return itemIsCheckedAt(indexPath)
  }
  
}
