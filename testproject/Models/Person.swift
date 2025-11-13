import SwiftUI
import Foundation
import FirebaseFirestore

struct Person: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var locationMet: String
    var major: String
    var dateMet: String
    var insta: String
    var tags: [String]
    var description: String
    var photoURL: String? // URL of image in Firebase Storage
    
    // Local-only property, not stored in Firestore
    var imageData: Data? = nil
    
    // Coding keys to exclude imageData from Firestore
    enum CodingKeys: String, CodingKey {
        case id, name, locationMet, major, dateMet, insta, tags, description, photoURL
    }
    
    init(
        id: String? = nil,
        name: String = "No Name",
        locationMet: String = "",
        major: String = "",
        dateMet: String = "01/01/2025",
        insta: String = "",
        tags: [String] = [],
        description: String = "",
        photoURL: String? = nil,
        imageData: Data? = nil
    ) {
        self.id = id
        self.name = name.isEmpty ? "No Name" : name
        self.locationMet = locationMet
        self.major = major
        self.dateMet = dateMet
        self.insta = insta
        self.tags = tags
        self.description = description.isEmpty ? "No Description" : description
        self.photoURL = photoURL
        self.imageData = imageData
    }
}
