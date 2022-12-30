//
//  DailyListView.swift
//  MoodMeter
//
//  Created by Eliot Flores Portillo on 12/8/22.
//

//import SwiftUI
//
//struct DailyListView: View {
//    let dailyDataCards: [DailyHealthData]
//    let liveData: [LiveDataFromJSON]
//    @EnvironmentObject var launchScreenStates: LaunchScreenStateMachine
//    @State private var goesToView: Bool = false
//    var body: some View {
////        if (MyVariables.launchState == false) {
////                    List {
////                        //            if (MyVariables.launchState == false) {
////                        Text("Mood Log")
////                            .font(.largeTitle.bold())
////                        ForEach(dailyDataCards, id: \.date) { dayData in
////                            NavigationLink(destination: ContentView(dailyDataCards: dailyDataCards)){
////                                DailyView(dayData: dayData)
////                            }
////                            .listRowBackground(dayData.theme.mainColor)
////                            .foregroundColor(Color(UIColor.systemBackground))
////                            //.navigationTitle("Daily Health Log")
////                        }
////                Button("Live Data") {
////                    Text("Here")
//                    NavigationLink (destination: LiveDataView(liveData: liveData)){
//        
//        
//                    }
//                }
//        
//        
//                            LiveButtonView()
//                        }
//        
//                    }
//                        NavigationLink (destination: LiveDataView(liveData: liveData)){
//                            List {
//                                LiveButtonView()
//                            }
//        NavigationLink(
//            destination: LiveDataView(liveData: liveData),
//            isActive: $goesToView) {
//            Button(action: { goesToView = true }) {
//                Text("Next")
//            }
//        }
        
//        .onAppear {
//            if (MyVariables.launchState == true) {
//                DispatchQueue
//                    .main
//                    .asyncAfter(deadline: .now() + 3) {
//                        launchScreenStates.dismiss()
//                        MyVariables.launchState = false
//                    }
//            }
//        }
//    }
//}
    // }
    
//    struct DailyListView_Previews: PreviewProvider {
//        static var previews: some View {
//            NavigationView {
//                DailyListView(dailyDataCards: DailyHealthData.sampleData, liveData: LiveDataFromJSON.sampleData)
//            }
//            .environmentObject(LaunchScreenStateMachine())
//        }
//    }


