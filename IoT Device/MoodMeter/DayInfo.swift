//
//  DayInfo.swift
//  MoodMeter
//
//  Created by Eliot Flores Portillo on 12/8/22.
//

import Foundation


struct DailyHealthData{
    var date: String
    var avgHeartRate: Int
    var avgBloodOxy: Int
    var avgTemp: Int
    var theme: Theme
}

extension DailyHealthData {
    static let sampleData: [DailyHealthData] =
    [
        DailyHealthData(date: "12/10/22", avgHeartRate: 77, avgBloodOxy: 99, avgTemp: 95, theme: .seafoam),
        DailyHealthData(date: "12/09/22", avgHeartRate: 78, avgBloodOxy: 97, avgTemp: 97, theme: .poppy),
        DailyHealthData(date: "12/08/22", avgHeartRate: 72, avgBloodOxy: 99, avgTemp: 93, theme: .sky)
    ]
}


