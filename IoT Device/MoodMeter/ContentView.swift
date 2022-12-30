import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var launchScreenStates: LaunchScreenStateMachine
    let dailyDataCards: [DailyHealthData]
    let liveData: [LiveDataFromJSON]
    var body: some View {
        GeometryReader { geometry in
                ZStack(alignment: .top) {
                    if #available(iOS 15.0, *) {
                        Color.black.edgesIgnoringSafeArea(.all)
                    } else {
                        // Fallback on earlier versions
                    }
                    ScrollView {
                        VStack {
//                            Spacer(minLength: Constants.navigationBarHeight).frame(width: geometry.size.width, height: Constants.navigationBarHeight, alignment: .top)
                            self.createCharts()
                                NavigationLink(destination: LiveDataView(liveData: liveData)) {
                                    Label("Live Data", systemImage: "arrowshape.forward.fill")
                            }
                        }
                    }
            }
        }
    }
    
    struct BlueButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(Color(red: 0, green: 0, blue: 0.5))
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
    }
    
    func createCharts() -> some View {
        Group {
            
            // Heart Rate
            sweatBarView(
                title: "Heart Rate",
                titleColor: Color.moveTextColor,
                average: "76",
                unit: "BPM",
                data: ActivityData.moveChartData,
                textColor: Color.moveTextColor,
                barStartColor: Color.moveTextColor,
                barEndColor: Color.moveTextColor
            )
                .padding([.bottom], 25)
            
            // Temperature View
            sweatBarView(
                title: "Blood Oxygen",
                titleColor: Color.bloodOxygenTextColor,
                average: "99",
                unit: "MIN",
                data: ActivityData.exerciseChartData,
                textColor: Color.bloodOxygenTextColor,
                barStartColor: Color.bloodOxygenBarStartColor,
                barEndColor: Color.bloodOxygenBarEndColor
            )
                .padding([.bottom], 25)
            
            sweatBarView(
                title: "Temperature",
                titleColor: Color.temperatureTextColor,
                average: "56",
                unit: "CAL",
                data: ActivityData.moveChartData,
                textColor: Color.temperatureTextColor,
                barStartColor: Color.temperatureBarColor,
                barEndColor: Color.temperatureBarColor
            )

            .padding([.bottom], 25)
            sweatBarView(
                title: "Sweat Levels",
                titleColor: Color.sweatBarEndColor,
                average: "56",
                unit: "CAL",
                data: ActivityData.moveChartData,
                textColor: Color.sweatBarEndColor,
                barStartColor: Color.sweatBarStartColor,
                barEndColor: Color.sweatBarEndColor
            )
                .padding([.bottom], 25)
        }
    }
    
    func createFooter() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 60) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Steps")
                        .font(Font.system(size: 18, weight: .regular, design: .default))
                        .kerning(0.05)
                        .foregroundColor(Color.white)
                    Text("5 588")
                        .font(Font.system(size: 28, weight: .semibold, design: .rounded))
                        .kerning(0.25)
                        .foregroundColor(Color.activityValueText)
                        .padding([.top], -3)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Distance").font(Font.system(size: 18, weight: .regular, design: .default)).kerning(0.05).foregroundColor(Color.white)
                    (
                        Text("4,5")
                            .font(Font.system(size: 28, weight: .semibold, design: .rounded))
                            .kerning(0.25)
                            .foregroundColor(Color.activityValueText)
                        + Text("KM")
                            .font(Font.system(size: 24, weight: .semibold, design: .rounded))
                            .kerning(0.3).foregroundColor(Color.activityValueText)
                    )
                        .padding([.top], -3)
                }
                Spacer()
            }
            Divider()
                .background(Color.dividerBackground)
                .frame(height: 2)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 15, trailing: 0))
            Text("Flights Climbed")
                .font(Font.system(size: 18, weight: .regular, design: .default))
                .kerning(0.05)
                .foregroundColor(Color.white)
            Text("4")
                .font(Font.system(size: 28, weight: .semibold, design: .rounded))
                .kerning(0.25)
                .foregroundColor(Color.activityValueText)
                .padding([.top], -3)
            }
            .padding([.leading], 15)
    }
    
//    func createNavigationBar(_ geometrySize: CGSize) -> some View {
//        ZStack(alignment: .top) {
//            BlurView(style: .dark).edgesIgnoringSafeArea(.top)
//            VStack {
//                HStack {
//                    ForEach(0..<ActivityData.weekdays.count) { item in
//                        VStack(spacing: 5) {
//                            Text("\(ActivityData.weekdays[item].firstLetter)")
//                                .font(Font.system(size: 10, weight: .regular, design: .default))
//                                .foregroundColor(Color.white)
//                            ZStack {
//                                RingView(
//                                    percentage: ActivityData.weekdays[item].standPercentage,
//                                    backgroundColor: Color.standRingWeekdayBackground,
//                                    startColor: Color.standRingStartColor,
//                                    endColor: Color.standRingEndColor,
//                                    thickness: Constants.weekdayRingThickness
//                                )
//                                    .frame(width: 20, height: 20)
//                                    .aspectRatio(contentMode: .fit)
//                                RingView(
//                                    percentage: ActivityData.weekdays[item].exercisePercentage,
//                                    backgroundColor: Color.exerciseRingWeekdayBackground,
//                                    startColor: Color.exerciseRingStartColor,
//                                    endColor: Color.exerciseRingEndColor,
//                                    thickness: Constants.weekdayRingThickness
//                                )
//                                    .frame(width: 30, height: 30)
//                                    .aspectRatio(contentMode: .fit)
//                                RingView(
//                                    percentage: ActivityData.weekdays[item].movePercentage,
//                                    backgroundColor: Color.moveRingWeekdayBackground,
//                                    startColor: Color.moveRingStartColor,
//                                    endColor: Color.moveRingEndColor,
//                                    thickness: Constants.weekdayRingThickness
//                                )
//                                    .frame(width: 40, height: 40)
//                                    .aspectRatio(contentMode: .fit)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//            .frame(width: geometrySize.width, height: Constants.navigationBarHeight, alignment: .top)
//    }
//
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            ContentView(dailyDataCards: DailyHealthData.sampleData, liveData: LiveDataFromJSON.sampleData)
        }
    }
    
}

