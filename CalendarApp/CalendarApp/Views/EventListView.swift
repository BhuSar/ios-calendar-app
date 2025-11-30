import SwiftUI

struct EventListView: View {
    let events: [Event]
    let store: EventStore
    let selectedDate: Date
    @Binding var showAddEvent: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Events on \(formatted(selectedDate))")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                
                Spacer()
                
                Button {
                    showAddEvent = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            if events.isEmpty {
                Text("No events for this day.")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            } else {
                ForEach(events) { event in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(event.title)
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            if !event.notes.isEmpty {
                                Text(event.notes)
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                        }
                        
                        Spacer()
                        
                        Button(role: .destructive) {
                            store.deleteEvent(event)
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    func formatted(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "MMMM d"
        return f.string(from: date)
    }
}
