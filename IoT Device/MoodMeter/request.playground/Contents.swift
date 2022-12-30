import UIKit
import SwiftUI

class DataRequest {
    func getData() async throws -> [rawData] {
        let url = URL(string: "http://18.223.21.237:8080/data")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let jsonData = try! JSONDecoder().decode([rawData].self, from: data)

        return try! JSONDecoder().decode([rawData].self, from: data)
    }
}

struct request: View {
    @State var bigData: [rawData] = []
    var body: some View {
        Text("Hello")
            .onAppear {
                Task {
                    try await DataRequest().getData()
            }
        }
    }
}

struct requestView: PreviewProvider {
    static var previews: some View {
        request()
    }
}

//struct rawData: Codable {
//    let gsr: String
//    let hr: String
//    let oxi: String
//    let time: String
//    let tp: String
//}
//
//class DataRequest {
//    func getData() async throws -> [rawData] {
//        let url = URL(string: "http://18.223.21.237:8080/data")!
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let jsonData = try! JSONDecoder().decode([rawData].self, from: data)
//
//        return try! JSONDecoder().decode([rawData].self, from: data)
//    }
//}
//
//Task {
//    let jsonData = try await DataRequest().getData()
////    for val in jsonData {
////        print(val)
////    }
//}
//
//
//for val in jsonData {
//    print(val)
//}


