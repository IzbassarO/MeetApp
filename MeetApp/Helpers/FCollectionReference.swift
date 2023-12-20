//
//  FCollectionReference.swift
//  MeetApp
//
//  Created by Izbassar on 19.12.2023.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Category
    case Items
//    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
