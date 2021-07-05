//
//  Reducer.swift
//  CodeTest
//
//  Created by SanMyaNwe on 7/5/21.
//

import Foundation

typealias Reducer = (_ action: Action, _ state: State?) -> State

func townshipReducer(_ action: Action, _ state: State?) -> State {
    var newState = state as? TownshipState ?? TownshipState(townshipId: "", cityName: "", townshipName: "", description: "")
    
    switch action{
        case let action as TownshipSelectAction:
            newState.townshipId = action.townshipId
            newState.cityName = action.cityName
            newState.townshipName = action.townShipName
            newState.description = action.description
        default:
            break
    }
    
    return newState
    
}
