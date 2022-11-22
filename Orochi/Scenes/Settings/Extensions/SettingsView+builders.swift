//
//  SettingsView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI

extension SettingsView {
    typealias Localized = String.Adjusts
    
    /// App tracker section
    @ViewBuilder
    func anilistSection() -> some View {
        Section {
            HStack {
                Button(role: vm.logged ? .destructive : .none) {
                    vm.logged.toggle()
                    // TODO: - Login on AniList API
                } label: {
                    Text(vm.logged ? Localized.logOut.uppercased() : Localized.logIn.uppercased())
                        .font(.caption)
                        .fontWeight(.semibold)
                }.buttonStyle(.borderless)
                Spacer()
                Text(vm.logged ? "\(Localized.trackerUser): **douglazhs**" : "")
                    .font(.caption)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
        } header: {
            VStack(alignment: .leading) {
                Text(Localized.trackerHeader)
                HStack{
                    Link(destination: URL(string: "https://anilist.co/home")!) {
                        Image(appImage: .ani_list_logo)
                            .resizable()
                            .cornerRadius(5.5)
                            .frame(
                                maxWidth: 45,
                                maxHeight: 45
                            )
                            .shadow(color: .black.opacity(0.3), radius: 1.5, x: 2.5, y: 2.5)
                    }
                    Text(String.Name.aniList)
                    Spacer()
                    Text(vm.logged ? "34 Mangas" : "")
                        .font(.caption)
                }
                .padding(10)
                .background(StandardCellGradient())
            }
        } footer: {
            Text(Localized.trackerFooter)
        }
    }
    
    /// App Age Rating section
    @ViewBuilder
    func ageRatingSection() -> some View {
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
            Text(Localized.ageRatingHeader)
        } footer: {
            Text(Localized.ageRatingFooter)
        }
    }
    
    /// App iCloud section
    @ViewBuilder
    func icloudSection() -> some View {
        Section {
            Toggle(isOn: $vm.iCloud) {
                Label {
                    Text(Localized.icloudSync)
                } icon: {
                    Image(systemName: "link.icloud.fill")
                        .foregroundColor(.primary)
                }
            }
        } header: {
            Text(Localized.icloudHeader)
        } footer: {
            Text(Localized.icloudFooter)
        }
    }
    
    /// App security section
    @ViewBuilder
    func securitySection() -> some View {
        Section {
            Toggle(isOn: $vm.faceID) {
                Label {
                    Text(Localized.securityBiometry)
                } icon: {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.primary)
                }
            }
            Picker(Localized.securityLevel, selection: $vm.securityLevel) {
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
            Text(Localized.securityHeader)
        } footer: {
            Text(Localized.securityFooter)
        }
    }
    
    /// Notification section
    @ViewBuilder
    func notificationsSection() -> some View {
        Section {
            Toggle(isOn: $vm.notifications) {
                Label {
                    Text(Localized.notificationUpdate)
                } icon: {
                    Image(systemName: "bell.badge")
                        .foregroundColor(.red)
                }
            }
        } header: {
            Text(Localized.notificationHeader)
        } footer: {
            Text(Localized.notificationFooter)
        }
    }
}
