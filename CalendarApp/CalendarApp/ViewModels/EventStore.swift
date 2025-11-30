import Foundation
import Combine

class EventStore: ObservableObject {
    @Published var events: [Event] = [] {
        didSet { saveEvents() }
    }
    
    
    init() {
        loadEvents()
    }
    
    // Mark: Save Events
    func saveEvents() {
        if let data = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(data, forKey: "events")
        }
    }
    
    // Mark: Load Events
    func loadEvents() {
            if let data = UserDefaults.standard.data(forKey: "events"),
               let decoded = try? JSONDecoder().decode([Event].self, from: data) {
                events = decoded
            }
        }
    
    // Mark: Create
    func addEvent(date: Date, title: String, notes: String) {
        let newEvent = Event(date: date, title: title, notes: notes)
        events.append(newEvent)
    }
    
    // Mark: Delete
    func deleteEvent(_ event: Event) {
        events.removeAll { $0.id == event.id }
    }
    
    // Mark: Update
    func updateEvent(_ event: Event, title: String, notes: String) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index].title = title
            events[index].notes = notes
        }
    }
}
