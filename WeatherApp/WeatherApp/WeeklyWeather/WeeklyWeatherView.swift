//
//  WeeklyWeatherView.swift
//  WeatherApp
//
//  Created by Chethan Gowda on 8/28/24.
//

import SwiftUI
import UIKit

struct WeeklyWeatherView: View {
  @ObservedObject var viewModel: WeeklyWeatherViewModel
  
  init(viewModel: WeeklyWeatherViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
      NavigationView {
        List {
          searchField
          
          if viewModel.dataSource.isEmpty {
            emptySection
          } else {
            cityHourlyWeatherSection
            forecastSection
          }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Weather ⛅️")
      }
  }
}

private extension WeeklyWeatherView {
  var searchField: some View {
    HStack(alignment: .center) {
      //TextField("e.g. Dallas", text: $viewModel.city)
        //Populates the last city entered before app close
        TextField(viewModel.city == "" ? "Enter City" : viewModel.city, text: $viewModel.city)
    }
  }
  
  var forecastSection: some View {
    Section {
      ForEach(viewModel.dataSource, content: DailyWeatherRow.init(viewModel:))
    }
  }
  
  var cityHourlyWeatherSection: some View {
    Section {
      NavigationLink(destination: viewModel.currentWeatherView) {
        VStack(alignment: .leading) {
          Text(viewModel.city)
          Text("Weather today")
            .font(.caption)
            .foregroundColor(.gray)
        }
      }
    }
  }
  
  var emptySection: some View {
    Section {
      Text("No results")
        .foregroundColor(.gray)
    }
  }
  
}

