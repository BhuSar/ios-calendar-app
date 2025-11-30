import SwiftUI

struct DayCellView: View {
    let date: Date
    let isSelected: Bool
    let hasEvents: Bool
    
    var body: some View {
        VStack(spacing: 6) {
            // Day number
            Text("\(Calendar.current.component(.day, from: date))")
                .foregroundColor(.white)
                .font(.headline)
                .frame(width: 40, height: 40)
                .background(
                    isSelected ?
                    Color.blue.opacity(0.8) :
                    Color.gray.opacity(0.25)
                )
                .clipShape(Circle())
            
            // Dot indicator for events
            if hasEvents {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 6, height: 6)
            }
        }
    }
}
