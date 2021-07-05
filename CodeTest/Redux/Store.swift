//
//  Store.swift
//  CodeTest
//
//  Created by SanMyaNwe on 7/5/21.
//

import Foundation

let appStore = Store(reducer: townshipReducer, state: nil)

protocol StoreSubscriber {
    func newState(state: State)
}

class Store {
    let reducer: Reducer
    var state: State?
    var subscribers: [StoreSubscriber] = []
    
    init(reducer: @escaping Reducer, state: State?) {
        self.reducer = reducer
        self.state = state
    }
    
    func dispatch(action: Action) {
        state = reducer(action, state)
        subscribers.forEach { $0.newState(state: state!) }
    }
    
    func subscribe(_ newSubscriber: StoreSubscriber) {
        subscribers.append(newSubscriber)
    }
}
