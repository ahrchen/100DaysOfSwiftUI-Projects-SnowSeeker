//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Raymond Chen on 4/24/22.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    
    static fileprivate let savePath = FileManager.documentDirectory.appendingPathComponent("Favorites")
    
    init() {
        do {
            let data = try Data(contentsOf: Favorites.savePath)
            let resorts = try JSONDecoder().decode(Set<String>.self, from: data)
            self.resorts = resorts
        } catch {
            resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: Favorites.savePath, options:[.atomic, .completeFileProtection])
        } catch {
            print("Unable to save favorites data")
        }
    }
}
