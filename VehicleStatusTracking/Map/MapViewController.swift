//
//  MapViewController.swift
//  VehicleStatusTracking
//
//  Created by Atul Jha on 14/11/21.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var mapView: UIView!
    
    // MARK: - Variables

    var truckListData = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyCp2xyvF8a0o8ex88X0-HoFpKwXMkQgmmE")
        setupMarkerOnMap()
        setupNavBar()
    }
    
    func setupNavBar() {
        let listButtton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listOfTrucks))
        let refreshButton = UIBarButtonItem(image: UIImage(named: "refresh"),  style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems = [listButtton, refreshButton]
    }
    
    @objc func listOfTrucks() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - SETUP MAP

    func setupMarkerOnMap() {
        let camera = GMSCameraPosition.camera(withLatitude: truckListData[0].lastWaypoint?.lat ?? 30.838, longitude: truckListData[0].lastWaypoint?.lng ?? 75.972, zoom: 10.0)
        let mapSubView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.addSubview(mapSubView)
        for i in truckListData {
            let lat = i.lastWaypoint?.lat ?? 0.0
            let lon = i.lastWaypoint?.lng ?? 0.0
            print(lat, lon)
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            if i.lastWaypoint?.ignitionOn == false {
                marker.icon = UIImage(named: "truckRed")
            } else {
                if i.lastRunningState?.truckRunningState == 1 {
                    marker.icon = UIImage(named: "truckGreen")
                } else {
                    marker.icon = UIImage(named: "truckBlue")
                }
            }
            marker.map = mapSubView
        }
    }
}
