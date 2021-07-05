//
//  State.swift
//  CodeTest
//
//  Created by SanMyaNwe on 7/5/21.
//

import Foundation

protocol State {}

struct TownshipState: State {
    var townshipId: String
    var cityName: String
    var townshipName: String
    var description: String
}
