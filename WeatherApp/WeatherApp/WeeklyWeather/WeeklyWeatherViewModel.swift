//
//  WeeklyWeatherViewModel.swift
//  WeatherApp
//
//  Created by Chethan Gowda on 8/28/24.
//

import SwiftUI
import Combine

class WeeklyWeatherViewModel: ObservableObject {
  @Published var city: String = ""
  @Published var dataSource: [DailyWeatherRowViewModel] = []
  @AppStorage("city") var storedCity: String = ""
  
  private let weatherFetcher: WeatherFetchable
  private var disposables = Set<AnyCancellable>()

  init(
    weatherFetcher: WeatherFetchable,
    scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
  ) {
    self.weatherFetcher = weatherFetcher
    self.city = storedCity
    $city
      //.dropFirst(1)
      .debounce(for: .seconds(0.5), scheduler: scheduler)
      .sink(receiveValue: fetchWeather(forCity:))
      .store(in: &disposables)
      
      
      $city
          .dropFirst()
          .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
          .sink(receiveValue: fetchWeather(forCity:))
          .store(in: &disposables)
  }

  func fetchWeather(forCity city: String) {
    weatherFetcher.weeklyWeatherForecast(forCity: city)
      .map { response in
        response.list.map(DailyWeatherRowViewModel.init)
      }
      .map(Array.removeDuplicates)
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] value in
          guard let self = self else { return }
          switch value {
          case .failure:
            self.dataSource = []
              
          case .finished:
              storedCity = city
            break
          }
        },
        receiveValue: { [weak self] forecast in
          guard let self = self else { return }
          self.dataSource = forecast
      })
      .store(in: &disposables)
  }
}

extension WeeklyWeatherViewModel {
  var currentWeatherView: some View {
      let viewModel = CurrentWeatherViewModel(
        city: city,
        weatherFetcher: weatherFetcher)
      return CurrentWeatherView(viewModel: viewModel)
  }
}
