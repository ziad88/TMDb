//
//  GetPopularMoviesUseCaseTest.swift
//  banquemisr.challenge05Tests
//
//  Created by mac on 02/09/2024.
//

import XCTest
@testable import banquemisr_challenge05

final class GetPopularMoviesUseCaseTest: XCTestCase {

    private let moviesRepository = FakeMoviesRepositoryImpl()
    private var result: Bool = true
    
    func test_GetPopularMoviesUseCase_andError() {
        // Given
        moviesRepository.shouldReturnError = true
        var getPopularMoviesUseCase = GetPopularMoviesUseCase(moviesRepository: moviesRepository)
                
        // When
        getPopularMoviesUseCase.invoke(success: {[weak self] (movies) in
            guard let self = self else {return}
            result = true
        }, fail: {[weak self] (error) in
            guard let self = self else {return}
            result = false
        })
        
        // Then
        XCTAssertFalse(result)
    }
    
    func test_GetPopularMoviesUseCase_andSuccess() {
        // Given
        var getPopularMoviesUseCase = GetPopularMoviesUseCase(moviesRepository: moviesRepository)
                
        // When
        getPopularMoviesUseCase.invoke(success: {[weak self] (movies) in
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
