//
//  DexcomAPI.swift
//  HeartChecker Watch App
//
//  Created by Max Fritzhand on 6/25/23
//

import Foundation

struct DexcomAPI {
    static let baseURL = "https://sandbox-api.dexcom.com/v3/users/self/egvs"
    static let apiKey = "APIKEY"
    
    static func getGlucoseData(completion: @escaping ([GlucoseData]?) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(nil)
            return
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            URLQueryItem(name: "startDate", value: "2020-03-06T09:12:35"),
            URLQueryItem(name: "endDate", value: "2020-03-07T09:12:35")
        ]
        
    
        guard let finalURL = urlComponents?.url else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Print the raw response for debugging
              if let data = data {
                  let str = String(decoding: data, as: UTF8.self)
                  print("Raw Response: \(str)")
              } else {
                  print("No data received")
                  completion(nil)
                  return
              }
        
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let glucoseResponse = try decoder.decode(GlucoseResponse.self, from: data!)
                
                let glucoseData = glucoseResponse.records
            
                if let firstDataPoint = glucoseData.first {
                    let glucoseValue = firstDataPoint.value
                    let timestamp = firstDataPoint.displayTime
                    let trend = firstDataPoint.trend
                    let trendRate = firstDataPoint.trendRate

                    print("Current Glucose: \(glucoseValue), Timestamp: \(timestamp), Trend: \(trend), TrendRate: \(trendRate)")
                
                } else {
                    completion(nil)
                }
                completion(glucoseData)
                
            } catch {
                
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
