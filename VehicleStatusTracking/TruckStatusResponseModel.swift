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
    let companyId: Int?
    let truckTypeId: Int?
    let truckSizeId: Int?
    let truckNumber: String?
    let transporterId: Int?
    let trackerType: Int?
    let imeiNumber: String?
    let simNumber: String?
    let name: String?
    let password: String?
    let createTime: Int?
    let deactivated: Bool?
    let breakdown: Bool?
    let lastWaypoint: LastWaypoint?
    let lastRunningState: LastRunningState?
    let durationInsideSite: Int?
    let fuelSensorInstalled: Bool?
    let externalTruck: Bool?
}

struct LastWaypoint: Codable {
    let id: Int?
    let lat: Double?
    let lng: Double?
    let createTime: Int?
    let accuracy: Double?
    let bearing: Double?
    let truckId: Int?
    let speed: Double?
    let updateTime: Int?
    let ignitionOn: Bool?
    let odometerReading: Double?
    let batteryPower: Bool?
    let fuelLevel: Int?
    let batteryLevel: Int?
}

struct LastRunningState: Codable {
    let truckId: Int?
    let stopStartTime: Int?
    let truckRunningState: Int?
    let lat: Double?
    let lng: Double?
    let stopNotficationSent: Int?
}
