//
//  UKTableViewRegistrantTests.swift
//  
//
//  Created by Mihaela Mihaljevic Jakic on 29.05.2021..
//

import XCTest
import UniteKit
@testable import UniteKitTableViewHandlers

final class UKTableViewRegistrantTests: XCTestCase {
  
  static var sut: UKTableViewRegistrant!
  
  override class func setUp() {
    sut = UKTableViewRegistrant(tableCellHandler: TableViewCellProtocolClass())
  }
  
  func testTableViewRegistrant() {
    let identifiers = UKTableViewRegistrantTests.sut.tableCellHandler.tableCellIdentifiers
    #if os(iOS) || os(tvOS)
    XCTAssertEqual(identifiers, ["CellID_iOS"])
    #endif
    #if os(OSX)
    XCTAssertEqual(identifiers, ["CellID1_macOS", "CellID2_macOS"])
    #endif
  }
  
  #if os(OSX)
  func testTableViewRegistrantIdentifierForColumn() {
    let column1 = UKTableViewRegistrantTests.sut.identifierFor(column: 0)
    XCTAssertEqual(column1, "CellID1_macOS")
    
    let column2 = UKTableViewRegistrantTests.sut.identifierFor(column: 1)
    XCTAssertEqual(column2, "CellID2_macOS")
  }
  #endif
}
