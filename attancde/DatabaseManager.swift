import Foundation
import SQLite3

protocol DatabaseProtocol {
    func connect() -> Bool
    func disconnect()
    func execute(_ query: String) -> Bool
    func fetch(_ query: String) -> [[String: Any]]
}

class DatabaseManager: ObservableObject {
    static let shared = DatabaseManager()
    private var database: DatabaseProtocol?
    
    private init() {}
    
    func configure(database: DatabaseProtocol) {
        self.database = database
    }
    
    func connect() -> Bool {
        return database?.connect() ?? false
    }
    
    func saveAttendance(userId: String, date: String, status: String) -> Bool {
        let query = "INSERT INTO attendance (user_id, date, status) VALUES ('\(userId)', '\(date)', '\(status)')"
        return database?.execute(query) ?? false
    }
    
    func getAttendance(userId: String) -> [[String: Any]] {
        let query = "SELECT * FROM attendance WHERE user_id = '\(userId)'"
        return database?.fetch(query) ?? []
    }
}

// SQLite Implementation
class SQLiteDatabase: DatabaseProtocol {
    private var db: OpaquePointer?
    private let dbPath: String
    
    init(dbPath: String) {
        self.dbPath = dbPath
    }
    
    func connect() -> Bool {
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            createTables()
            return true
        }
        return false
    }
    
    func disconnect() {
        sqlite3_close(db)
    }
    
    func execute(_ query: String) -> Bool {
        return sqlite3_exec(db, query, nil, nil, nil) == SQLITE_OK
    }
    
    func fetch(_ query: String) -> [[String: Any]] {
        var results: [[String: Any]] = []
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                var row: [String: Any] = [:]
                let columnCount = sqlite3_column_count(statement)
                
                for i in 0..<columnCount {
                    let columnName = String(cString: sqlite3_column_name(statement, i))
                    let columnValue = String(cString: sqlite3_column_text(statement, i))
                    row[columnName] = columnValue
                }
                results.append(row)
            }
        }
        sqlite3_finalize(statement)
        return results
    }
    
    private func createTables() {
        let createTable = """
            CREATE TABLE IF NOT EXISTS attendance (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                user_id TEXT NOT NULL,
                date TEXT NOT NULL,
                status TEXT NOT NULL
            )
        """
        execute(createTable)
    }
}

// Firebase Implementation (placeholder)
class FirebaseDatabase: DatabaseProtocol {
    func connect() -> Bool {
        // Firebase setup code
        return true
    }
    
    func disconnect() {
        // Firebase cleanup
    }
    
    func execute(_ query: String) -> Bool {
        // Firebase write operation
        return true
    }
    
    func fetch(_ query: String) -> [[String: Any]] {
        // Firebase read operation
        return []
    }
}