//
//  LiveButtonView.swift
//  MoodMeter
//
//  Created by Eliot Flores Portillo on 12/11/22.
//

import SwiftUI

struct LiveButtonView: View {
    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                  Text("Live Data")
                        .font(.largeTitle.bold())
                        .padding(.trailing, 20)
                }
            }
            .padding()
            .foregroundColor(.black)
        }
}

struct LiveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LiveButtonView()
            .background(Color.sweatBarEndColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
