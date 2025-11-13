//
//  FirebaseViewModel.swift
//  FirebaseGuide
//
//  Created by Alec Hance on 1/27/25.
//

import Foundation
import FirebaseFirestore

class FirebaseViewModel: ObservableObject {
    let db = Firestore.firestore()
    var onSetupCompleted: ((FirebaseViewModel) -> Void)?
    
    static let vm = FirebaseViewModel()
    func configure() {
        self.onSetupCompleted?(self)
    }
    
    func readFromAlec() async -> Int {
        // create a read function
    }
    
    func writeToBuzz(data: Int) async -> Bool {
        // create a write function
    }
}
