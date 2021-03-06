//
//  Settings.swift
//  Be Calm
//
//  Created by Ella Halls on 27/11/21.
//

import SwiftUI
import CoreHaptics


struct SettingsView: View {
    @Binding var showSettingsView: Bool
    
    @AppStorage("reduce_haptics") var reduceHaptics = false
    @AppStorage("inhale_time") var inhaleTime = TimeConstants.defaultInhaleTime
    @AppStorage("hold_time") var holdTime = TimeConstants.defaultHoldTime
    @AppStorage("exhale_time") var exhaleTime = TimeConstants.defaultExhaleTime
    @AppStorage("reps_count") var totalReps = TimeConstants.defaultTotalReps
   
    
    var body: some View {
        NavigationView {
            List {
                if CHHapticEngine.capabilitiesForHardware().supportsHaptics {
                    Section {
                        Toggle(isOn: $reduceHaptics) {
                            HStack {
                                ZStack {
                                    Image(systemName: "iphone.radiowaves.left.and.right")
                                        .foregroundColor(.white)
                                        .font(.callout)
                                }.frame(width: 28, height: 28).background(Color.orange).cornerRadius(6)
                                Text("Disable Vibrations")
                            }
                        }
                    }
                }
                
                Section(header: Text("Custom Breathing Pattern")) {
                    Stepper(value: $inhaleTime, in: 1...30) {
                        HStack {
                            ZStack {
                                Image(systemName: "wave.3.left")
                                    .foregroundColor(.white)
                                    .font(.callout)
                            }.frame(width: 28, height: 28).background(Color.blue).cornerRadius(6)
                            Text("Inhale: \(inhaleTime) \(inhaleTime == 1 ? "second" : "seconds")")
                        }
                    }
                    
                    Stepper(value: $holdTime, in: 1...30) {
                        HStack {
                            ZStack {
                                Image(systemName: "minus")
                                    .foregroundColor(.white)
                                    .font(.callout)
                            }.frame(width: 28, height: 28).background(Color.blue).cornerRadius(6)
                            Text("Hold: \(holdTime) \(holdTime == 1 ? "second" : "seconds")")
                        }
                    }
                    
                    Stepper(value: $exhaleTime, in: 1...30) {
                        HStack {
                            ZStack {
                                Image(systemName: "wave.3.right")
                                    .foregroundColor(.white)
                                    .font(.callout)
                            }.frame(width: 28, height: 28).background(Color.blue).cornerRadius(6)
                            Text("Exhale: \(exhaleTime) \(exhaleTime == 1 ? "second" : "seconds")")
                        }
                    }
                    
                    Stepper(value: $totalReps, in: 1...50) {
                        HStack {
                            ZStack {
                                Image(systemName: "repeat")
                                    .foregroundColor(.white)
                                    .font(.callout)
                            }.frame(width: 28, height: 28).background(Color.green).cornerRadius(6)
                            Text("\(totalReps) \(totalReps == 1 ? "repetition" : "repetitions")")
                        }
                    }
                    
                    Button(action: {
                        inhaleTime = TimeConstants.defaultInhaleTime
                        holdTime = TimeConstants.defaultHoldTime
                        exhaleTime = TimeConstants.defaultExhaleTime
                        totalReps = TimeConstants.defaultTotalReps
                    }) {
                        Text("Reset breathing pattern")
                    }
                }
                
                
            }.listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .navigationBarItems(trailing: Button(action: {
                self.showSettingsView = false
            }) {
                Text("Done")
                    .bold()
            })
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettingsView: .constant(true))
    }
}

