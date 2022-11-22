//
//  SettingsView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI

extension SettingsView {
    @ViewBuilder func anilistSection() -> some View {
        Section {
            HStack {
                Button(role: vm.logged ? .destructive : .none) {
                    vm.logged.toggle()
                    // TODO: - Login on AniList API
                } label: {
                    Text(vm.logged ? "LOG OUT" : "LOGIN")
                        .font(.caption)
                        .fontWeight(.semibold)
                }.buttonStyle(.borderless)
                Spacer()
                Text(vm.logged ? "User: **douglazhs**" : "")
                    .font(.caption)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
        } header: {
            VStack(alignment: .leading) {
                Text("Tracker")
                HStack{
                    Link(destination: URL(string: "https://anilist.co/home")!) {
                        Image("AniList_logo")
                            .resizable()
                            .cornerRadius(5.5)
                            .frame(
                                maxWidth: 45,
                                maxHeight: 45
                            )
                            .shadow(color: .black.opacity(0.3), radius: 1.5, x: 2.5, y: 2.5)
                    }
                    Text("Anilist")
                    Spacer()
                    Text(vm.logged ? "34 Mangas" : "")
                        .font(.caption)
                }
                .padding(10)
                .background(StandardCellGradient())
            }
        } footer: {
            Text("You can connect your **AniList** account and track your mangas")
        }
    }
    
    @ViewBuilder func ageRatingSection() -> some View {
        Section {
            Toggle(isOn: $vm.nfsw) {
                Label {
                    Text("NSFW")
                } icon: {
                    Image(systemName: "eyes.inverse")
                        .foregroundColor(.orange)
                }
            }
        } header: {
            Text("Age Rating")
        } footer: {
            Text("**Not safe for work**: material that should only be looked at in private because it contains some things that could be _offensive_")
        }
    }
    
    @ViewBuilder func icloudSection() -> some View {
        Section {
            Toggle(isOn: $vm.iCloud) {
                Label {
                    Text("Synchronization")
                } icon: {
                    Image(systemName: "link.icloud.fill")
                        .foregroundColor(.primary)
                }
            }
        } header: {
            Text("iCloud")
        } footer: {
            Text("Your manga library will be saved in the **Cloud** to be accessed from other devices")
        }
    }
    
    @ViewBuilder func securitySection() -> some View {
        Section {
            Toggle(isOn: $vm.faceID) {
                Label {
                    Text("Face ID")
                } icon: {
                    Image(systemName: "faceid")
                        .foregroundColor(.primary)
                }
            }
            Picker("Security Level", selection: $vm.securityLevel) {
                ForEach(SecurityLevel.allCases, id: \.self) { level in
                    VStack(alignment: .leading, spacing: 5) {
                        Label {
                            Text(level.info.0)
                        } icon: {
                            Image(systemName: level.info.1)
                        }
                        Text(level.info.2)
                            .foregroundColor(Color(uiColor: .systemGray))
                            .font(.caption2)
                    }
                }
            }.pickerStyle(.inline)
            .disabled(!vm.faceID)
        } header: {
            Text("Security")
        } footer: {
            Text("Here you have some options to make your app and your manga more secure")
        }
    }
    
    @ViewBuilder func notificationsSection() -> some View {
        Section {
            Toggle(isOn: $vm.notifications) {
                Label {
                    Text("Updated Mangas")
                } icon: {
                    Image(systemName: "bell.badge")
                        .foregroundColor(.red)
                }
            }
        } header: {
            Text("Notification")
        } footer: {
            Text("You will be notified every time a new manga chapter is released")
        }
    }
}
