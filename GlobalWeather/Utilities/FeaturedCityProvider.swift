//
//  FeaturedCityProvider.swift
//  GlobalWeather
//
//  Created by Kanat on 19.08.2023.
//

import Foundation

@propertyWrapper
struct FeaturedCityProvider {
    private let cities = [
        "Tokyo", "Delhi", "Kazan", "Cairo", "London", "Berlin", "Rome", "Paris", "Madrid",
        "Athens", "Amsterdam", "Oslo", "Stockholm", "Vienna", "Prague", "Almaty", "Warsaw",
        "Brussels", "Dublin", "Lisbon", "Helsinki", "Ankara", "Copenhagen", "Colombo",
        "Brasília", "Sri Jayawardenepura Kotte", "Mexico City", "Riga", "Vilnius", "Tallinn",
        "Nha Trang", "Istanbul", "Pattaya", "Dhaka", "Malé", "Kathmandu", "Hanoi", "Kiev",
        "Chisinau", "Bangkok", "Islamabad", "Phnom Penh", "Baku", "Ashgabat", "Astana",
        "Phuket", "Kuala Lumpur"
    ]
    
    var wrappedValue: String {
        return cities.randomElement() ?? "Bangkok"
    }
}
