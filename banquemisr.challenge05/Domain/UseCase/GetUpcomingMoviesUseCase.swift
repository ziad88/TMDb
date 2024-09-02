//
//  GetUpcomingMoviesUseCase.swift
//  banquemisr.challenge05
//
//  Created by mac on 28/08/2024.
//

import Foundation

final class GetUpcomingMoviesUseCase {
    var moviesRepository: MoviesRepository
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    func invoke(success: @escaping ([Movie]) -> Void,
                fail: @escaping (String) -> Void){
        moviesRepository.getUpcomingMovies(success: {(movies) in
            success(movies)
        }, error: {(error) in
            fail(error)
        })
    }
}
