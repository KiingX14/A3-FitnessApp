import SwiftUI

// MARK: - Reusable UI Components

struct StatCard: View {
    let value: String
    let unit: String
    let icon: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title3)
            
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(unit)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}