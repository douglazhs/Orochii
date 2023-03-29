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
    @Binding var isPresented: Bool
    @State var showPopUp: Bool = false
    var manga: MangaDomain
    var action: Binding<Bool>
    
    init(
        isPresented: Binding<Bool>,
        of manga: MangaDomain,
        action: Binding<Bool>
    ) {
        self._isPresented = isPresented
        self.manga = manga
        self.action = action
    }
    
    var body: some View {
        self.content()
    }
}

struct ALTracker_Previews: PreviewProvider {
    static var previews: some View {
        ALTracker(
            isPresented: .constant(true),
            of: MangaDomain.samples[1],
            action: .constant(true)
        )
    }
}
