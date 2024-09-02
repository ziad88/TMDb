//
//  MovieTableViewCell.swift
//  banquemisr.challenge05
//
//  Created by mac on 31/08/2024.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var imgContainer: UIView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }
    
    private func setupCellUI() {
        setupLabels()
        setupViews()
    }
    
    private func setupViews() {
        self.selectionStyle = .none
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.layer.cornerRadius = 12
    }
    
    private func setupLabels() {
        movieTitleLbl.numberOfLines = 0
        movieTitleLbl.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        movieTitleLbl.textColor = .black
        
        movieDateLbl.numberOfLines = 0
        movieDateLbl.font = UIFont.systemFont(ofSize: 10, weight: .light)
        movieDateLbl.textColor = .gray
    }
    
    
    func setupData(movie: Movie) {
        movieImageView.LoadFromUrl(url: movie.poster_path ?? "")
        movieTitleLbl.text = movie.title ?? ""
        movieDateLbl.text = movie.release_date ?? ""
    }
}
