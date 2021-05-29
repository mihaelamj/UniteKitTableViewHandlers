//
//  UKTableViewDelegateClass.swift
//  UniteKitTableViewHandlers
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

// MARK: -
// MARK: UKTableViewDelegateClass -

public class UKTableViewDelegateClass: UKTableViewHandlerClass {
  
  public weak var itemDelegate: UKTableViewItemDelegate?
  public weak var sectionHandler: SectionedDataSource?
  public weak var registrant: UKTableViewRegistrant?
  
  #if os(OSX)
  let tableHelper = UKNSTableViewHelper()
  #endif
  
  public init(itemDelegateImplementation: UKTableViewItemDelegate? = nil,
              sectionHandlerImplementation: SectionedDataSource? = nil,
              registrant: UKTableViewRegistrant? = nil) {
    self.itemDelegate = itemDelegateImplementation
    self.sectionHandler = sectionHandlerImplementation
    self.registrant = registrant
  }
}

extension UKTableViewDelegateClass: UKTableViewDelegate {
  
  #if os(iOS) || os(tvOS)
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let item = sectionHandler?.itemAt(indexPath) else {
      preconditionFailure("Error, no item in section: \(indexPath.section), row: \(indexPath.row)!")
    }
    itemDelegate?.didTapOn(dataSource: self, item: item)
  }
  
  //INFO: This is how we get rid of the last tableViewCell separator -
  public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  #endif
  
  #if os(OSX)
  public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    
    guard let column = tableColumn else { preconditionFailure("Error, table colimn is nil!") }
    
    guard let itemHandler = sectionHandler else { preconditionFailure("Error, no item handler") }
    
    // fetch Column Index & identifier
    guard let columnIndex = tableHelper.fetchIndexOfColumnIn(tableView, tableColumn: column) else {
      preconditionFailure("Error, column: \(column), is not among table columns!")
    }
    guard let cellIdenifier = registrant?.identifierFor(column: columnIndex) else {
      preconditionFailure("Error, no Cell identifier for item in column in index: \(columnIndex)!")
    }
    
    var cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdenifier), owner: self) as? NSTextField
    if cell == nil { cell = tableHelper.makeTextField(tableView) }
    
    if let cell = cell {
      cell.identifier = NSUserInterfaceItemIdentifier(rawValue: cellIdenifier)
      
      let cellText = itemHandler.sectionlessItemTitleAt(row); let cellTextChecked = "\(cellText)✅"
      let firstColumnText = itemHandler.sectionlessItemIsCheckedAt(row) ? cellTextChecked : cellText
      let secondColumnText = itemHandler.sectionlessItemIsCheckedAt(row) ? "Finished" : "NOT Finished"
      
      cell.stringValue = columnIndex == 0 ? firstColumnText : secondColumnText
      cell.textColor = defaultTextColor
      cell.backgroundColor = .clear
      
      cell.isBezeled = false
      cell.isEditable = false
    }
    return cell
  }
  
  public func tableView(_ tableView: NSTableView,  heightOfRow row: Int) -> CGFloat  {
    return 190.0
  }
  
  public func tableViewSelectionDidChange(_ notification: Notification) {
    guard let theTableView = notification.object as? NSTableView else { return }
    let indexes = theTableView.selectedRowIndexes
    if let index = indexes.first {
      if let item = sectionHandler?.sectionlessItemAt(index) {
        itemDelegate?.didTapOn(dataSource: self, item: item)
      }
    }
  }
  #endif
  
}
