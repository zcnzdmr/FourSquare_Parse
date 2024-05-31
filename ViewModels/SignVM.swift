//
//  SignVM.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 31.05.2024.
//

import Foundation


class SignVM {
    
    var repoNesnesi = Repo()
    
    func signUpFonk(username:String,email:String) {
        repoNesnesi.signUpFonk(username: username, email: email)
    }
}
