//
//  FirebaseManager.swift
//  3x
//
//  Created by Jeevan Eashwar on 07/06/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import FirebaseAuth
class FirebaseManager {
    let shared: FirebaseManager
    private init() {
        shared = FirebaseManager()
    }
    static func signUpUser(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(nil, error)
            }
            else if let authResult = authResult {
                completion(authResult, nil)
            }
        }
    }
    static func authenticateUser(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
          if let error = error {
              completion(nil, error)
          }
          else if let authResult = authResult {
              completion(authResult, nil)
          }
        }
    }
}
