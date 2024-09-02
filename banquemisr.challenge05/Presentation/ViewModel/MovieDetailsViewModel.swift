//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by mac on 02/09/2024.
//

import Foundation
import Combine

class MovieDetailsViewModel{
    
    private var getMovieDetailsUseCase: GetMovieDetailsUseCase
    
    var errorSubject : PassthroughSubject<String, Never>?
    var movieSubject : PassthroughSubject<Movie, Never>?
    
    init() {
        getMovieDetailsUseCase = GetMovieDetailsUseCase(moviesRepository: MoviesRepositoryImpl())
        errorSubject = PassthroughSubject()
        movieSubject = PassthroughSubject()
    }
    
    func getMovieDetails(MovieID: Int){
        getMovieDetailsUseCase.invoke(movieID: MovieID, success: {[weak self] (movie) in
            guard let self = self else {return}
            self.movieSubject?.send(movie)
        }, fail: {[weak self] (error) in
            guard let self = self else {return}
            self.errorSubject?.send(error)
        })
    }
}
