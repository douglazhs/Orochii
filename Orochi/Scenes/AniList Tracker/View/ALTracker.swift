//
//  ALTracker.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 27/11/22.
//

import SwiftUI

struct ALTracker: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = ALTrackerViewModel()
    var manga: MangaDomain
    var action: Binding<Bool>
    
    init(of manga: MangaDomain, action: Binding<Bool>) {
        self.manga = manga
        self.action = action
    }
    
    var body: some View {
        self.content()
            .padding()
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear { vm.sheetHeight = proxy.size.height }
                }
            }
            .presentationDetents([.height(vm.sheetHeight)])
            .presentationDragIndicator(.visible)
            .background(BlurBackground(with: manga.cover).opacity(0.75))
            .interactiveDismissDisabled(true)
    }
}

struct ALTracker_Previews: PreviewProvider {
    static var previews: some View {
        ALTracker(
            of: MangaDomain.samples[0],
            action: .constant(true)
        )
    }
}
