//
//  Webservice.swift
//  TMDBApp
//
//  Created by Cassu on 20/01/21.
//

import Foundation

class Webservice {
    
    func getGenre(completion: @escaping ([GenreObj]?) -> ()) {
        let url = URL(string: "\(APIProvider().baseURL())/3/genre/tv/list?language=\(APIProvider().languageDefault())")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(APIProvider().apiKey())", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                if let GenreList: Genres = data.toModel() {
                    completion(GenreList.genres)
                }else {
                    completion(nil)
                }
            }
        }.resume()
    }

    func getPopTvS(page: Int, completion: @escaping ([TvShowObj]?) -> ()) {
        let url = URL(string: "\(APIProvider().baseURL())/4/discover/tv?sort_by=popularity.desc&page=\(page)&language=\(APIProvider().languageDefault())")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(APIProvider().apiKey())", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                if let tvShowList: TvShow = data.toModel() {
                    completion(tvShowList.results)
                }else {
                    completion(nil)
                }
            }
        }.resume()
    }
    
}



