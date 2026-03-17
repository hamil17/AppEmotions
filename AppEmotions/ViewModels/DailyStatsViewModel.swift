import Foundation
import Observation
import FirebaseFirestore

struct DailyAccessStat: Identifiable {
    let id: String // dayKey: yyyy-MM-dd
    let date: Date
    let accessCount: Int
}

@Observable
final class DailyStatsViewModel {
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    var recentAccessStats: [DailyAccessStat] = []
    
    deinit {
        listener?.remove()
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
    
    func listenRecentAccess(uid: String, limit: Int = 14) {
        listener?.remove()
        
        listener = db
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
}

