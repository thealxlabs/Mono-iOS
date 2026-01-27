import SwiftUI
import Charts

struct SettingsView: View {
    @ObservedObject var timerManager: TimerManager
    @Environment(\.dismiss) var dismiss
    @State private var showEasterEgg = false
    @State private var konamiSequence: [String] = []
    @State private var rotateGear = false
    @State private var showAddPreset = false
    @State private var newPresetMinutes = ""
    
    @AppStorage("focusSchedules") private var focusSchedulesRaw: String = "[]"
    var focusSchedules: [String] {
        get {
            (try? JSONDecoder().decode([String].self, from: Data(focusSchedulesRaw.utf8))) ?? []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue),
               let string = String(data: data, encoding: .utf8) {
                focusSchedulesRaw = string
            }
        }
    }
    
    @AppStorage("blockedApps") private var blockedAppsRaw: String = "[]"
    var blockedApps: [String] {
        get {
            (try? JSONDecoder().decode([String].self, from: Data(blockedAppsRaw.utf8))) ?? []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue),
               let string = String(data: data, encoding: .utf8) {
                blockedAppsRaw = string
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 35) {
                        // Theme
                        VStack(alignment: .leading, spacing: 18) {
                            Text("APPEARANCE")
                                .font(.system(size: 10, weight: .semibold, design: .rounded))
                                .foregroundColor(textColor)
                                .tracking(1.5)
                            
                            HStack(spacing: 12) {
                                ForEach([Theme.dark, Theme.light], id: \.self) { theme in
                                    ThemeCard(
                                        theme: theme,
                                        isSelected: timerManager.theme == theme,
                                        textColor: textColor,
                                        action: {
                                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                                timerManager.theme = theme
                                            }
                                        }
                                    )
                                }
                            }
                        }
                        
                        // Timer Presets
                        VStack(alignment: .leading, spacing: 18) {
                            Text("TIMER PRESETS")
                                .font(.system(size: 10, weight: .semibold, design: .rounded))
                                .foregroundColor(textColor)
                                .tracking(1.5)
                            
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 12) {
                                ForEach(timerManager.presets, id: \.self) { preset in
                                    PresetCard(
                                        minutes: preset,
                                        textColor: textColor,
                                        onDelete: {
                                            timerManager.removePreset(preset)
                                        }
                                    )
                                }
                                
                                Button(action: {
                                    showAddPreset.toggle()
                                }) {
                                    VStack(spacing: 8) {
                                        Image(systemName: showAddPreset ? "minus" : "plus")
                                            .font(.system(size: 20, weight: .ultraLight))
                                        Text(showAddPreset ? "CANCEL" : "ADD")
                                            .font(.system(size: 8, weight: .medium, design: .rounded))
                                            .tracking(1)
                                    }
                                    .foregroundColor(textColor)
                                    .frame(height: 80)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(textColor, style: StrokeStyle(lineWidth: 0.5, dash: [5, 5]))
                                    )
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            
                            // Add preset input
                            if showAddPreset {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("ENTER MINUTES")
                                        .font(.system(size: 9, weight: .semibold, design: .rounded))
                                        .foregroundColor(textColor)
                                        .tracking(1)
                                    
                                    HStack(spacing: 12) {
                                        TextField("", text: $newPresetMinutes)
                                            .font(.system(size: 16, weight: .light, design: .rounded))
                                            .foregroundColor(textColor)
                                            .keyboardType(.numberPad)
                                            .frame(height: 40)
                                            .padding(.horizontal, 16)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(textColor, lineWidth: 1)
                                            )
                                        
                                        Button("ADD") {
                                            addPreset()
                                        }
                                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                                        .foregroundColor(textColor)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(textColor, lineWidth: 1)
                                        )
                                        .buttonStyle(BorderlessButtonStyle())
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(textColor, lineWidth: 1)
                                )
                                .transition(.scale.combined(with: .opacity))
                            }
                        }
                        
                        // ANALYTICS
                        VStack(alignment: .leading, spacing: 12) {
                            Text("ANALYTICS")
                                .font(.system(size: 10, weight: .semibold, design: .rounded))
                                .foregroundColor(textColor)
                                .tracking(1.5)
                            
                            if #available(iOS 16.0, *) {
                                Chart {
                                    ForEach(timerManager.history) { record in
                                        BarMark(
                                            x: .value("Date", record.date, unit: .day),
                                            y: .value("Minutes", record.duration / 60)
                                        )
                                        .foregroundStyle(by: .value("Category", record.category ?? "General"))
                                    }
                                }
                                .frame(height: 120)
                            } else {
                                Text("Upgrade to iOS 16+ for charts.")
                                    .font(.system(size: 9))
                                    .foregroundColor(textColor.opacity(timerManager.theme == .dark ? 0.5 : 0.6))
                            }
                        }
                        
                        // FOCUS SCHEDULES
                        VStack(alignment: .leading, spacing: 12) {
                            Text("FOCUS SCHEDULES")
                                .font(.system(size: 10, weight: .semibold, design: .rounded))
                                .foregroundColor(textColor)
                                .tracking(1.5)
                            ForEach(focusSchedules, id: \.self) { sched in
                                Text(sched)
                                    .font(.system(size: 11))
                                    .foregroundColor(textColor)
                            }
                            Button("+ Add Schedule") {
                                // UI to add schedule in future
                            }
                            .font(.system(size: 10))
                            .foregroundColor(textColor)
                        }
                        
                        // EASTER EGG
                        if showEasterEgg {
                            VStack(spacing: 12) {
                                Text(asciiCat)
                                    .font(.system(size: 12, design: .monospaced))
                                    .foregroundColor(textColor)
                                
                                Text("You found me! ฅ^•ﻌ•^ฅ")
                                    .font(.system(size: 10, weight: .medium, design: .rounded))
                                    .foregroundColor(textColor)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(textColor, lineWidth: 1)
                            )
                            .transition(.scale.combined(with: .opacity))
                        }
                        
                        // About
                        VStack(alignment: .leading, spacing: 16) {
                            HStack(spacing: 12) {
                                Image(systemName: "gearshape.fill")
                                    .font(.system(size: 24, weight: .ultraLight))
                                    .foregroundColor(textColor)
                                    .rotationEffect(.degrees(rotateGear ? 360 : 0))
                                    .animation(.linear(duration: 20).repeatForever(autoreverses: false), value: rotateGear)
                                    .onAppear { rotateGear = true }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("MONO")
                                        .font(.system(size: 20, weight: .thin, design: .rounded))
                                        .foregroundColor(textColor)
                                        .tracking(4)
                                    
                                    Text("A brutalist timer for focus")
                                        .font(.system(size: 11, weight: .regular, design: .rounded))
                                        .foregroundColor(textColor)
                                }
                            }
                            
                            Divider()
                                .background(textColor)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 6) {
                                    Text("Made with")
                                        .font(.system(size: 11, weight: .regular, design: .rounded))
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 9))
                                    Text("in Toronto, Canada 🇨🇦")
                                        .font(.system(size: 11, weight: .regular, design: .rounded))
                                }
                                .foregroundColor(textColor)
                                
                                Button(action: {
                                    if let url = URL(string: "https://github.com/alxgraphy") {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    HStack(spacing: 4) {
                                        Text("by Alexander Wondwossen")
                                            .font(.system(size: 11, weight: .medium, design: .rounded))
                                        Text("@alxgraphy")
                                            .font(.system(size: 11, weight: .regular, design: .rounded))
                                    }
                                    .foregroundColor(textColor)
                                    .underline()
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(textColor, lineWidth: 1)
                            )
                        }
                    }
                    .padding(40)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(textColor)
                }
            }
        }
        .tint(textColor)
    }
    
    var backgroundColor: Color { timerManager.theme == .dark ? .black : .white }
    
    var textColor: Color { timerManager.theme == .dark ? .white : .black }
    
    let asciiCat = """
     /\\_/\\
    ( o.o )
     > ^ 
    """
    
    func addPreset() {
        guard let minutes = Int(newPresetMinutes), minutes > 0, minutes <= 999 else {
            return
        }
        
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            timerManager.addPreset(minutes)
            newPresetMinutes = ""
            showAddPreset = false
        }
    }
}

struct ThemeCard: View {
    let theme: Theme
    let isSelected: Bool
    let textColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
