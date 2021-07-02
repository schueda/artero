//
//  RememberCardView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct RememberCardView: View {
    @StateObject private var notificationPreference: NotificationPreference = NotificationPreferenceController().get()
    @State var showAlert = false
    
    func disableNotifications() {
        DispatchQueue.main.async {
            self.notificationPreference.active = false
        }
    }
    
    func triggerAlert() {
        DispatchQueue.main.async {
            self.showAlert = true
        }
    }
    
    func enableNotificationsAlert() -> Alert {
        return Alert (
            title: Text(NSLocalizedString("enable_notifications_alert_title", comment: "")),
            message: Text(NSLocalizedString("enable_notifications_alert_description", comment: "")),
            primaryButton: .default(Text(NSLocalizedString("enable_notifications_alert_settigns", comment: "")), action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }),
            secondaryButton: .cancel()
        )
    }
    
    func checkNotificationPermission() {
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { permission in
            switch permission.authorizationStatus  {
            case .authorized, .provisional:
                self.notificationPreference.save()
            case .denied, .ephemeral:
                self.disableNotifications()
                self.triggerAlert()
            case .notDetermined:
                self.askPermissionNotification()
            @unknown default:
                self.askPermissionNotification()
            }
        })
    }
    
    func askPermissionNotification() {
        let current = UNUserNotificationCenter.current()
        current.requestAuthorization(options: [.alert, .badge, .sound]) { sucess, error in
            if sucess {
                self.notificationPreference.save()
            } else {
                self.disableNotifications()
            }
        }
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Image(systemName:"bell.fill")
                    .font(.system(size: 17, weight: .bold, design: .default))
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading) {
                    
                    Toggle(isOn: $notificationPreference.active) {
                        Text(NSLocalizedString("daily_reminder", comment: ""))
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.secondary)
                            .onChange(of: notificationPreference.active, perform: { value in
                                if value {
                                    self.checkNotificationPermission()
                                } else {
                                    self.notificationPreference.save()
                                }
                            })
                    }
                }
            }
            .padding(.vertical)
            
            Divider()
                .frame(width: 330, height: 0, alignment: .center)
            
            VStack (alignment: .leading)  {
                HStack {
                    VStack (alignment: .leading) {
                        Text(NSLocalizedString("time", comment: ""))
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(Color("text"))
                            .padding(.vertical)
                    }
                    Spacer()
                    DatePicker("", selection: $notificationPreference.time, displayedComponents: [.hourAndMinute])
                        .labelsHidden()
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .disabled(!notificationPreference.active)
                        .onChange(of: notificationPreference.time, perform: { value in
                            notificationPreference.save()
                        })
                }
            }
        }
        .alert(isPresented: self.$showAlert, content: { self.enableNotificationsAlert()})
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 120, maxHeight: 120, alignment: .leading)
        .padding()
        .background(Color("card"))
        .cornerRadius(12.0)
    }
}
