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
    
    func calculateTime() {
        let deviceTimeStamp = NSDate().timeIntervalSince1970
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return truckData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TruckListTableViewCell") as? TruckListTableViewCell
        cell?.truckNumberLabel.text = truckData[indexPath.row].truckNumber
        let truckRunningState = truckData[indexPath.row].lastRunningState?.truckRunningState
        if truckRunningState == 0 {
            cell?.runningStatusLabel.text = ""
            cell?.speedLabel.isHidden = true
        } else {
            cell?.runningStatusLabel.text = ""
            cell?.speedLabel.text = "\(truckData[indexPath.row].lastWaypoint?.speed ?? 0.00) k/h"
        }
        let lastWayPointUpdateTime = truckData[indexPath.row].lastWaypoint?.createTime
        cell?.latestUpdateLabel.text = " days"
        return cell ?? UITableViewCell()
    }
}
