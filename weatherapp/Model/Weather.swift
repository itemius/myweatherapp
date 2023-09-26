//
//  Weather.swift
//  weatherapp
//
//  Created by itemius on 25.09.2023.
//

import Foundation

struct Weather {
    let icon: String
    let main: String
    let temperature: Double
    let description: String
    let city: String
}

struct WeatherBase: Decodable {
    let icon: String
    let main: String
    let description: String
}

extension Weather: Decodable {
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case name

        enum MainKeys: String, CodingKey {
            case temperature = "temp"
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let weather = try container.decode([WeatherBase].self, forKey: .weather).first!

        main = weather.main
        icon = weather.icon
        description = weather.description

        let mainContainer = try container.nestedContainer(keyedBy: CodingKeys.MainKeys.self, forKey: .main)
        temperature = try mainContainer.decode(Double.self, forKey: .temperature)

        city = try container.decode(String.self, forKey: .name)
    }
}
