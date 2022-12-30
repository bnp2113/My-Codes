//
//  MoodMeterApp.swift
//  MoodMeter
//
//  Created by Eliot Flores Portillo on 11/23/22.
//

import SwiftUI

@main
struct MoodMeterApp: App {
    @StateObject var launchScreenStates = LaunchScreenStateMachine()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack {
                    //DailyListView(dailyDataCards: DailyHealthData.sampleData, liveData: LiveDataFromJSON.sampleData)
                    //ContentView(dailyDataCards: DailyHealthData.sampleData)
                    testView()
                    if launchScreenStates.state != .finalState {
                        LaunchScreenView()
                    }
                }
                .environmentObject(launchScreenStates)
            }
        }
    }
}
