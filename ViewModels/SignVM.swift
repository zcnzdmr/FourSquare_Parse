//
//  SignVM.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 31.05.2024.
//

import Foundation


class SignVM {
    
    var repoNesnesi = Repo()
    
    func signUpFonk(email:String,password:String) {
        repoNesnesi.signUpFonk(email: email, password: password)
    }
    
    func signInFonk(email:String,password:String) {
        repoNesnesi.signInFonk(email: email, password: password)
    }
}
