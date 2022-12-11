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
    @State var pickerConfig = PickerConfig()
    var manga: MangaDomain
    var action: Binding<Bool>
    
    init(of manga: MangaDomain, action: Binding<Bool>) {
        self.manga = manga
        self.action = action
    }
    
    var body: some View {
        NavigationStack {
            self.content()
                .background(BlurBackground(with: manga.cover).opacity(0.75))
                .navigationTitle(String.Name.aniList)
                .animation(.easeInOut(duration: 0.125), value: vm.currentPicker)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        self.updateTrackingButton()
                    }
                }
        }
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
