import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject var launchScreenStates: LaunchScreenStateMachine
    @State private var firstAnimation: Bool = false
    @State private var secondAnimation: Bool = false
    
    private let timer = Timer.publish(every: 0.65, on: .main, in: .common).autoconnect()
    
    var body: some View {
            ZStack {
                LaunchScreenBackground
                icon1x
                VStack {
                    Spacer()
                        .frame(height: 150)
                    titleText
                }
            }
    
        .onReceive(timer) {
            input in
            switch launchScreenStates.state {
            case.initState:
                withAnimation(.spring()) {
                    firstAnimation.toggle()
                }
            case .inBetweenState:
                withAnimation(.easeInOut) {
                    secondAnimation.toggle()
                }
            default: break
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenStateMachine())
    }
}

private extension LaunchScreenView {
    var LaunchScreenBackground: some View {
        Color("LaunchScreenColor")
            .edgesIgnoringSafeArea(.all)
    }
    
    var icon1x: some View {
        Image("icon1x")
            .scaleEffect(firstAnimation ? 0.6 : 1)
            .scaleEffect(secondAnimation ? UIScreen.main.bounds.size.height / 4 : 1)
    }
    
    var titleText: some View {
        Text("MoodMeter")
            .foregroundColor(Color(white: 2))
            .font(.system(.largeTitle, design: .serif))
            .scaleEffect(firstAnimation ? 0.6 : 1)
            .scaleEffect(secondAnimation ? UIScreen.main.bounds.size.height / 4 : 1)
    }
}
