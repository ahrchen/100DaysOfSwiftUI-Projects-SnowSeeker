//
//  FileManager-DocumentDirectory.swift
//  SnowSeeker
//
//  Created by Raymond Chen on 4/25/22.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
