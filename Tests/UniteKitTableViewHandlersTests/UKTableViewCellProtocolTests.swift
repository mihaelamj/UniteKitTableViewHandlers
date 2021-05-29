//
//  UKTableViewCellProtocolTests.swift
//  
//
//  Created by Mihaela Mihaljevic Jakic on 29.05.2021..
//

import XCTest
import UniteKit
@testable import UniteKitTableViewHandlers

final class UKTableViewCellProtocolTests: XCTestCase {
  
  static var sut: TableViewCellProtocolClass!
  
  override class func setUp() {
    sut = TableViewCellProtocolClass()
  }
  
  func testCellIdentifierForIndexPath() {
    let indexPath = IndexPath(item: 0, section: 0)
    let identifier = UKTableViewCellProtocolTests.sut.tableCellIdentifierFor(indexPath: indexPath)
    
    #if os(iOS) || os(tvOS)
    XCTAssertEqual(identifier, "CellID_iOS")
    #endif
    #if os(OSX)
    XCTAssertEqual(identifier, "CellID1_macOS")
    #endif
  }
  
  func testTableCellClassForIdentifier() {
    let identifier = UKTableViewCellProtocolTests.sut.cellidentifiers.first
    XCTAssertNotNil(identifier)
    
    let cellClass = UKTableViewCellProtocolTests.sut.tableCellClassFor(identifier: identifier!)
    XCTAssertNotNil(cellClass)
    
    let cellClassString = String(describing: cellClass!)
    
    #if os(iOS) || os(tvOS)
    XCTAssertEqual(cellClassString, "UITableViewCell")
    #endif
    #if os(OSX)
    XCTAssertEqual(cellClassString, "UKView")
    #endif
  }
  
  func testTableCellIdentifiers() {
    #if os(iOS) || os(tvOS)
    XCTAssertEqual(UKTableViewCellProtocolTests.sut.cellidentifiers, ["CellID_iOS"])
    #endif
    #if os(OSX)
    XCTAssertEqual(UKTableViewCellProtocolTests.sut.cellidentifiers, ["CellID1_macOS", "CellID2_macOS"])
    #endif
  }
  
}
