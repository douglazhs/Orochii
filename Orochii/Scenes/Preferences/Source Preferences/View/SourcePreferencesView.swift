//
//  SourcePreferencesView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

struct SourcePreferencesView: View {
    @Environment(\.dismiss) 
    var dismiss
    @EnvironmentObject var vm: DiscoverViewModel
    
    var body: some View {
        NavigationStack {
            List {
                siteSection()
                languageSection()
                ageRatingSection()
                coverQualitySection()
            }
            .standardBars(title: L.MangaSource.title, inline: true)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    doneButton()
                }
            } 
        }
    }
}

#Preview {
    SourcePreferencesView()
        .environmentObject(DiscoverViewModel())
}
