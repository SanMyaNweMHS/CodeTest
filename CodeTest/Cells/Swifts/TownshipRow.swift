//
//  TownshipRow.swift
//  CodeTest
//
//  Created by SanMyaNwe on 7/5/21.
//

import UIKit

class TownshipRow: UITableViewCell {
    
    static let id = "TownshipRow"

    @IBOutlet weak var lblTownshipName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindTownshipData(township: Township) {
        lblTownshipName.text = township.townshipName
    }
    
}
