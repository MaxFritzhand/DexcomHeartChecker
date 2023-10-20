//
//  GlucoseData.swift
//  HeartChecker Watch App
//
//  Created by Max Fritzhand on 6/26/23.
//

import Foundation

struct GlucoseData: Codable, Identifiable {
    let id: String
    let systemTime: String
    let displayTime: String
    let transmitterId: String
    let transmitterTicks: Int
    let value: Int
    let trend: String
    let trendRate: Double
    let unit: String
    let rateUnit: String
    let displayDevice: String
    let transmitterGeneration: String

    private enum CodingKeys: String, CodingKey {
        case id = "recordId"
        case systemTime, displayTime, transmitterId, transmitterTicks, value, trend, trendRate, unit, rateUnit, displayDevice, transmitterGeneration
    }
}

struct GlucoseResponse: Codable {
    let records: [GlucoseData]
}
