//
//  UKTableViewDataSourceClass.swift
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
// MARK: TableViewDataSource -

public class UKTableViewDataSourceClass: UKTableViewHandlerClass {
  public weak var sectionHandler: SectionedDataSource?
  public weak var registrant: UKTableViewRegistrant?
  
  public init(sectionHandlerImplementation: SectionedDataSource? = nil,
              registrant: UKTableViewRegistrant? = nil) {
    sectionHandler = sectionHandlerImplementation
    self.registrant = registrant
  }
}

// MARK: -
// MARK: ATableViewDataSource -

extension UKTableViewDataSourceClass: UKTableViewDataSource {
  
  #if os(iOS) || os(tvOS)
  public func numberOfSections(in tableView: UITableView) -> Int {
    return sectionHandler?.numberOfSections() ?? 0
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sectionHandler?.numberOfItemsInSection(section) ?? 0
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let sectionHandler = sectionHandler else { preconditionFailure("Error, no item handler") }
    
    guard let cellIdentifier = registrant?.tableCellHandler.tableCellIdentifierFor(indexPath: indexPath) else {
      preconditionFailure("Error, no Cell identifier for item in section: \(indexPath.section), row: \(indexPath.row)!")
    }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    cell.selectionStyle = .none
    
    cell.textLabel?.text = sectionHandler.itemTitleAt(indexPath)
    
    // styling
    cell.textLabel?.font = .systemFont(ofSize: 16)
    cell.textLabel?.textColor = defaultTextColor // #424242
    cell.accessoryType = sectionHandler.itemIsCheckedAt(indexPath) ? .checkmark : .none
    
    return cell
  }
  #endif
  
  #if os(OSX)
  public func numberOfRows(in tableView: NSTableView) -> Int {
    return sectionHandler?.numberOfItemsInSection(0) ?? 0
  }
  #endif
  
}

