//
//  UKTableViewDelegateClassTests.swift
//  
//
//  Created by Mihaela Mihaljevic Jakic on 29.05.2021..
//

import XCTest
import UniteKit
@testable import UniteKitTableViewHandlers

#if os(iOS) || os(tvOS)
import UIKit
#endif

#if os(OSX)
import Cocoa
#endif

final class UKTableViewDelegateClassTests: XCTestCase {
  
  static var registrant: UKTableViewRegistrant!
  static var sectionedDataSource: SectionedDataSourceClass!
  static var itemDelegate: UKTableViewItemDelegate!
  static var tableViewDataSource: UKTableViewDataSourceClass!
  
  static var sut: UKTableViewDelegateClass!
  
  
  override class func setUp() {
    registrant = UKTableViewRegistrant(tableCellHandler: TableViewCellProtocolClass())
    sectionedDataSource = SectionedDataSourceClass()
    itemDelegate = TableViewItemDelegateClass()
    sut = UKTableViewDelegateClass(itemDelegateImplementation: itemDelegate,
                                     sectionHandlerImplementation: sectionedDataSource,
                                     registrant: registrant)
    
    tableViewDataSource = UKTableViewDataSourceClass(sectionHandlerImplementation: sectionedDataSource,
                                                     registrant: registrant)
  }
  
  func makeAndPrepareTableView() -> UKTableView {
    let tableView = UKTableView(frame: CGRect(x: 0, y: 0, width: 100.0, height: 100.0))
    tableView.delegate = UKTableViewDelegateClassTests.sut
    tableView.dataSource = UKTableViewDelegateClassTests.tableViewDataSource
    UKTableViewDelegateClassTests.sut.registrant?.registerReusableViews(with: tableView)
    tableView.reloadData()
    return tableView
  }
  
  #if os(iOS) || os(tvOS)
  func testDidSelectRow() {
    let tableView = makeAndPrepareTableView()
    
    let itemDelegate = UKTableViewDelegateClassTests.sut.itemDelegate as? TableViewItemDelegateClass
    XCTAssertNotNil(itemDelegate)
    
    let indexPath = IndexPath(item: 0, section: 0)
    
    tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    XCTAssertEqual(itemDelegate!.tapCounter, 1)
    
    tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    XCTAssertEqual(itemDelegate!.tapCounter, 2)
    
    tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    XCTAssertEqual(itemDelegate!.tapCounter, 3)
  }
  #endif
  
  #if os(OSX)
  func testViewForTableColumn() {
    let tableView = makeAndPrepareTableView()
    
    let tableColumn = tableView.tableColumns[0]
    let cell = tableView.delegate?.tableView?(tableView, viewFor: tableColumn, row: 0)
    XCTAssertNotNil(cell)
    
    let cellType = type(of: cell!)
    let cellClassString = String(describing: cellType)
    XCTAssertEqual(cellClassString, "NSTextField")
  }
  #endif
  
}
