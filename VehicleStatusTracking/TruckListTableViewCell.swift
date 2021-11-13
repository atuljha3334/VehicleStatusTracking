//
//  TruckListTableViewCell.swift
//  VehicleStatusTracking
//
//  Created by Atul Jha on 13/11/21.
//

import UIKit

class TruckListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var latestUpdateLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var runningStatusLabel: UILabel!
    @IBOutlet weak var truckNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
