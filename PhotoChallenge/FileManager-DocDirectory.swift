//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Garret Poole on 4/22/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        //can make url to a file in documents directory whenever we want
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
