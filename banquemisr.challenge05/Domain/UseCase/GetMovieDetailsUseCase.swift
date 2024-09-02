//
//  GetMovieDetailsUseCase.swift
//  banquemisr.challenge05
//
//  Created by mac on 02/09/2024.
//

import Foundation

final class GetMovieDetailsUseCase {
    var moviesRepository: MoviesRepository
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    func invoke(movieID: Int,
                success: @escaping (Movie) -> Void,
                fail: @escaping (String) -> Void){
        moviesRepository.getMovieDetails(movieID: movieID, success: {(movie) in
            success(movie)
        }, error: {(error) in
            fail(error)
        })
    }
}

