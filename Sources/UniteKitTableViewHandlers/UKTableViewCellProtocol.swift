//
//  UKTableViewCellProtocol.swift
//  UniteKitTableViewHandlers
//
//  Created by Mihaela Mihaljevic Jakic on 29.05.2021..
//


import UniteKit

#if os(iOS) || os(tvOS)
import UIKit
#endif

#if os(OSX)
import Cocoa
#endif

// MARK: -
// MARK: DataSource Protocol -

@objc public protocol UKTableViewCellProtocol: AnyObject {
  func tableCellIdentifierFor(indexPath: IndexPath) -> String?
  func tableCellClassFor(identifier: String) -> CellClassType?
  
  var tableCellIdentifiers:  [String] { get }
  var tableCellClassTypes: [CellClassType] { get }
}
