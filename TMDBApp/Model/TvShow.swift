//
//  TvShow.swift
//  TMDBApp
//
//  Created by Cassu on 21/01/21.
//

import Foundation

struct TvShow: Codable {
    
    var success: Bool?
    var status_message: String?
    var status_code: Int?
    var results: [TvShowObj]
    var page: Int?
    var total_pages: Int?
    var total_results: Int?
   
}

struct TvShowObj: Codable {
    
    var genre_ids: [Int]?
    var adult: Bool?
    var backdrop_path: String?
    var id: Int?
    var original_name: String?
    var name: String?
    var vote_average: Double?
    var vote_count: Int?
    var popularity: Double?
    var poster_path: String?
    var overview: String?
    var release_date: String?
    var video: Bool?
    
}
