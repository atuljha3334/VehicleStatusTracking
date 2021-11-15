//
//  BaseTableViewCell.swift
//  VehicleStatusTracking
//
//  Created by Atul Jha on 15/11/21.
//

import UIKit
import Foundation

class BaseTableViewCell<A>: UITableViewCell {
    var datasource: A!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
    }
}
