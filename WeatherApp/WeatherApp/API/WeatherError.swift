//
//  WeatherError.swift
//  WeatherApp
//
//  Created by Chethan Gowda on 8/28/24.
//

import Foundation

enum WeatherError: Error {
  case parsing(description: String)
  case network(description: String)
}
