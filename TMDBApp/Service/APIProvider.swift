//
//  APIProvider.swift
//  EVGrupoHinode
//
//  Created by Cassu on 09/12/20.
//

import Foundation


class APIProvider {
    
    //MARK: - Constants
    private let kBaseURL = "https://api.themoviedb.org"
    
    private let kApikey = ""
    
    private let kLanguage = "pt-BR"

    
    //MARK: - Public Methods
    public func baseURL() -> String {
        return kBaseURL
    }
    
    public func apiKey() -> String {
        if kApikey.isEmpty{
            fatalError("Need Api Key")
        }
        return kApikey
    }
    
    public func languageDefault() -> String {
        return kLanguage
    }
 
    
    //MARK: - Singleton
    static let shared = APIProvider()

}
