//
//  LaunchScreenStateMachine.swift
//  MoodMeter
//
//  Created by Eliot Flores Portillo on 12/7/22.
//

import Foundation

enum LaunchScreenStates {
    case initState
    case inBetweenState
    case finalState
}

final class LaunchScreenStateMachine: ObservableObject {
    @Published private(set) var state: LaunchScreenStates = .initState
    
    func dismiss() {
        self.state = .inBetweenState
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.state = .finalState
        }
    }
}
