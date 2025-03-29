//
//  SettingsView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI

extension SettingsView {
    typealias Localized = String.Adjusts
    
    @ViewBuilder
    func content() -> some View {
        List {
            anilistSection()
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            icloudSection()
                .listRowBackground(Color.clear)
            securitySection()
                .listRowBackground(Color.clear)
            notificationsSection()
                .listRowBackground(Color.clear)
            aboutApp()
                .listRowBackground(Color.clear)
        }
        .refreshable { vm.fetchUser() }
        .listStyle(.grouped)
        .animation(
            .easeInOut(duration: 0.125),
            value: vm.biometryPreference
        )
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
        .background(Asset.Colors.background.swiftUIColor)
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
            Text(Localized.trackerHeader.capitalized)
        } footer: {
            Text(Localized.trackerFooter)
                .foregroundColor(Asset.Colors.secondaryText.swiftUIColor)
        }
        .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
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
                }
            }.onChange(of: vm.iCloud) {
                Defaults.standard.saveBool(
                    $0,
                    key: DefaultsKeys.Settings.sync.rawValue
                )
            }
        } header: {
            Text(Localized.icloudHeader)
        } footer: {
            Text(Localized.icloudFooter)
                .foregroundColor(Asset.Colors.secondaryText.swiftUIColor)
        }
        .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
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
                        
                }
            }.onChange(of: vm.biometryPreference) {
                Defaults.standard.saveBool(
                    $0,
                    key: DefaultsKeys.Settings.biometry.rawValue
                )
            }
        } header: {
            Text(Localized.securityHeader)
        } footer: {
            VStack(alignment: .leading) {
                Text(Localized.securityFooter)
                Text(vm.biometricsError?.localizedDescription ?? "")
                    .foregroundColor(.accentColor)
                    .bold()
            }
            .foregroundColor(Asset.Colors.secondaryText.swiftUIColor)
        }
        .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
        .disabled(!vm.biometricsAvailable)
        .onChange(of: vm.biometryPreference) { _ in
            vm.changeLocalAuth()
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
                        .foregroundColor(Asset.Colors.attention.swiftUIColor)
                }
            }.onChange(of: vm.notifications) {
                Defaults.standard.saveBool(
                    $0,
                    key: DefaultsKeys.Settings.chUpdate.rawValue
                )
            }
        } header: {
            Text(Localized.notificationHeader)
        } footer: {
            Text(Localized.notificationFooter)
                .foregroundColor(Asset.Colors.secondaryText.swiftUIColor)
        }
        .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
    }
}
