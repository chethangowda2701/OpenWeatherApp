//
//  CurrentWeatherRow.swift
//  WeatherApp
//
//  Created by Chethan Gowda on 8/28/24.
//

import SwiftUI

struct CurrentWeatherRow: View {
  private let viewModel: CurrentWeatherRowViewModel
  
  init(viewModel: CurrentWeatherRowViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
      VStack(alignment: .leading) {
        HStack {
          Text("Temperature:")
          Text("\(viewModel.temperature)°")
            .foregroundColor(.gray)
        }
        
        HStack {
          Text("Max temperature:")
          Text("\(viewModel.maxTemperature)°")
            .foregroundColor(.gray)
        }
        
        HStack {
          Text("Min temperature:")
          Text("\(viewModel.minTemperature)°")
            .foregroundColor(.gray)
        }
        
        HStack {
          Text("Humidity:")
          Text(viewModel.humidity)
            .foregroundColor(.gray)
        }
      }
  }
}
