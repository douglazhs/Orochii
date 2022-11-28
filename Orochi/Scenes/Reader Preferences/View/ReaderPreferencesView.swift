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
    @State var sheetHeight: CGFloat = UIScreen.height
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    self.pageLayoutSection().listRowBackground(Color.clear)
                    self.readingModeSection().listRowBackground(Color.clear)
                }
            }
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            sheetHeight = proxy.size.height
                            print(sheetHeight)
                        }
                }
            }
            .presentationDetents([.height(sheetHeight)])
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .background(ViewBackground(with: .view_background))
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
