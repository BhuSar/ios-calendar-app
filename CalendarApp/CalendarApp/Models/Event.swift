import Foundation

struct Event: Identifiable, Codable {
    let id: UUID = UUID()
    var date: Date
    var title: String
    var notes: String
}
