//
//  UIImageView+LoadURL.swift
//  banquemisr.challenge05
//
//  Created by mac on 31/08/2024.
//

import UIKit

extension UIImageView {
    
    func LoadFromUrl(url: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500"+url) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data,response ,error in
            
            guard let data = data else {return}
            
            if let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = img
                }
            }
        }.resume()
    }
}

