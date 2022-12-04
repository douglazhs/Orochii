//
//  ReaderPreferencesView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI

struct ReaderPreferencesView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: ChapterViewModel
    
    var body: some View {
        NavigationStack {
            List {
                self.pageLayoutSection().listRowBackground(Color.clear)
                self.readingModeSection().listRowBackground(Color.clear)
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .background(BlurBackground(with: .view_background))
            .navigationTitle("Reader Preferences")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text(String.Common.done)
                    }
                }
            }
        }
    }
}

struct ReaderPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        ReaderPreferencesView()
    }
}
