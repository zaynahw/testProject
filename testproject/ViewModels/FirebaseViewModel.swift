import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import UIKit
import Combine

@MainActor
class FirebaseViewModel: ObservableObject {
    static let shared = FirebaseViewModel()
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    @Published var people: [Person] = []
    
    var currentUserID: String = "zaynah"  // ✅ your Firestore document name
    
    // MARK: - Add Person
    func addPerson(person: Person, image: UIImage?) async {
        let userID = currentUserID
        let personID = UUID().uuidString
        var personToUpload = person
        
        do {
            // Upload photo if available
            if let image = image, let imageData = image.jpegData(compressionQuality: 0.8) {
                let storageRef = storage.reference().child("FRIENDS/\(userID)/\(personID).jpg")
                let _ = try await storageRef.putDataAsync(imageData)
                let url = try await storageRef.downloadURL()
                personToUpload.photoURL = url.absoluteString
            }
            
            personToUpload.id = nil
            
            // Save person data in Firestore
            try db.collection("USER")
                .document(userID)
                .collection("FRIENDS")
                .document(personID)
                .setData(from: personToUpload)
            
            // Add locally
            people.append(personToUpload)
            print("✅ Added \(personToUpload.name) to USER/\(userID)/FRIENDS")
            
        } catch {
            print("Error adding person:", error.localizedDescription)
        }
    }
    
    // MARK: - Fetch People
    func fetchPeople() async {
        let userID = currentUserID
        
        do {
            print("🔍 Fetching from USER/\(userID)/FRIENDS")
            
            let snapshot = try await db.collection("USER")
                .document(userID)
                .collection("FRIENDS")
                .getDocuments()
            
            print("📄 Found \(snapshot.documents.count) documents")
            
            var successfullyLoaded: [Person] = []
            
            for document in snapshot.documents {
                print("📝 Document ID: \(document.documentID)")
                print("📊 Document data: \(document.data())")
                
                do {
                    let person = try document.data(as: Person.self)
                    successfullyLoaded.append(person)
                    print("✅ Successfully decoded: \(person.name)")
                } catch {
                    print("❌ Failed to decode document \(document.documentID): \(error)")
                }
            }
            
            self.people = successfullyLoaded
            print("✅ Final result: \(successfullyLoaded.count) people loaded")
            
        } catch {
            print("❌ Error fetching people:", error.localizedDescription)
        }
    }
}
