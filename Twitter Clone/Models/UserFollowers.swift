//
//  UserFollowers.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 31/08/22.
//

import FirebaseFirestoreSwift
import Firebase

struct UserFollowers: Identifiable, Decodable {
    @DocumentID var id: String?
    let userID: String
    let followerID: String
    
    var user: User?
    var follower: User?
    
}
