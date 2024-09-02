//
//  MovieModel.swift
//  banquemisr.challenge05
//
//  Created by mac on 28/08/2024.
//

import Foundation

class Movie : NSObject,Codable {
    
    var id: Int?
    var adult : Bool?
    var backdrop_path: String?
    var title: String?
    var overview: String?
    var poster_path: String?
    var release_date: String?
    var popularity: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, adult, backdrop_path, title, overview, poster_path, release_date, popularity
    }
}
