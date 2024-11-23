//
//  ContentView.swift
//  MMLanScanSwiftDemo
//
//  Created by Antoine Bollengier on 23.11.2024.
//  Copyright © 2024 Antoine Bollengier (github.com/b5i). All rights reserved.
//

import SwiftUI

@main
struct ContentView: App {
    @ObservedObject var scannerModel = ScannerModel.shared
    
    var body: some Scene {
        WindowGroup {
            if scannerModel.isScanning {
                ProgressView()
            } else {
                Button("Scan") {
                    scannerModel.startNetWorkScan()
                }
                List {
                    ForEach(Array(scannerModel.connectedDevices), id: \.self) { device in
                        VStack(alignment: .leading) {
                            Text("IP: ").castedForegroundStyle(.secondary) + Text(device.ipAddress ?? "Unknown")
                            
                            // not defined on iOS because ARP table lookup is not available
                            Text("MAC: ").castedForegroundStyle(.secondary) + Text(device.macAddress ?? "Unknown")
                            Text("Brand: ").castedForegroundStyle(.secondary) + Text(device.brand ?? "Unknown")
                            Text("Hostname: ").castedForegroundStyle(.secondary) + Text(device.hostname ?? "Unknown")
                        }
                    }
                }
            }
        }
    }
}

extension Text {
    func castedForegroundStyle(_ color: Color) -> Text {
        if #available(iOS 17.0, *) {
            self.foregroundStyle(color)
        } else {
            self.foregroundColor(color)
        }
    }
}
