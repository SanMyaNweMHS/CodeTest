//
//  DetailView.swift
//  CodeTest
//
//  Created by SanMyaNwe on 7/5/21.
//

import UIKit

class DetailView: UIViewController, StoreSubscriber {
    
    @IBOutlet weak var lblCityAndTownship: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    static let id = "DetailView"
    
    var mCity: City? = nil
    var mTownship: Township? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        appStore.subscribe(self)
    }
    
    private func bindData() {
        let currentState = appStore.state as? TownshipState ?? TownshipState(townshipId: "", cityName: "", townshipName: "", description: "")
        lblCityAndTownship.text = currentState.townshipName+" ("+currentState.cityName+")"
        lblDescription.text = "     "+currentState.description
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    func newState(state: State) {
    }
}
