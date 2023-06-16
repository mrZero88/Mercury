//
//  DataStructureTypeEnum.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import Foundation

public enum AppGroup: String {
  case facts = "group.mercury.flyzerosky.com"

  public var containerURL: URL {
    switch self {
    case .facts:
      return FileManager.default.containerURL(
      forSecurityApplicationGroupIdentifier: self.rawValue)!
    }
  }
}
