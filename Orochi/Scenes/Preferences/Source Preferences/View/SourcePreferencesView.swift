//
//  SourcePreferencesView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

struct SourcePreferencesView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: DiscoverViewModel
    
    var body: some View {
        NavigationStack {
            List {
                siteSection()
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                languageSection()
                    .listRowBackground(Color.clear)
                ageRatingSection()
                    .listRowBackground(Color.clear)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    doneButton()
                }
                
                ToolbarItem(placement: .principal) {
                    Text(String.MangaSource.title)
                        .font(.title2)
                        .fontWeight(.heavy)
                }
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .background(Color("background"))
            .standardBars()
        }
    }
}

#Preview {
    SourcePreferencesView()
        .environmentObject(DiscoverViewModel())
}
