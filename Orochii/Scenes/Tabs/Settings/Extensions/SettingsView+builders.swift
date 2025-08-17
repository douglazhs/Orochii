//
//  SettingsView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI

extension SettingsView {
    @ViewBuilder
    func content() -> some View {
        List {
            anilistSection()
            icloudSection()
            securitySection()
            notificationsSection()
            aboutApp()
        }
        .refreshable { vm.fetchUser() }
        .animation(
            .easeInOut(duration: 0.125),
            value: vm.biometryPreference
        )
        .scrollIndicators(.hidden)
        .fullScreenCover(isPresented: $showALAccount) {
            if let user = vm.user {
                ALAccountView(user: user)
                    .interactiveDismissDisabled()
            }
        }
    }
    
    /// App tracker section
    @ViewBuilder
    func anilistSection() -> some View {
        Section {
            trackerCell()
                .frame(maxWidth: .infinity)
                .overlay(alignment: .trailing) {
                    accButtonHandler()
                }
        } header: {
            Text(L.Adjusts.Tracker.header.capitalized)
        } footer: {
            Text(L.Adjusts.Tracker.footer.attributedString)
        }
    }
    
    /// App iCloud section
    @ViewBuilder
    func icloudSection() -> some View {
        Section {
            Toggle(isOn: $vm.iCloud) {
                Label {
                    Text(L.Adjusts.Icloud.sync)
                } icon: {
                    Image(systemName: "link.icloud.fill")
                        .foregroundStyle(.primary)
                }
            }.onChange(of: vm.iCloud) { _, newValue in
                Defaults.standard.saveBool(
                    newValue,
                    key: DefaultsKeys.Settings.sync.rawValue
                )
            }
        } header: {
            Text(L.Adjusts.Icloud.header)
        } footer: {
            Text(L.Adjusts.Icloud.footer.attributedString)
        }
    }
    
    /// App security section
    @ViewBuilder
    func securitySection() -> some View {
        Section {
            Toggle(isOn: $vm.biometryPreference) {
                Label {
                    Text(L.Adjusts.Security.biometry)
                } icon: {
                    Image(systemName: "lock.fill")
                        .foregroundStyle(.primary)
                }
            }.onChange(of: vm.biometryPreference) { _, newValue in
                Defaults.standard.saveBool(
                    newValue,
                    key: DefaultsKeys.Settings.biometry.rawValue
                )
            }
        } header: {
            Text(L.Adjusts.Security.header)
        } footer: {
            VStack(alignment: .leading) {
                Text(L.Adjusts.Security.footer)
                Text(vm.biometricsError?.localizedDescription ?? "")
                    .foregroundColor(.accentColor)
                    .bold()
            }
        }
        .disabled(!vm.biometricsAvailable)
        .onChange(of: vm.biometryPreference) { _, _ in
            vm.changeLocalAuth()
        }
    }
    
    /// Notification section
    @ViewBuilder
    func notificationsSection() -> some View {
        Section {
            Toggle(isOn: $vm.notifications) {
                Label {
                    Text(L.Adjusts.Notification.updatedMangas)
                } icon: {
                    Image(systemName: "bell.badge")
                        .foregroundStyle(.primary)
                }
            }.onChange(of: vm.notifications) { _, newValue in
                Defaults.standard.saveBool(
                    newValue,
                    key: DefaultsKeys.Settings.chUpdate.rawValue
                )
            }
        } header: {
            Text(L.Adjusts.Notification.header)
        } footer: {
            Text(L.Adjusts.Notification.footer)
        }
    }
}
