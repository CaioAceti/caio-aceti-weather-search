//
//  LocationResponse.swift
//  WeatherTestApp
//
//  Created by Caio Aceti on 20/01/26.
//

struct LocationResponse: Decodable {
    let results: [Location]?
}

struct Location: Decodable {
    let name: String
    let latitude: Double
    let longitude: Double
}
