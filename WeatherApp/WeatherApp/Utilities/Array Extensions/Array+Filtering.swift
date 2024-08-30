//
//  Array+Filtering.swift
//  WeatherApp
//
//  Created by Chethan Gowda on 8/28/24.
//

import Foundation

public extension Array where Element: Hashable {
  static func removeDuplicates(_ elements: [Element]) -> [Element] {
    var seen = Set<Element>()
    return elements.filter{ seen.insert($0).inserted }
  }
}
