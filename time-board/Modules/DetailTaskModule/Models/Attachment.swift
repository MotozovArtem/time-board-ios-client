//
//  Attachment.swift
//  time-board
//
//  Created by Tianid on 07.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

enum AttachmentFileType: String, Codable {
    case jpeg = "jpeg"
    case jpg = "jpg"
    case gif = "gif"
    case png = "png"
    case heic = "HEIC"
    case notImage
}

class Attachment: Codable {
    //MARK: - Properties
    
    var attachmentURL: String
    var file: File?
    
    //MARK: - Init
    
    init(attachmentURL: String, file: File? = nil) {
        self.attachmentURL = attachmentURL
        self.file = file
    }
    //MARK: - Func
    
    func getFileSizeInString() -> String? {
        guard let file = file else { return nil }
        guard let fileData = file.fileData else { return nil }
        let byteFormatter = ByteCountFormatter()
        byteFormatter.allowedUnits = [.useAll]
        byteFormatter.countStyle = .file
        let string = byteFormatter.string(fromByteCount: Int64(fileData.count))
        return string
    }
}

struct File: Codable {
    var fileData: Data?
    var fileType: AttachmentFileType?
    
    //MARK: - This init for test data
    init(withImage image: UIImage) {
        fileData = image.jpegData(compressionQuality: 0.0)
    }
    
    init(data: Data, fileType: AttachmentFileType) {
        self.fileData = data
        self.fileType = fileType
    }
}
