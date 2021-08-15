//
//  Storage.swift
//  LabyrinthApp
//
//  Created by Galkov Nikita on 14.08.2021.
//

import Foundation

//class Route: Codable {
//    var labRoute = [[Int]]()
//}

protocol StorageType: AnyObject {
    var route: [[[Int]]] { get set }
    var steps: [Int] { get set }
    func reset()
}


class Storage: StorageType {
    
    private enum Keys {
        static let route = "com.UserStorage.route"
        static let steps = "com.UserStorage.steps"
    }

    private let storage = UserDefaults.standard
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    var route: [[[Int]]] {
        get {
            guard let data = storage.data(forKey: Keys.route) else { return [] }
            return (try? decoder.decode([[[Int]]].self, from: data)) ?? []
        }
        set {
            let data = try? encoder.encode(newValue)
            storage.set(data, forKey: Keys.route)
        }
    }
    
    var steps: [Int] {
        get {
            guard let data = storage.data(forKey: Keys.steps) else { return [] }
            return (try? decoder.decode([Int].self, from: data)) ?? []
        }
        set {
            let data = try? encoder.encode(newValue)
            storage.set(data, forKey: Keys.steps)
        }
    }
    
    func reset() {
        route.removeAll()
        steps.removeAll()
    }
}

