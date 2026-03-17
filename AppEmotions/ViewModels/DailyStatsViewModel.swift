import Foundation
import Observation
import FirebaseFirestore

struct DailyAccessStat: Identifiable {
    let id: String // dayKey: yyyy-MM-dd
    let date: Date
    let accessCount: Int
}

enum DailyTaskId: String, CaseIterable {
    case didAnalyze
    case didMeditate30s
    case didRegisterMalestar
    case didOpenDashboard
    case didExploreEmotion
}

@Observable
final class DailyStatsViewModel {
    private let db = Firestore.firestore()
    private var recentListener: ListenerRegistration?
    private var todayListener: ListenerRegistration?
    
    var recentAccessStats: [DailyAccessStat] = []
    var todayProgress: Double = 0
    var todayTasksCompleted: Int = 0
    
    deinit {
        recentListener?.remove()
        todayListener?.remove()
    }
    
    static func dayKey(for date: Date, calendar: Calendar = .current) -> String {
        let start = calendar.startOfDay(for: date)
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = calendar.timeZone
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: start)
    }
    
    func trackMainAccess(uid: String, date: Date = Date(), calendar: Calendar = .current) {
        let startOfDay = calendar.startOfDay(for: date)
        let key = Self.dayKey(for: date, calendar: calendar)
        
        let docRef = db
            .collection("users")
            .document(uid)
            .collection("daily")
            .document(key)
        
        let data: [String: Any] = [
            "dayKey": key,
            "date": Timestamp(date: startOfDay),
            "accessCount": FieldValue.increment(Int64(1)),
            "updatedAt": FieldValue.serverTimestamp()
        ]
        
        docRef.setData(data, merge: true) { error in
            if let error {
                print("Error guardando acceso diario: \(error)")
            }
        }
    }
    
    func markTask(uid: String, task: DailyTaskId, date: Date = Date(), calendar: Calendar = .current) {
        let startOfDay = calendar.startOfDay(for: date)
        let key = Self.dayKey(for: date, calendar: calendar)
        
        let docRef = db
            .collection("users")
            .document(uid)
            .collection("daily")
            .document(key)
        
        db.runTransaction({ transaction, errorPointer in
            let snapshot: DocumentSnapshot
            do {
                snapshot = try transaction.getDocument(docRef)
            } catch let error as NSError {
                errorPointer?.pointee = error
                return nil
            }
            
            let existingTasks = (snapshot.data()?["tasks"] as? [String: Bool]) ?? [:]
            var tasks = existingTasks
            tasks[task.rawValue] = true
            
            let completed = tasks.values.filter { $0 }.count
            let progress = min(100.0, (Double(completed) / Double(DailyTaskId.allCases.count)) * 100.0)
            
            transaction.setData([
                "dayKey": key,
                "date": Timestamp(date: startOfDay),
                "tasks": tasks,
                "tasksCompleted": completed,
                "progress": progress,
                "updatedAt": FieldValue.serverTimestamp()
            ], forDocument: docRef, merge: true)
            
            return nil
        }) { _, error in
            if let error {
                print("Error marcando tarea diaria: \(error)")
            }
        }
    }
    
    func listenRecentAccess(uid: String, limit: Int = 14) {
        recentListener?.remove()
        
        recentListener = db
            .collection("users")
            .document(uid)
            .collection("daily")
            .order(by: "date", descending: true)
            .limit(to: limit)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self else { return }
                
                if let error {
                    print("Error leyendo daily: \(error)")
                    self.recentAccessStats = []
                    return
                }
                
                guard let docs = snapshot?.documents else {
                    self.recentAccessStats = []
                    return
                }
                
                let mapped: [DailyAccessStat] = docs.compactMap { doc in
                    let data = doc.data()
                    let dayKey = (data["dayKey"] as? String) ?? doc.documentID
                    let date = (data["date"] as? Timestamp)?.dateValue() ?? Date.distantPast
                    
                    let accessCountAny = data["accessCount"]
                    let accessCount =
                        (accessCountAny as? Int)
                        ?? (accessCountAny as? Int64).map(Int.init)
                        ?? 0
                    
                    return DailyAccessStat(id: dayKey, date: date, accessCount: accessCount)
                }
                
                // Orden cronológico para graficar de izq->der
                self.recentAccessStats = mapped.sorted(by: { $0.date < $1.date })
            }
    }
    
    func listenToday(uid: String, date: Date = Date(), calendar: Calendar = .current) {
        todayListener?.remove()
        
        let key = Self.dayKey(for: date, calendar: calendar)
        let docRef = db
            .collection("users")
            .document(uid)
            .collection("daily")
            .document(key)
        
        todayListener = docRef.addSnapshotListener { [weak self] snapshot, error in
            guard let self else { return }
            
            if let error {
                print("Error leyendo daily hoy: \(error)")
                self.todayProgress = 0
                self.todayTasksCompleted = 0
                return
            }
            
            guard let data = snapshot?.data() else {
                self.todayProgress = 0
                self.todayTasksCompleted = 0
                return
            }
            
            let progressAny = data["progress"]
            let progress =
                (progressAny as? Double)
                ?? (progressAny as? Int).map(Double.init)
                ?? 0
            
            let tasksCompletedAny = data["tasksCompleted"]
            let tasksCompleted =
                (tasksCompletedAny as? Int)
                ?? (tasksCompletedAny as? Int64).map(Int.init)
                ?? 0
            
            self.todayProgress = progress
            self.todayTasksCompleted = tasksCompleted
        }
    }
}

