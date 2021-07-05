//
//  City.swift
//  CodeTest
//
//  Created by SanMyaNwe on 7/5/21.
//

import Foundation

struct City: Codable {
    var cityId: String?
    var cityName: String?
    var townships: [Township]
}
