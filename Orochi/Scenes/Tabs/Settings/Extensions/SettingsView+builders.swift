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
        .navigationTitle(String.Settings.title)
        .animation(
            .easeInOut(duration: 0.125),
            value: vm.biometryPreference
        )
        .background(BlurBackground(with: .view_background))
        .scrollContentBackground(.hidden)
    }
    
    /// App tracker section
    @ViewBuilder
    func anilistSection() -> some View {
        Section {
            trackerCell()
                .frame(maxWidth: UIScreen.width)
                .overlay(alignment: .trailing) {
                    accButtonHandler()
                }
        } header: {
            Text(Localized.trackerHeader)
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
                Text(vm.biometricsError?.localizedDescription ?? "")
                    .foregroundColor(.accentColor)
                    .bold()
            }
        }
        .disabled(!vm.biometrics)
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
