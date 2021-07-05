//
//  Action.swift
//  CodeTest
//
//  Created by SanMyaNwe on 7/5/21.
//

import Foundation

protocol Action {}

struct TownshipSelectAction: Action {
    let townshipId: String
    let cityName: String
    let townShipName: String
    let description: String
}
