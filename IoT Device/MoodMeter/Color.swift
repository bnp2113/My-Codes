import SwiftUI

enum Theme: String {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
        }
}

extension Color {
    
    static let hrText = Color(red: 255 / 255, green: 50 / 255, blue: 50 / 255)
    static let moveRingBackground = Color(red: 33 / 255, green: 2 / 255, blue: 3 / 255)
    static let moveRingStartColor = Color(red: 210 / 255, green: 19 / 255, blue: 49 / 255)
    static let moveRingEndColor = Color(red: 255 / 255, green: 50 / 255, blue: 135 / 255)
    
    static let exerciseRingWeekdayBackground = Color(red: 31 / 255, green: 50 / 255, blue: 19 / 255)
    static let exerciseRingBackground = Color(red: 6 / 255, green: 34 / 255, blue: 1 / 255)
    static let exerciseRingStartColor = Color(red: 63 / 255, green: 212 / 255, blue: 0 / 255)
    static let exerciseRingEndColor = Color(red: 184 / 255, green: 255 / 255, blue: 0 / 255)
    
    static let temperatureTextColor = Color(red: 220 / 255, green: 220 / 255, blue: 59 / 255)
    static let temperatureBarColor = Color(red: 220 / 255, green: 220 / 255, blue: 59 / 255)
    
    static let moveTextColor = Color(red: 241 / 255, green: 21 / 255, blue: 79 / 255)
    static let sweatBarStartColor = Color(red: 0 / 255, green: 225 / 255, blue: 150 / 255)
    static let sweatBarEndColor = Color(red: 0 / 255, green: 225 / 255, blue: 150 / 255)
    
    static let exerciseTextColor = Color(red: 165 / 255, green: 255 / 255, blue: 4 / 255)
    static let exerciseBarStartColor = Color(red: 55 / 255, green: 218 / 255, blue: 5 / 255)
    static let exerciseBarEndColor = Color(red: 181 / 255, green: 255 / 255, blue: 6 / 255)
    
    static let bloodOxygenTextColor = Color(red: 0 / 255, green: 255 / 255, blue: 245 / 255)
    static let bloodOxygenBarStartColor = Color(red: 0 / 255, green: 186 / 255, blue: 224 / 255)
    static let bloodOxygenBarEndColor = Color(red: 0 / 255, green: 250 / 255, blue: 208 / 255)

    static let chartLegendText = Color(red: 141 / 255, green: 141 / 255, blue: 149 / 255)
    
    static let activityValueText = Color(red: 170 / 255, green: 180 / 255, blue: 190 / 255)
    
    static let dividerBackground = Color(red: 46 / 255, green: 47 / 255, blue: 51 / 255)
    
}

