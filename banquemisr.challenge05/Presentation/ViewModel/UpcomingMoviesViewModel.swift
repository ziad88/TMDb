//
//  UpcomingMoviesViewModel.swift
//  banquemisr.challenge05
//
//  Created by mac on 31/08/2024.
//

import Foundation
import Combine

class UpcomingMoviesViewModel{
    
    private var getUpcomingMoviesUseCase: GetUpcomingMoviesUseCase
    var arrMovies : [Movie] = [Movie]()
    
    var errorSubject : PassthroughSubject<String, Never>?
    var isRefreshing : PassthroughSubject<Bool, Never>?
    var moviesSubject : PassthroughSubject<[Movie], Never>?
    
    init() {
        getUpcomingMoviesUseCase = GetUpcomingMoviesUseCase(moviesRepository: MoviesRepositoryImpl())
        errorSubject = PassthroughSubject()
        isRefreshing = PassthroughSubject()
        moviesSubject = PassthroughSubject()
    }
    
    func getUpcomingMovies(isRefreshController : Bool){
        getUpcomingMoviesUseCase.invoke(success: {[weak self] (movies) in
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
    
    func getMoreUpcomingMovies(){
        getUpcomingMoviesUseCase.invoke(success: {[weak self] (movies) in
            guard let self = self else {return}
            self.moviesSubject?.send(movies)
            self.arrMovies.append(contentsOf: movies)
        }, fail: {[weak self] (error) in
            guard let self = self else {return}
            self.errorSubject?.send(error)
        })
    }
}
