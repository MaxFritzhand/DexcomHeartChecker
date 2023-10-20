//
//  heartManager.swift
//  HeartChecker Watch App
//
//  Created by Max Fritzhand on 6/26/23.
//

import HealthKit

class HealthKitManager: ObservableObject {
    private var healthStore: HKHealthStore?

    @Published var heartRate: Double = 0.0
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
            requestPermissions()
        }
    }
    
    private func requestPermissions() {
        let readTypes: Set = [HKObjectType.quantityType(forIdentifier: .heartRate)!]
        healthStore?.requestAuthorization(toShare: nil, read: readTypes) { (success, error) in
            if success {
                print("Permission granted.")
                self.fetchHeartRateData()
            } else {
                print("Permission denied.")
            }
        }
    }
    
    func fetchHeartRateData() {
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            if let error = error {
                print("Error fetching heart rate data: \(error.localizedDescription)")
                return
            }
            
            guard let results = results as? [HKQuantitySample] else { return }
            guard let latestSample = results.first else { return }
            
            let heartRateUnit = HKUnit(from: "count/min")
            let heartRate = latestSample.quantity.doubleValue(for: heartRateUnit)
            
            DispatchQueue.main.async {
                self.heartRate = heartRate
            }
        }
        healthStore?.execute(query)
    }
}
