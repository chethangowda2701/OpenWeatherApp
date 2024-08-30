//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Chethan Gowda on 8/28/24.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {
    
    let forecastJson = """
    {
    "dt": 1724943600,
    "main": {
      "temp": 22.75,
      "feels_like": 23.27,
      "temp_min": 22.75,
      "temp_max": 22.86,
      "pressure": 1022,
      "sea_level": 1022,
      "grnd_level": 1000,
      "humidity": 84,
      "temp_kf": -0.11
    },
    "weather": [
      {
        "id": 804,
        "main": "Clouds",
        "description": "overcast clouds",
        "icon": "04d"
      }
    ],
    "clouds": {
      "all": 100
    },
    "wind": {
      "speed": 2.8,
      "deg": 78,
      "gust": 3.47
    },
    "visibility": 10000,
    "pop": 0,
    "sys": {
      "pod": "d"
    },
    "dt_txt": "2024-08-29 15:00:00"
  }
"""
    
    var item: WeeklyForecastResponse.Item?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        do {
            item = try JSONDecoder().decode(WeeklyForecastResponse.Item.self, from: Data(forecastJson.utf8))
        } catch {
            print("Failed to decode JSON")
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWeatherForecastData() {
        guard let item = item else { return }
        let testViewModel = DailyWeatherRowViewModel(item: item)
        XCTAssertEqual(testViewModel.day, "30")
        XCTAssertEqual(testViewModel.month, "August")
        XCTAssertEqual(testViewModel.temperature, "22.8")
        XCTAssertEqual(testViewModel.title, "Clouds")
        XCTAssertEqual(testViewModel.fullDescription, "overcast clouds")
        XCTAssertEqual(testViewModel.id, "3022.8Clouds")
    }
    
    func testCurrentWeatherData() {
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
