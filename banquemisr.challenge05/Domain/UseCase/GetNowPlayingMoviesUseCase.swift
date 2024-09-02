//
//  GetNowPlayingMoviesUseCase.swift
//  banquemisr.challenge05
//
//  Created by mac on 28/08/2024.
//

import Foundation

final class GetNowPlayingMoviesUseCase {
    var moviesRepository: MoviesRepository
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    func invoke(success: @escaping ([Movie]) -> Void,
                fail: @escaping (String) -> Void){
        moviesRepository.getNowPlayingMovies(success: {(movies) in
            success(movies)
        }, error: {(error) in
            fail(error)
        })
    }
}


