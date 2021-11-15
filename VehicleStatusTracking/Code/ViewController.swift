//
//  ViewController.swift
//  VehicleStatusTracking
//
//  Created by Atul Jha on 13/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables

    var responseData: ResponseData!
    var truckData = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupNavBar()
        truckRunningStatusServiceCall()
    }
    
    private func setupNavBar() {
        let maps    = UIImage(named: "google-maps")
        let searchImage  = UIImage(systemName: "magnifyingglass")
        let refresh = UIImage(named: "refresh")
        let mapButton = UIBarButtonItem(image: maps,  style: .plain, target: self, action: #selector(mapNavigation))
        let searchButton = UIBarButtonItem(image: searchImage,  style: .plain, target: self, action: nil)
        let refreshButton = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(refreshAction))
        navigationItem.rightBarButtonItems = [mapButton, searchButton, refreshButton]
        navigationController?.navigationBar.backgroundColor = .red
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func mapNavigation() {
        let vc = MapViewController()
        vc.truckListData = truckData
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func refreshAction() {
        truckRunningStatusServiceCall()
    }
    
    // MARK: - API Calling

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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return truckData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TruckListTableViewCell") as? TruckListTableViewCell
        cell?.speedLabel.isHidden = false
        cell?.latestUpdateLabel.isHidden = false
        cell?.datasource = truckData[indexPath.row]
        return cell ?? UITableViewCell()
    }
}
