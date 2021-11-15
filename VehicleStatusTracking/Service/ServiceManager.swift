//
//  ServiceManager.swift
//  VehicleStatusTracking
//
//  Created by Atul Jha on 13/11/21.
//

import Foundation

class ServiceManager {
    
    public static let shared = ServiceManager()
    
    func getTruckStatusService(completion: @escaping (ResponseData) -> Void) {
        guard let url =  URL(string: "https://api.mystral.in/tt/mobile/logistics/searchTrucks?auth-company=PCH&companyId=33&deactivated=false&key=g2qb5jvucg7j8skpu5q7ria0mu&q-expand=true&q-include=lastRunningState,lastWaypoint") else {
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let task  = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let data = try JSONDecoder().decode(ResponseData.self, from: data)
                    completion(data)
                } catch {
                    let error = error
                    print(error.localizedDescription)
                }
            } else { return }
        }
        task.resume()
    }
}
