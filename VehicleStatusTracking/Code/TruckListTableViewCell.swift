//
//  TruckListTableViewCell.swift
//  VehicleStatusTracking
//
//  Created by Atul Jha on 13/11/21.
//

import UIKit

class TruckListTableViewCell: BaseTableViewCell<Data> {
    
    // MARK: - Outlets

    @IBOutlet weak var latestUpdateLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var runningStatusLabel: UILabel!
    @IBOutlet weak var truckNumberLabel: UILabel!
    
    // MARK: - Variables

    let deviceTimeStamp = Int(NSDate().timeIntervalSince1970 * 1000)
    
    override var datasource: Data! {
        didSet {
            setupCell()
        }
    }
    
    func setupCell() {
        truckNumberLabel.text = datasource?.truckNumber
        let stopStartTime = datasource?.lastRunningState?.stopStartTime ?? 0
        let ignition = datasource.lastWaypoint?.ignitionOn
        if ignition == false {
            runningStatusLabel.text = "Stopped since last \(lastRunningTime(time: stopStartTime))"
            speedLabel.isHidden = true
        } else {
            if datasource.lastRunningState?.truckRunningState == 1 {
                runningStatusLabel.text = "Running since last \(lastRunningTime(time: stopStartTime))"
            } else {
                runningStatusLabel.text = "Stopped since last \(lastRunningTime(time: stopStartTime))"
            }
            speedLabel.text = "\(datasource?.lastWaypoint?.speed ?? 0.00) k/h"
        }
        let updatedTime = datasource?.lastWaypoint?.createTime ?? 0
        latestUpdateLabel.text = "\(lastUpdatedTime(time: updatedTime))"
    }
    
    // MARK: - Running time

    func lastRunningTime(time: Int) -> String {
        let lastRunningTimeDifference = deviceTimeStamp - time
        let epochDiff1 = lastRunningTimeDifference
        var diff = ""
        if epochDiff1 / 86400000 >= 1 {
            diff = "\(epochDiff1 / 86400000) days"
        } else if epochDiff1 / 3600000 >= 1 {
            diff = "\(epochDiff1 / 3600000) hours"
        } else if epochDiff1 / 60000 >= 1 {
            diff = "\(epochDiff1 / 60000) mins"
        } else {
            diff = "\(epochDiff1 / 1000) secs"
        }
        return diff
    }
    
    // MARK: - Last updated time

    func lastUpdatedTime(time: Int) -> String {
        let updateTimeDifference = deviceTimeStamp - time
        let epochDiff2 = updateTimeDifference
        var updateDiff = ""
        if epochDiff2 / 86400000 >= 1 {
            updateDiff = "\(epochDiff2 / 86400000) days ago"
        } else if epochDiff2 / 3600000 >= 1 {
            updateDiff = "\(epochDiff2 / 3600000) hours ago"
        } else if epochDiff2 / 60000 >= 1 {
            updateDiff = "\(epochDiff2 / 60000) mins ago"
        } else {
            updateDiff = "\(epochDiff2 / 1000) secs ago"
        }
        return updateDiff
    }
}
