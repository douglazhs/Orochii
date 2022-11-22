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
                    Text(vm.logged ? "Log Out" : "Login")
                }
                Spacer()
                Text(vm.logged ? "douglazhs" : "")
                    .font(.caption)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
        } header: {
            HStack{
                Link(destination: URL(string: "https://anilist.co/home")!) {
                    Image("AniList_logo")
                        .resizable()
                        .cornerRadius(5.5)
                        .frame(
                            maxWidth: 45,
                            maxHeight: 45
                        )
                }
                Text("Anilist")
                Spacer()
                Text(vm.logged ? "34 Mangas" : "")
                    .font(.caption)
            }
        } footer: {
            Text("Your anilist preferences. You can connect with your anilist account and update your mangas.")
        }
    }
    
    @ViewBuilder func ageRatingSection() -> some View {
        Section {
            Toggle(isOn: $vm.nfsw) {
                Text("**NSFW** content")
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
                Text("Synchronization")
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
            if vm.faceID {
                Picker("Security Level", selection: $vm.securityLevel) {
                    ForEach(SecurityLevel.allCases, id: \.self) { level in
                        Label {
                            Text(level.info.0)
                        } icon: {
                            Image(systemName: level.info.1)
                        }
                    }
                }.pickerStyle(.inline)
            }
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
                    Text("Notifications")
                } icon: {
                    Image(systemName: "bell")
                        .foregroundColor(.red)
                }
            }
        } header: {
            Text("Notification")
        } footer: {
            Text("You will be notified every time a new manga chapter is released.")
        }
    }
}
