//
//  ProgressIndicator.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/07/23.
//

import SwiftUI

struct ProgressIndicator: View {
    @Binding var total: Double
    @Binding var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.accentColor.opacity(0.5),
                    lineWidth: 3.75
                )
            Circle()
                .trim(from: 0, to: progress / total)
                .stroke(
                    Color.accentColor,
                    style: StrokeStyle(
                        lineWidth: 3.75,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.spring(), value: progress)
        }
        .frame(width: 20, height: 20)
    }
}

struct ProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ProgressIndicator(
            total: .constant(100),
            progress: .constant(20)
        )
    }
}
