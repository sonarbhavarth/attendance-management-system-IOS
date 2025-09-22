//
//  attancdeApp.swift
//  attancde
//
//  Created by bhavarth on 16/09/25.
//

import SwiftUI

@main
struct attancdeApp: App {
    init() {
        setupDatabase()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func setupDatabase() {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dbPath = documentsPath.appendingPathComponent("attendance.db").path
        
        let sqliteDB = SQLiteDatabase(dbPath: dbPath)
        DatabaseManager.shared.configure(database: sqliteDB)
        _ = DatabaseManager.shared.connect()
    }
}
