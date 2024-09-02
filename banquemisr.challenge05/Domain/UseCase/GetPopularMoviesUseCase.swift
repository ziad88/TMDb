//
//  GetPopularMoviesUseCase.swift
//  banquemisr.challenge05
//
//  Created by mac on 28/08/2024.
//

import Foundation

final class GetPopularMoviesUseCase {
    var moviesRepository: MoviesRepository
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    func invoke(success: @escaping ([Movie]) -> Void,
                fail: @escaping (String) -> Void){
        moviesRepository.getPopularMovies(success: {(movies) in
            success(movies)
        }, error: {(error) in
            fail(error)
        })
    }
}

