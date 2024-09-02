//
//  MoviesRepository.swift
//  banquemisr.challenge05
//
//  Created by mac on 28/08/2024.
//

import Foundation

protocol MoviesRepository {
    func getNowPlayingMovies(
        success: @escaping ([Movie]) -> Void,
        error: @escaping (String) -> Void
    )
    
    func getPopularMovies(
        success: @escaping ([Movie]) -> Void,
        error: @escaping (String) -> Void
    )
    
    func getUpcomingMovies(
        success: @escaping ([Movie]) -> Void,
        error: @escaping (String) -> Void
    )
    
    func getMovieDetails(movieID: Int,
                         success: @escaping (Movie) -> Void,
                         error: @escaping (String) -> Void
    )
}


