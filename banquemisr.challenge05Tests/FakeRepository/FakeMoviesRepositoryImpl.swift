//
//  FakeMoviesRepositoryImpl.swift
//  banquemisr.challenge05Tests
//
//  Created by mac on 02/09/2024.
//

@testable import banquemisr_challenge05

class FakeMoviesRepositoryImpl: MoviesRepository{
         
    var shouldReturnError: Bool = false
    var movies: [Movie] = [Movie.init()]
    var movie: Movie = Movie.init()
    
    func getNowPlayingMovies(success: @escaping ([Movie]) -> Void,
                             error: @escaping (String) -> Void) {
        if (shouldReturnError) {
            error("")
        } else {
            success(movies)
        }
    }
    
    func getPopularMovies(success: @escaping ([Movie]) -> Void,
                          error: @escaping (String) -> Void) {
        if (shouldReturnError) {
            error("")
        } else {
            success(movies)
        }
    }
    
    func getUpcomingMovies(success: @escaping ([Movie]) -> Void,
                           error: @escaping (String) -> Void) {
        if (shouldReturnError) {
            error("")
        } else {
            success(movies)
        }
    }
    
    func getMovieDetails(movieID: Int,
                         success: @escaping (Movie) -> Void,
                         error: @escaping (String) -> Void) {
        if (shouldReturnError) {
            error("")
        } else {
            success(movie)
        }
    }
}
