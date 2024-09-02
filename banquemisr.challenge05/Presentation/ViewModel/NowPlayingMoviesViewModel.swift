//
//  NowPlayingMoviesViewModel.swift
//  banquemisr.challenge05
//
//  Created by mac on 28/08/2024.
//

import Foundation
import Combine

class NowPlayingMoviesViewModel{
    
    private var getNowPlayingMoviesUseCase: GetNowPlayingMoviesUseCase
    var arrMovies : [Movie] = [Movie]()
    
    var errorSubject : PassthroughSubject<String, Never>?
    var isRefreshing : PassthroughSubject<Bool, Never>?
    var moviesSubject : PassthroughSubject<[Movie], Never>?
    
    init() {
        getNowPlayingMoviesUseCase = GetNowPlayingMoviesUseCase(moviesRepository: MoviesRepositoryImpl())
        errorSubject = PassthroughSubject()
        isRefreshing = PassthroughSubject()
        moviesSubject = PassthroughSubject()
    }
    
    func getNowPlayingMovies(isRefreshController : Bool){
        getNowPlayingMoviesUseCase.invoke(success: {[weak self] (movies) in
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
    
    func getMoreNowPlayingMovies(){
        getNowPlayingMoviesUseCase.invoke(success: {[weak self] (movies) in
            guard let self = self else {return}
            self.moviesSubject?.send(movies)
            self.arrMovies.append(contentsOf: movies)
        }, fail: {[weak self] (error) in
            guard let self = self else {return}
            self.errorSubject?.send(error)
        })
    }
}
