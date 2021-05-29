//
//  UKTableViewItemDelegateTests.swift
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

final class UKTableViewItemDelegateTests: XCTestCase {
  
  func testDidTapOnCounter() {
    let itemDelegate = TableViewItemDelegateClass()
    XCTAssertEqual(itemDelegate.tapCounter, 0)
    
    itemDelegate.didTapOn(dataSource: "Data Source", item: "Item")
    XCTAssertEqual(itemDelegate.tapCounter, 1)
    
    itemDelegate.didTapOn(dataSource: "Data Source", item: "Item")
    XCTAssertEqual(itemDelegate.tapCounter, 2)
  }
}
