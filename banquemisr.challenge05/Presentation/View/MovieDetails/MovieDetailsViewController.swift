//
//  MovieDetailsViewController.swift
//  banquemisr.challenge05
//
//  Created by mac on 01/09/2024.
//

import UIKit
import Combine

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var isAdultMovieLbl: UILabel!
    @IBOutlet weak var popularityLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    let movieID: Int
    var viewModel : MovieDetailsViewModel?
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var refreshControl: UIRefreshControl = {
          let refreshControl = UIRefreshControl()
          return refreshControl
      }()
    
    
    init(movieID: Int) {
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieDetailsViewModel()
        setupUI()
        setupBinding()
        setupRefreshController()
        observeError()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func setupRefreshController(){
        refreshControl.tintColor = .black
        self.scrollView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)
    }
    
    @objc func refreshControlTriggered(){
        self.fetchData()
    }
    
    private func fetchData() {
        viewModel?.getMovieDetails(MovieID: self.movieID)
    }
    
    private func setupUI() {
        setupViews()
        setupLabels()
    }
    
    func setupBinding(){
        guard let viewModel = viewModel else {return}
        
        viewModel.movieSubject?
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movie in
                guard let self = self else { return }
                self.refreshControl.endRefreshing()
                self.setupData(movieDetails: movie)
            }
            .store(in: &cancellables)
    }
    
    private func observeError(){
        guard let viewModel = viewModel else {return}
        
        viewModel.errorSubject?
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else {return}
                self.refreshControl.endRefreshing()
                self.ShowAlertMessage(message: error)
            }
            .store(in: &cancellables)
    }
    
    private func setupViews() {
        posterImg.contentMode = .scaleAspectFill
        posterImg.layer.cornerRadius = 12
    }
    
    private func setupLabels() {
        self.titleLbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        self.titleLbl.numberOfLines = 0
        self.titleLbl.textAlignment = .center
        self.titleLbl.textColor = .black
        
        self.isAdultMovieLbl.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        self.isAdultMovieLbl.textColor = .orange
        
        self.popularityLbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.popularityLbl.textColor = .black
        
        self.releaseDateLbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.releaseDateLbl.textColor = .black
        
        
        self.descriptionLbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.descriptionLbl.numberOfLines = 0
        self.descriptionLbl.textColor = .black
    }
    
    private func setupData(movieDetails: Movie) {
        self.titleLbl.text = movieDetails.title ?? "Not Found"
        self.isAdultMovieLbl.text = (movieDetails.adult ?? false) ? "This Movie is not sutable for children" : "This Movie is sutable for children"
        self.popularityLbl.text = String(movieDetails.popularity ?? 0)
        self.releaseDateLbl.text = movieDetails.release_date ?? ""
        self.descriptionLbl.text = movieDetails.overview ?? ""
        
        posterImg.LoadFromUrl(url: movieDetails.backdrop_path ?? "")
    }
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
