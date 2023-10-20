//
//  ContentView.swift
//  HeartChecker Watch App
//
//  Created by Max Fritzhand on 6/25/23.
//

import SwiftUI


struct ContentView: View {
    @State private var glucoseData: [GlucoseData] = []
    @State private var forceRefresh: Bool = false
    @State private var currentIndex: Int = 0
    
    @ObservedObject var healthKitManager = HealthKitManager()
    
    var body: some View {
            TabView {
                VStack {
                    if glucoseData.indices.contains(currentIndex) {
                        Text("Glucose Value: \(glucoseData[currentIndex].value) mg/dL")
                            .padding()
                    } else {
                        Text("No glucose data available")
                            .padding()
                    }

                    Button("Latest Reading") {
                        fetchGlucoseData()
                    }
                }
                .tabItem { Text("Glucose") }
                
                VStack {
                    Text("Heart Rate")
                    Text("\(String(format: "%.2f", healthKitManager.heartRate))")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .onAppear(perform: healthKitManager.fetchHeartRateData)
                .onReceive(Timer.publish(every: 5, on: .main, in: .common).autoconnect()) { _ in
                            self.healthKitManager.fetchHeartRateData()
                }
                .tabItem { Text("Heart Rate") }
            }
            .id(forceRefresh)  
            .tabViewStyle(PageTabViewStyle())
        }

        func fetchGlucoseData() {
            if !glucoseData.isEmpty {
                currentIndex = (currentIndex + 1) % glucoseData.count
                forceRefresh.toggle()
            } else {
                DexcomAPI.getGlucoseData { data in
                    DispatchQueue.main.async {
                        guard let fetchedData = data else {  return }
                        glucoseData = fetchedData
                        forceRefresh.toggle()
                    }
                }
            }
        }
    }






struct GlucoseRow: View {
    var egv: GlucoseData

    var body: some View {
        VStack(alignment: .leading) {
            Text("Glucose Value: \(egv.value)")
            Text("Timestamp: \(egv.displayTime)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
