//
//  LiveDataView.swift
//  MoodMeter
//
//  Created by Eliot Flores Portillo on 12/8/22.
//

import SwiftUI
import Charts

//struct rawData: Codable {
//    let gsr: String
//    let hr: String
//    let oxi: String
//    let time: String
//    let tp: String
//}

struct LiveDataView: View {
    let liveData : [LiveDataFromJSON]
    @EnvironmentObject var launchScreenStates: LaunchScreenStateMachine
    
    var body: some View {
        ZStack {
            VStack {
                Chart {
                    ForEach (liveData, id: \.TIME) {
                        LineMark(
                            x: .value("Time", $0.TIME),
                            y: .value("HR", $0.HR)
                        )
                    }
                }
                //Text(jsonData)
                
                //                    Chart {
                //                        ForEach (liveData, id: \.TIME) {
                //                            LineMark(
                //                                x: .value("Time", $0.TIME),
                //                                y: .value("OXI", $0.OXI)
                //                            )
                //                        }
                //                    }
                //                    Chart {
                //                        //ForEach (liveData, id: \.TIME) {
                //                        LineMark(
                //                            x: .value("Time", inData[1].time),
                //                            y: .value("TP", inData[1].tp)
                //                        )
                //                        //}
                //                    }
                //                    Chart {
                //                        //ForEach (liveData, id: \.TIME) {
                //                        LineMark(
                //                            x: .value("Time", inData[1].time),
                //                            y: .value("SW", inData[1].gsr)
                //                        )
                //                        // }
                //                    }
                //                .onAppear {
                //
                //                    if (MyVariables.launchState == true) {
                //                                DispatchQueue
                //                                    .main
                //                                    .asyncAfter(deadline: .now() + 3) {
                //                                        launchScreenStates.dismiss()
                //                                        MyVariables.launchState = false
                //                        }
                //                    }
                //                    print("yes")
                //                    DispatchQueue.global().async {
                //
                //                        DataRequest().getData()
                //                    }
                //                }
                //                    LiveDataRequest().getPost {  (bigData) in
                //                        self.bigData = bigData
            }
            .onAppear {
                if (MyVariables.launchState == true) {
                    DispatchQueue
                        .main
                        .asyncAfter(deadline: .now() + 3) {
                            launchScreenStates.dismiss()
                            MyVariables.launchState = false
                        }
                }
//                Task {
//                    try await DataRequest().getData()
//                }
            }
        }
    }
}

//struct rawData: Codable {
//    let gsr: String
//    let hr: String
//    let oxi: String
//    let time: String
//    let tp: String
//}


struct LiveDataView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LiveDataView(liveData: LiveDataFromJSON.sampleData)
        }
        .environmentObject(LaunchScreenStateMachine())
    }
}
