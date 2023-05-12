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
                    vm.anilistAcc.logIn()
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
            Toggle(isOn: $vm.biometryPreference) {
                Label {
                    Text(Localized.securityBiometry)
                } icon: {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.primary)
                }
            }
            if vm.biometricState == .active {
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
                .disabled(!vm.biometryPreference)
            }
        } header: {
            Text(Localized.securityHeader)
        } footer: {
            VStack(alignment: .leading) {
                Text(Localized.securityFooter)
                Text(vm.error?.localizedDescription ?? "")
                    .foregroundColor(.accentColor)
                    .bold()
            }
        }
        .disabled(!vm.biometrics)
        .onChange(of: vm.biometryPreference) { _ in
            if vm.error == nil {
                vm.changeBiometryState()
            }
            vm.error = nil
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
