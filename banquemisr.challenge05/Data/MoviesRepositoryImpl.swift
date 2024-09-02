//
//  MoviesRepositoryImpl.swift
//  banquemisr.challenge05
//
//  Created by mac on 28/08/2024.
//

import Foundation

class MoviesRepositoryImpl: MoviesRepository{
         
    func getNowPlayingMovies(success: @escaping ([Movie]) -> Void,
                             error: @escaping (String) -> Void) {
        var arr : [Movie] = [Movie]()
        WebServiceClass.getRequset(urlString: "https://api.themoviedb.org/3/movie/now_playing",
                                   parameters: [:]) { responceData in
            
            if responceData.isSuccess {
                guard let response = responceData.data as? [String : Any] else { return}
                guard let data = response["results"] as? [[String : Any]] else { return}
                for dict in data {
                    let obj : Movie = getObjectViaCodable(dict: dict) ?? Movie.init()
                    arr.append(obj)
                }
                success(arr)
            } else {
                error( responceData.error?.localizedDescription ?? "")
            }
        }
    }
    
    func getPopularMovies(success: @escaping ([Movie]) -> Void,
                          error: @escaping (String) -> Void) {
        var arr : [Movie] = [Movie]()
        WebServiceClass.getRequset(urlString: "https://api.themoviedb.org/3/movie/popular",
                                   parameters: [:]) { responceData in
            
            if responceData.isSuccess {
                guard let response = responceData.data as? [String : Any] else { return}
                guard let data = response["results"] as? [[String : Any]] else { return}
                for dict in data {
                    let obj : Movie = getObjectViaCodable(dict: dict) ?? Movie.init()
                    arr.append(obj)
                }
                success(arr)
            } else {
                error( responceData.error?.localizedDescription ?? "")
            }
        }
    }
    
    func getUpcomingMovies(success: @escaping ([Movie]) -> Void,
                           error: @escaping (String) -> Void) {
        var arr : [Movie] = [Movie]()
        WebServiceClass.getRequset(urlString: "https://api.themoviedb.org/3/movie/upcoming",
                                   parameters: [:]) { responceData in
            
            if responceData.isSuccess {
                guard let response = responceData.data as? [String : Any] else { return}
                guard let data = response["results"] as? [[String : Any]] else { return}
                for dict in data {
                    let obj : Movie = getObjectViaCodable(dict: dict) ?? Movie.init()
                    arr.append(obj)
                }
                success(arr)
            } else {
                error( responceData.error?.localizedDescription ?? "")
            }
        }
    }
    
    func getMovieDetails(movieID: Int,
                         success: @escaping (Movie) -> Void,
                         error: @escaping (String) -> Void) {
        WebServiceClass.getRequset(urlString: "https://api.themoviedb.org/3/movie/\(movieID)",
                                   parameters: [:]) { responceData in
            
            if responceData.isSuccess {
                if let movie : Movie = getObjectViaCodable(dict: responceData.data as! [String : Any]){
                    success(movie)
                }
            } else {
                error( responceData.error?.localizedDescription ?? "")
            }
        }
    }
}
