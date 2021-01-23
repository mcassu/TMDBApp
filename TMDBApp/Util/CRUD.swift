//
//  Favorite.swift
//  TMDBApp
//
//  Created by Cassu on 22/01/21.
//

import Foundation
import UIKit

class CRUD {
    
    private let kLIST_FAV = "kLIST_TVSHOW_FAV"
    
    private func Creat(tvShow: TvShowObj){
        var tvShowList = [TvShowObj]()
        tvShowList.append(tvShow)
        encodeSave(tvShowList)
    }
    
    func Read() -> [TvShowObj]? {
        
        let listFavTMDB = UserDefaults.standard.data(forKey: kLIST_FAV)
        
        guard let data = listFavTMDB else  {
            return nil
        }
        
        if let tvShowList: [TvShowObj] = data.toModel(){
            if tvShowList.count > 0 {
                return tvShowList
            }else{
                return nil
            }
        }else {
            return nil
        }
    
    }
    
    func Update(tvShow: TvShowObj) -> UIColor {
        
        let listFavTMDB = UserDefaults.standard.data(forKey: kLIST_FAV)
        var color = UIColor.white
        
        guard let data = listFavTMDB else  {
            Creat(tvShow: tvShow)
            return .darkGray
        }
             
        if Verify(id: tvShow.id).0 {
                Delete(id: tvShow.id ?? 0, data: data)
                color = .white
            
        }else {
            if var tvShowList: [TvShowObj] = data.toModel() {
                tvShowList.append(tvShow)
                encodeSave(tvShowList)
                color = .darkGray
            }
        }
        return color
    }
    
    private func Delete(id: Int, data: Data){
        if Verify(id: id).0 {
            if var tvShowList: [TvShowObj] = data.toModel() {
                guard let offset = Verify(id: id).1 else {
                    return
                }
                tvShowList.remove(at: offset)
                encodeSave(tvShowList)
            }
        }
    }
    
    func Verify(id: Int? = 0) -> (Bool, Int?) {
        
        let listFavTMDB = UserDefaults.standard.data(forKey: kLIST_FAV)
        var retorno = (false, 0)
        
        if let tvShowList: [TvShowObj] = listFavTMDB?.toModel() {
            if let fooOffset = tvShowList.firstIndex(where: {$0.id == id}){
                retorno = (true, fooOffset)
            } else {
                retorno = (false, 0)
            }
        }
        return retorno
    }
}
extension CRUD {
    
    private func encodeSave(_ array: [TvShowObj]){
        let jsonData = try! JSONEncoder().encode(array)
        UserDefaults.standard.set(jsonData, forKey: kLIST_FAV)
    }
    
    func ReadGenre() -> [GenreObj]? {
        let kLIST_GENRE = "kLIST_GENRE"
        let listGenreTMDB = UserDefaults.standard.data(forKey: kLIST_GENRE)
        
        guard let data = listGenreTMDB else  {
            return nil
        }
        
        if let genreList: [GenreObj] = data.toModel(){
            if genreList.count > 0 {
                return genreList
            }else{
                return nil
            }
        }else {
            return nil
        }
    
    }
}
