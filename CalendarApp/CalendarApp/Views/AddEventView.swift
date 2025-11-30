import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) var dismiss
    
    let store: EventStore
    let date: Date
    
    @State private var title: String = ""
    @State private var notes: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    
                    TextField("Title", text: $title)
                    
                    TextField("Notes", text: $notes)
                }
                
                Section {
                    Button("Save Event") {
                        store.addEvent(date: date, title: title, notes: notes)
                        dismiss()   // close the sheet
                    }
                    .foregroundColor(.blue)
                }
            }
            .navigationTitle("New Event")
        }
    }
}
