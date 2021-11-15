//
//  TruckStatusResponseModel.swift
//  VehicleStatusTracking
//
//  Created by Atul Jha on 13/11/21.
//

import Foundation

struct ResponseData: Codable {
    let responseCode: ResponseCode?
    let data: [Data]?
}

struct ResponseCode: Codable {
    let responseCode: Int?
    let message: String?
}

struct Data: Codable {
    let id: Int?
    let truckNumber: String?
    let lastWaypoint: LastWaypoint?
    let lastRunningState: LastRunningState?
}

struct LastWaypoint: Codable {
    let lat: Double?
    let lng: Double?
    let createTime: Int?
    let speed: Double?
    let ignitionOn: Bool?
}

struct LastRunningState: Codable {
    let stopStartTime: Int?
    let truckRunningState: Int?
}


