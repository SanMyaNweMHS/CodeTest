//
//  HomeView.swift
//  CodeTest
//
//  Created by SanMyaNwe on 7/5/21.
//

import UIKit

class HomeView: UIViewController, StoreSubscriber {
    
    @IBOutlet weak var cityTableView: UITableView!
    
    private var mCity: [City] = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCityTableView()
        bindData()
        appStore.subscribe(self)
    }
    
    private func setUpCityTableView() {
        cityTableView.dataSource = self
        cityTableView.delegate = self
        cityTableView.allowsSelection = false
        cityTableView.separatorStyle = .none
        cityTableView.showsVerticalScrollIndicator = false
        
        let nib = UINib(nibName: CityRow.id, bundle: nil)
        self.cityTableView.register(nib, forCellReuseIdentifier: CityRow.id)
    }
    
    private func bindData() {
        ApiService.shared.fetchData(url: Api.BASE_URL + "/getCities", value: CityListResponse.self) { (completion) in
            switch completion {
                case .success(let cityResponse):
                    self.mCity = cityResponse.results
                    DispatchQueue.main.async {
                        self.cityTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    func newState(state: State) {
        
    }
}

extension HomeView: UITableViewDataSource, UITableViewDelegate, CityRowDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat((mCity[indexPath.row].townships.count * 50) + 50)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: CityRow.id, for: indexPath) as! CityRow
        row.delegate = self
        row.bindCityData(city: mCity[indexPath.row])
        return row
    }
    
    func selectTownshipRow() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: DetailView.id) as! DetailView
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
