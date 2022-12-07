//
//  LibraryTimeline.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 04/12/22.
//

import SwiftUI

struct LibraryTimeline: View {
    var body: some View {
        TimelineView(.periodic(from:  Date(timeIntervalSinceReferenceDate: -123456789.0), by: 1.0)) { timeline in
            Text("\(timeline.date.formatted(date: .abbreviated, time: .omitted))")
                .lineLimit(1)
                .font(.footnote)
                .fontWeight(.heavy)
        }
    }
}

struct LibraryTimeline_Previews: PreviewProvider {
    static var previews: some View {
        LibraryTimeline()
    }
}
