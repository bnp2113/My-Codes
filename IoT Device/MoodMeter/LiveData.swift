//
//  LiveData.swift
//  MoodMeter
//
//  Created by Eliot Flores Portillo on 12/8/22.
//

import SwiftUI
import Foundation

//let jsonData =  """
//[
//    {
//        "time": 0,
//        "hr":   99,
//        "oxi":  98,
//        "tp":   93,
//        "gsr":  40000
//    },
//
//    {
//        "time": 4,
//        "hr":   100,
//        "oxi":  98,
//        "tp":   96,
//        "gsr":  53000
//    },
//
//    {
//        "time": 8,
//        "hr":   110,
//        "oxi":  99,
//        "tp":   96,
//        "gsr":  60000
//    }
//]
//""".data(using: .utf8)!


struct LiveData: Codable {
    var time: Int
    var hr: Int
    var oxi: Int
    var tp: Int
    var gsr: Int
}

struct LiveDataFromJSON {
    var TIME: String
    var HR: String
    var OXI: String
    var TP: String
    var GSR: String
}

struct Tuple: Hashable, Codable {
    let gsr: String
    let time: String
    let hr : String
    let oxi : String
    let tp : String
}

class ViewModel: ObservableObject {
    @Published var tuples: [Tuple] = []
    //@Published var gsr_image: UIImage
    
//    init() {
//        gsr_image = UIImage(named:"Default")!
//    }

    func getData() {
        guard let url = URL(string: "http://18.223.21.237:8080/data")
        else { return }

        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let tuples = try JSONDecoder().decode([Tuple].self, from: data)
                DispatchQueue.main.async {
                    self?.tuples = tuples
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
//    func getImage() {
//        guard let url = URL(string: "http://18.223.21.237:8080/data")
//        else {return}
//
//        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            do {
//                DispatchQueue.main.async {
//                    self?.gsr_image = UIImage(data: data)!
//                }
//            }
//
//        }
//        task.resume()
//    }
}






extension LiveDataFromJSON {
    static let sampleData: [LiveDataFromJSON] =
    [
        //LiveDataFromJSON(TIME: jsonData[0].time, HR: jsonData[0].hr, OXI: jsonData[0].oxi, TP: jsonData[0].tp, GSR: jsonData[0].gsr)
        //LiveDataFromJSON(TIME: inData[1].time, HR: inData[1].hr, OXI: inData[1].oxi, TP: inData[1].tp, GSR: inData[1].gsr),
//        LiveDataFromJSON(TIME: inData[2].time, HR: inData[2].hr, OXI: inData[2].oxi, TP: inData[2].tp, GSR: inData[2].gsr)
    ]
}
