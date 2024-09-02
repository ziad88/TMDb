//
//  PopularMoviesViewModel.swift
//  banquemisr.challenge05
//
//  Created by mac on 31/08/2024.
//

import Foundation
import Combine

class PopularMoviesViewModel{
    
    private var getPopularMoviesUseCase: GetPopularMoviesUseCase
    var arrMovies : [Movie] = [Movie]()
    
    var errorSubject : PassthroughSubject<String, Never>?
    var isRefreshing : PassthroughSubject<Bool, Never>?
    var moviesSubject : PassthroughSubject<[Movie], Never>?
    
    init() {
        getPopularMoviesUseCase = GetPopularMoviesUseCase(moviesRepository: MoviesRepositoryImpl())
        errorSubject = PassthroughSubject()
        isRefreshing = PassthroughSubject()
        moviesSubject = PassthroughSubject()
    }
    
    func getPopularMovies(isRefreshController : Bool){
        getPopularMoviesUseCase.invoke(success: {[weak self] (movies) in
            guard let self = self else {return}
            self.moviesSubject?.send(movies)
            self.arrMovies = movies
            if !isRefreshController{
                self.isRefreshing?.send(true)
            }
        }, fail: {[weak self] (error) in
            guard let self = self else {return}
            if !isRefreshController{
                self.isRefreshing?.send(true)
            }
            self.errorSubject?.send(error)
        })
    }
    
    func getMorePopularMovies(){
        getPopularMoviesUseCase.invoke(success: {[weak self] (movies) in
            guard let self = self else {return}
            self.moviesSubject?.send(movies)
            self.arrMovies.append(contentsOf: movies)
        }, fail: {[weak self] (error) in
            guard let self = self else {return}
            self.errorSubject?.send(error)
        })
    }
}
