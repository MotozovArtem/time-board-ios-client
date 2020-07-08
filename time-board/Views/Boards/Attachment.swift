//
//  Attachment.swift
//  time-board
//
//  Created by Tianid on 07.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class Attachment: Codable {
    var attachmentURL: String
    var image: Image?
    
    init(attachmentURL: String, image: Image? = nil) {
        self.attachmentURL = attachmentURL
        self.image = image
    }
}

struct Image: Codable {
    var imageData: Data?
    
    //MARK: - This init for test data
    init(withImage image: UIImage) {
        imageData = image.jpegData(compressionQuality: 0.0)
    }
    
    init(withImage image: Data) {
        self.imageData = image
    }
    
    func getImageData() -> NSData? {
        guard let imageData = self.imageData else { return nil }
        return imageData as NSData
    }
}
