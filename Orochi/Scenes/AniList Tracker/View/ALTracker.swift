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
    @State var height: CGFloat = UIScreen.height
    var manga: MangaDomain
    var action: Binding<Bool>
    
    init(
        of manga: MangaDomain,
        action: Binding<Bool>
    ) {
        self.manga = manga
        self.action = action
    }
    
    var body: some View {
        self.content()
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            height = proxy.size.height
                        }
                }
            }
            .presentationDetents([.height(height)])
    }
}

struct ALTracker_Previews: PreviewProvider {
    static var previews: some View {
        ALTracker(
            of: MangaDomain.samples[1],
            action: .constant(true)
        )
    }
}
