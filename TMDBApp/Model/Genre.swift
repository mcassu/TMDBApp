//
//  Gender.swift
//  TMDBApp
//
//  Created by Cassu on 22/01/21.
//

import Foundation

struct Genres: Codable {
    var genres: [GenreObj]?
}

struct GenreObj: Codable {
    var id: Int?
    var name: String?
}
