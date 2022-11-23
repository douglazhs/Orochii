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
            WebsiteStandardCell(
                header: Localized.trackerHeader,
                title: String.Name.aniList,
                urlString: "https://anilist.co/home",
                image: .ani_list_logo,
                customInfo: (show: true, description: vm.logged ? "34 Mangas" : "")
            )
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
            Toggle(isOn: $vm.biometry) {
                Label {
                    Text(Localized.securityBiometry)
                } icon: {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.primary)
                }
            }
            if vm.biometry {
                Picker(Localized.securityLevel, selection: $vm.securityLevel) {
                    ForEach(SecurityLevel.allCases) { level in
                        VStack(alignment: .leading, spacing: 5) {
                            Label {
                                Text(level.description)
                            } icon: {
                                Image(systemName: level.info.0)
                            }
                            Text(level.info.1)
                                .foregroundColor(Color(uiColor: .systemGray))
                                .font(.caption2)
                        }
                    }
                }
                .pickerStyle(.inline)
                .disabled(!vm.biometry)
            }
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
