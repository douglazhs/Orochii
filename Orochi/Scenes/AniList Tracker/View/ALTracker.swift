//
//  ALTracker.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 27/11/22.
//

import SwiftUI
import struct MangaDex.Manga

struct ALTracker: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: ALTrackerViewModel
    @Binding var isPresented: Bool
    @State var showPopUp: Bool = false
    var action: Binding<Bool>
    
    init(
        isPresented: Binding<Bool>,
        of manga: Manga,
        action: Binding<Bool>
    ) {
        _vm = StateObject(wrappedValue: ALTrackerViewModel(manga)) 
        self._isPresented = isPresented
        self.action = action
    }
    
    var body: some View {
        NavigationStack {
            content()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if vm.tracking() {
                            updateTrackingButton()
                        } else { trackButton() }
                    }
                }
        }
    }
}

struct ALTracker_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        /*ALTracker(
            isPresented: .constant(true),
            of: ,
            action: .constant(true)
        )*/
    }
}
