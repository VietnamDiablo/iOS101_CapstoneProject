//
//  Session.swift
//  GetFit
//
//  Created by Enrique Camou Villa on 25/11/25.
//

import Foundation

struct Session: Codable, Equatable {
    
    var title: String
    
    var description: String
    
    var category: String?
    
    var workoutOne: String?
    var workoutTwo: String?
    var workoutThree: String?
    var workoutFour: String?

    var id: String = UUID().uuidString

}

extension Session {
    private static let sessionsKey = "Sessions"
    
    static func save(_ sessions: [Session]) {
         let data = try! JSONEncoder().encode(sessions)
         UserDefaults.standard.set(data, forKey: sessionsKey)
     }

    
    static func getSessions() -> [Session] {
          let defaults = UserDefaults.standard
          if let data = defaults.data(forKey: sessionsKey) {
              return try! JSONDecoder().decode([Session].self, from: data)
          }
          return []
      }
    
    func addSession() {
            var sessions = Session.getSessions()

            // Update if exists, otherwise append
            if let index = sessions.firstIndex(where: { $0.id == self.id }) {
                sessions[index] = self
            } else {
                sessions.append(self)
            }

            Session.save(sessions)
        }
    
    func removeSession() {
            var sessions = Session.getSessions()
            sessions.removeAll { $0.id == self.id }
            Session.save(sessions)
        }
    
}
