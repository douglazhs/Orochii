//
//  ALTracker+dates.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/11/22.
//

import SwiftUI

extension ALTracker {
    /// Dates section: Started & Ended
    @ViewBuilder
    func dateSection() -> some View {
        VStack(spacing: 7.5) {
            DatePicker(selection: $vm.startDate, displayedComponents: [.date]) {
                Label {
                    Text("STARTED")
                        .font(.footnote)
                        .lineLimit(1)
                } icon: {
                    Image(systemName: "calendar.badge.plus")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }
            DatePicker(selection: $vm.endDate, displayedComponents: [.date]) {
                Label {
                    Text("ENDED")
                        .font(.footnote)
                        .lineLimit(1)
                } icon: {
                    Image(systemName: "calendar")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
