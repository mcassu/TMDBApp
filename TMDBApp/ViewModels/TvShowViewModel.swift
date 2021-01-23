//
//  TvShowViewModel.swift
//  TMDBApp
//
//  Created by Cassu on 21/01/21.
//
import Foundation
import UIKit

struct TvShowListViewModel {
    
    private var tvShows: [TvShowObj]
    
    init(TvShows: [TvShowObj]) {
        self.tvShows = TvShows
    }
}

extension TvShowListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    mutating func numberOfItemsInSection(_ section: Int) -> Int {
        return tvShows.count
    }
    
    mutating func newAtIndex(_ index: Int) -> TvShowViewModel {
        let new = tvShows[index]
        return TvShowViewModel(new)
    }
    
    mutating func appendItens(_ tvShowAppends: [TvShowObj], completion: @escaping () -> ()){
        for i in tvShowAppends {
            tvShows.append(i)
        }
        completion()
    }
    
    func count() -> Int{
       return tvShows.count
    }
    
   
}

struct TvShowViewModel {
    private let tvShow: TvShowObj
    
    init(_ TVShow: TvShowObj) {
        self.tvShow = TVShow
    }
}

extension TvShowViewModel {
    func toCRUD() -> TvShowObj {
        return tvShow
    }
}

extension TvShowViewModel {
    
    var _id: Int {
        return self.tvShow.id ?? 0
    }
    
    var title: String {
        return self.tvShow.original_name ?? ""
    }
    
    var overview: String {
        return self.tvShow.overview ?? ""
    }
    
    var totalVote: String {
        guard let voteC = tvShow.vote_count else {
            return "0"
        }
        return "Total de avaliação(ões): \(voteC)"
    }
    
    var avaregeVote: String {
        guard let voteA = tvShow.vote_average else {
            return "0.0"
        }
        return "Avaliação: \(String(format: "%2.f", voteA))/10"
    }
    
    var genderIds: String {
        var genders = ""
        
        guard let genders_ids = self.tvShow.genre_ids else {
            return ""
        }
       
        guard let genreList = CRUD().ReadGenre() else {
            for i in genders_ids {
                genders += "\(i), "
            }
            let t = genders.dropLast()
            return String(t.dropLast())
        }
        
        for i in genders_ids {
            if let foo = genreList.first(where: {$0.id == i}) {
                genders += "\(foo.name ?? ""), "
            } else {
                genders += "\(i), "
            }
        }
        
        let t = genders.dropLast()
        return String(t.dropLast())
    }
    
    var date: String{
        var resultDateFormat = ""
        
        let dateFormatterStart = DateFormatter()
        dateFormatterStart.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.dateFormat = "dd MMM yyyy"
        
        if let date = dateFormatterStart.date(from: self.tvShow.release_date ?? "") {
            resultDateFormat = "\(dateFormatterResult.string(from: date))"
        } else {
            resultDateFormat = "Data inválida"
        }
        return resultDateFormat
    }
    
    var urlToPosterImage: URL? {
        guard let urlString = self.tvShow.poster_path else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/w500\(urlString)")
    }
    
    var urlToBannerImage: URL? {
        guard let urlString = self.tvShow.backdrop_path else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/w500\(urlString)")
    }
}
