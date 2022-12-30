//
//  DailyView.swift
//  MoodMeter
//
//  Created by Eliot Flores Portillo on 12/8/22.
//

import SwiftUI

struct DailyView: View {
    let dayData: DailyHealthData
    var body: some View {
        VStack(alignment: .leading) {
            Text("Date: " + dayData.date)
                .font(.headline)
            HStack {
                Label("\(dayData.avgHeartRate)", systemImage: "heart.fill")
                Spacer()
                Label("\(dayData.avgBloodOxy)", systemImage: "drop.fill")
                Spacer()
                Label("\(dayData.avgTemp)", systemImage: "medical.thermometer.fill")
                    .padding(.trailing, 20)
            }
        }
        .padding()
        .foregroundColor(dayData.theme.accentColor)
    }
}

struct DailyView_Previews: PreviewProvider {
    static var dayData = DailyHealthData.sampleData[0]
    static var previews: some View {
        DailyView(dayData: dayData)
            .background(dayData.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
