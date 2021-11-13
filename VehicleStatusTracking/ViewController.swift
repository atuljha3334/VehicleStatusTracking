//
//  ViewController.swift
//  VehicleStatusTracking
//
//  Created by Atul Jha on 13/11/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var responseData: ResponseData!
    var truckData = [Data]()
    let deviceTimeStamp = Int(NSDate().timeIntervalSince1970 * 1000)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        truckRunningStatusServiceCall()
//        cellRegister()
    }
    
    private func truckRunningStatusServiceCall() {
        ServiceManager.shared.getTruckStatusService { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.responseData = result
            strongSelf.truckData = result.data ?? []
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    func cellRegister() {
        tableView.register(UINib(nibName: "TruckListTableViewCell", bundle: nil), forCellReuseIdentifier: "TruckListTableViewCell")
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return truckData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TruckListTableViewCell") as? TruckListTableViewCell
        cell?.truckNumberLabel.text = truckData[indexPath.row].truckNumber
        let stopStartTime = truckData[indexPath.row].lastRunningState?.stopStartTime ?? 0
        let lastRunningTimeDifference = deviceTimeStamp - stopStartTime
        let epochDiff1 = lastRunningTimeDifference
        var diff = ""
        if epochDiff1 / 86400000 >= 1 {
            diff = "\(epochDiff1 / 86400000) days"
        } else if epochDiff1 / 3600000 >= 1 {
            diff = "\(epochDiff1 / 3600000) hours"
        } else if epochDiff1 / 60000 >= 1 {
            diff = "\(epochDiff1 / 3600000) mins"
        }
        let truckRunningState = truckData[indexPath.row].lastRunningState?.truckRunningState
        if truckRunningState == 0 {
            cell?.runningStatusLabel.text = "Stopped since last \(diff)"
            cell?.speedLabel.isHidden = true
        } else {
            cell?.runningStatusLabel.text = "Running since last \(diff)"
            cell?.speedLabel.text = "\(truckData[indexPath.row].lastWaypoint?.speed ?? 0.00) k/h"
        }
        let updatedTime = truckData[indexPath.row].lastWaypoint?.createTime ?? 0
        let updateTimeDifference = deviceTimeStamp - updatedTime
        let epochDiff2 = updateTimeDifference
        var updateDiff = ""
        if epochDiff2 / 86400000 >= 1 {
            updateDiff = "\(epochDiff2 / 86400000) days"
        } else if epochDiff2 / 3600000 >= 1 {
            updateDiff = "\(epochDiff2 / 3600000) hours"
        } else if epochDiff2 / 60000 >= 1 {
            updateDiff = "\(epochDiff2 / 3600000) mins"
        }
        let lastWayPointUpdateTime = truckData[indexPath.row].lastWaypoint?.createTime
        cell?.latestUpdateLabel.text = "\(updateDiff)"
        return cell ?? UITableViewCell()
    }
}
