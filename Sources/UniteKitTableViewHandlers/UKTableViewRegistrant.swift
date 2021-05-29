//
//  UKTableViewRegistrant.swift
//  
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
// MARK: UKTableViewRegistrant -

public class UKTableViewRegistrant {
  
  // MARK: Properties -
  
  var tableCellHandler: UKTableViewCellProtocol
  
  // MARK: Init -
  
  public init(tableCellHandler: UKTableViewCellProtocol) {
    self.tableCellHandler = tableCellHandler
  }
}

// MARK: -
// MARK: UKTableViewRegistrant Helper Methods -

public extension UKTableViewRegistrant {
  func registerReusableViews(with tableView: UKTableView) {
    #if os(iOS) || os(tvOS)
    tableCellHandler.tableCellIdentifiers.forEach { cellIdent in
      let cellClass = tableCellHandler.tableCellClassFor(identifier: cellIdent)
      tableView.register(cellClass, forCellReuseIdentifier: cellIdent)
    }
    #endif
    
    #if os(OSX)
    tableCellHandler.tableCellIdentifiers.forEach { cellIdent in
      let ident = NSUserInterfaceItemIdentifier(rawValue: cellIdent)
      tableView.addTableColumn(NSTableColumn(identifier: ident))
    }
    #endif
  }
  
  #if os(OSX)
  func identifierFor(column: Int) -> String? {
    let indexPath = IndexPath(item: 0, section: column)
    return tableCellHandler.tableCellIdentifierFor(indexPath: indexPath)
  }
  #endif
}
