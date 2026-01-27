//
//  SessionRecord.swift
//  Mono iOS
//
//  Created by Alexander The Great on 2026-01-26.
//


import SwiftUI
import Combine
import UserNotifications
import Foundation
import UIKit
import AudioToolbox

struct SessionRecord: Identifiable, Codable {
    let id = UUID()
    let mode: AppMode
    let duration: Int
    let date: Date
    let category: String?
}

struct FocusSchedule: Identifiable, Codable {
    let id: UUID
    let startTime: String
    let endTime: String
    let label: String
}

class TimerManager: ObservableObject {
    @Published var mode: AppMode = .timer
    @Published var theme: Theme = .dark
    @Published var presets: [Int] = [5, 15, 25, 45]
    @Published var schedules: [FocusSchedule] = []
    
    @Published var timeRemaining = 1500
    @Published var isTimerRunning = false
    
    @Published var stopwatchTime = 0
    @Published var isStopwatchRunning = false
    
    @Published var history: [SessionRecord] = []
    
    private var timer: AnyCancellable?
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
            }
        }
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }
    
    var displayText: String {
        if mode == .timer {
            return timeString(from: timeRemaining)
        } else {
            return timeString(from: stopwatchTime)
        }
    }
    
    var isRunning: Bool {
        mode == .timer ? isTimerRunning : isStopwatchRunning
    }
    
    func toggleRunning() {
        if mode == .timer {
            isTimerRunning.toggle()
        } else {
            isStopwatchRunning.toggle()
        }
    }
    
    func reset() {
        if mode == .timer {
            isTimerRunning = false
            timeRemaining = 1500
        } else {
            if isStopwatchRunning && stopwatchTime > 0 {
                let category = UserDefaults.standard.string(forKey: "selectedCategory") ?? "General"
                history.append(SessionRecord(mode: .stopwatch, duration: stopwatchTime, date: Date(), category: category))
            }
            isStopwatchRunning = false
            stopwatchTime = 0
        }
    }
    
    func setTimer(minutes: Int) {
        timeRemaining = minutes * 60
        isTimerRunning = false
    }
    
    func cycleTheme() {
        theme = theme == .dark ? .light : .dark
    }
    
    func addPreset(_ minutes: Int) {
        if !presets.contains(minutes) {
            presets.append(minutes)
            presets.sort()
        }
    }
    
    func removePreset(_ minutes: Int) {
        presets.removeAll { $0 == minutes }
    }
    
    private func tick() {
        if mode == .timer && isTimerRunning && timeRemaining > 0 {
            timeRemaining -= 1
            
            if timeRemaining == 0 {
                isTimerRunning = false
                playCompletionSound()
                showNotification()
                let category = UserDefaults.standard.string(forKey: "selectedCategory") ?? "General"
                history.append(SessionRecord(mode: .timer, duration: 1500, date: Date(), category: category))
            }
        }
        if mode == .stopwatch && isStopwatchRunning {
            stopwatchTime += 1
        }
    }
    
    private func playCompletionSound() {
        AudioServicesPlaySystemSound(1007)
    }
    
    private func showNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Timer Complete"
        content.body = "Your timer has finished!"
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error: \(error)")
            }
        }
    }
    
    private func timeString(from seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", mins, secs)
    }
}
