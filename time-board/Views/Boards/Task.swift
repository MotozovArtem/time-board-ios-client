//
//  Task.swift
//  time-board
//
//  Created by Tianid on 01.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
// About protocol realization: https://medium.com/@foffer/drag-and-drop-with-custom-classes-using-codable-in-ios-11-77f20fe812eb

import Foundation
import MobileCoreServices

class Task: NSObject, Codable {
  
    var name: String
    var taskDescription: String
    var attachments: [Attachment]
    var comments: [String]
    
    
    init(name: String, description: String, attachments: [Attachment], comments: [String]) {
        self.name = name
        self.taskDescription = description
        self.attachments = attachments
        self.comments = comments
    }
}

extension Task: NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData as String)]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        do {
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        return progress
    }
}

extension Task: NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] { return [(kUTTypeData) as String] }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        let decoder = JSONDecoder()
        do {
          let task = try decoder.decode(self, from: data)
          return task
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
