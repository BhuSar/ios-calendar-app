import SwiftUI

struct CalendarView: View {
    @StateObject var vm = CalendarViewModel()
    @StateObject var store = EventStore()
    
    @State private var selectedDate: Date = Date()
    @State private var showAddEvent = false
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // MARK: - Month Header
                HStack {
                    Button(action: vm.previousMonth) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text(vm.monthTitle)
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: vm.nextMonth) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                
                // MARK: - Calendar Grid
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(vm.daysInMonth, id: \.self) { day in
                        
                        let hasEvents = store.events.contains { event in
                            vm.isSameDay(event.date, day)
                        }
                        
                        DayCellView(
                            date: day,
                            isSelected: vm.isSameDay(day, selectedDate),
                            hasEvents: hasEvents
                        )
                        .onTapGesture {
                            selectedDate = day
                        }
                    }
                }
                
                
                // MARK: - Event List
                EventListView(
                    events: store.events.filter {
                        vm.isSameDay($0.date, selectedDate)
                    },
                    store: store,
                    selectedDate: selectedDate,
                    showAddEvent: $showAddEvent
                )
            }
        }
        .sheet(isPresented: $showAddEvent) {
            AddEventView(store: store, date: selectedDate)
        }
    }
}
