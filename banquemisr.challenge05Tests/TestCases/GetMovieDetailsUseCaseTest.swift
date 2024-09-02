//
//  GetMovieDetailsUseCaseTest.swift
//  banquemisr.challenge05Tests
//
//  Created by mac on 02/09/2024.
//

import XCTest
@testable import banquemisr_challenge05

final class GetMovieDetailsUseCaseTest: XCTestCase {

    private let moviesRepository = FakeMoviesRepositoryImpl()
    private var result: Bool = true
    
    func test_GetMovieDetailsUseCase_andError() {
        // Given
        moviesRepository.shouldReturnError = true
        var getMovieDetailsUseCase = GetMovieDetailsUseCase(moviesRepository: moviesRepository)
                
        // When
        getMovieDetailsUseCase.invoke(movieID: -1, success: {[weak self] (movie) in
            guard let self = self else {return}
            result = true
        }, fail: {[weak self] (error) in
            guard let self = self else {return}
            result = false
        })
        
        // Then
        XCTAssertFalse(result)
    }
    
    func test_GetMovieDetailsUseCase_andSuccess() {
        // Given
        var getMovieDetailsUseCase = GetMovieDetailsUseCase(moviesRepository: moviesRepository)
                
        // When
        getMovieDetailsUseCase.invoke(movieID: -1, success: {[weak self] (movie) in
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
