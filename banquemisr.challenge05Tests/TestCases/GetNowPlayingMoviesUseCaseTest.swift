//
//  GetNowPlayingMoviesUseCaseTest.swift
//  banquemisr.challenge05Tests
//
//  Created by mac on 02/09/2024.
//

import XCTest
@testable import banquemisr_challenge05

final class GetNowPlayingMoviesUseCaseTest: XCTestCase {

    private let moviesRepository = FakeMoviesRepositoryImpl()
    private var result: Bool = true
    
    func test_GetNowPlayingMoviesUseCase_andError() {
        // Given
        moviesRepository.shouldReturnError = true
        var getNowPlayingMoviesUseCase = GetNowPlayingMoviesUseCase(moviesRepository: moviesRepository)
                
        // When
        getNowPlayingMoviesUseCase.invoke(success: {[weak self] (movies) in
            guard let self = self else {return}
            result = true
        }, fail: {[weak self] (error) in
            guard let self = self else {return}
            result = false
        })
        
        // Then
        XCTAssertFalse(result)
    }
    
    func test_GetNowPlayingMoviesUseCase_andSuccess() {
        // Given
        var getNowPlayingMoviesUseCase = GetNowPlayingMoviesUseCase(moviesRepository: moviesRepository)
                
        // When
        getNowPlayingMoviesUseCase.invoke(success: {[weak self] (movies) in
            guard let self = self else {return}
            result = true
        }, fail: {[weak self] (error) in
            guard let self = self else {return}
            result = false
        })
        
        // Then
        XCTAssertTrue(result)
    }
}
