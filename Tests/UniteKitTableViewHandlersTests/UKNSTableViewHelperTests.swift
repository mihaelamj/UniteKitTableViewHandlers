//
//  UKNSTableViewHelperTests.swift
//  
//
//  Created by Mihaela Mihaljevic Jakic on 29.05.2021..
//

#if os(OSX)
import Foundation
import Cocoa
import XCTest
import UniteKit
@testable import UniteKitTableViewHandlers

final class UKNSTableViewHelperTests: XCTestCase {
  
  static var sut: UKNSTableViewHelper!
  
  override class func setUp() {
    sut = UKNSTableViewHelper()
  }
  
  func testMakeTextField() {
    let side: CGFloat = 100.0
    let tableView = NSTableView(frame: CGRect(x: 0, y: 0, width: side, height: side))
    XCTAssertNotNil(tableView)
    let textField = UKNSTableViewHelperTests.sut.makeTextField(tableView)
    XCTAssertNotNil(textField)
    XCTAssertEqual(textField.bounds.size.width, side)
    XCTAssertEqual(textField.bounds.size.height, 0.0)
  }
  
  func testFetchIndexOfColumnIn() {
    let side: CGFloat = 100.0
    let tableView = NSTableView(frame: CGRect(x: 0, y: 0, width: side, height: side))
    XCTAssertNotNil(tableView)
    
    let registrant = UKTableViewRegistrant(tableCellHandler: TableViewCellProtocolClass())
    registrant.registerReusableViews(with: tableView)
    
    // ["CellID1_macOS", "CellID2_macOS"]
    let ident = NSUserInterfaceItemIdentifier(rawValue: "CellID1_macOS")
    let tableColumnIndex = tableView.column(withIdentifier: ident)
    XCTAssertEqual(tableColumnIndex, 0)
    
    let tableColumn = tableView.tableColumns[tableColumnIndex]
    XCTAssertNotNil(tableColumn)
    
    let indexOfColumn = UKNSTableViewHelperTests.sut.fetchIndexOfColumnIn(tableView, tableColumn: tableColumn)
    XCTAssertEqual(indexOfColumn, 0)
  }
  
}

#endif
