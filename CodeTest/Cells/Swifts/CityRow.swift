//
//  CityRow.swift
//  CodeTest
//
//  Created by SanMyaNwe on 7/5/21.
//

import UIKit

protocol CityRowDelegate {
    func selectTownshipRow()
}

class CityRow: UITableViewCell, StoreSubscriber {
    
    static let id = "CityRow"

    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblTownshipCount: UILabel!
    @IBOutlet weak var townshipTableView: UITableView!
    
    var delegate: CityRowDelegate!
    
    var mCity: City?
    var mTownship: [Township] = [Township]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpTownshipTableView()
        appStore.subscribe(self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setUpTownshipTableView() {
        townshipTableView.dataSource = self
        townshipTableView.delegate = self
        townshipTableView.isScrollEnabled = false
        townshipTableView.rowHeight = 50
        
        townshipTableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        let nib = UINib(nibName: TownshipRow.id, bundle: nil)
        townshipTableView.register(nib, forCellReuseIdentifier: TownshipRow.id)
    }
    
    func bindCityData(city: City) {
        mCity = city
        lblCityName.text = city.cityName
        lblTownshipCount.text = "\(city.townships.count) townships"
        mTownship = city.townships
        DispatchQueue.main.async {
            self.townshipTableView.reloadData()
        }
    }
    
    func newState(state: State) {
    }
}

extension CityRow: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mTownship.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: TownshipRow.id, for: indexPath) as! TownshipRow
        row.selectionStyle = .none
        row.bindTownshipData(township: mTownship[indexPath.row])
        return row
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        appStore.dispatch(action: TownshipSelectAction(townshipId: self.mTownship[indexPath.row].townshipId ?? "", cityName: mCity?.cityName ?? "", townShipName: self.mTownship[indexPath.row].townshipName ?? "", description: self.mTownship[indexPath.row].description ?? ""))
        self.delegate.selectTownshipRow()
    }

}
