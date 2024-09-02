//
//  UpcomingMoviesViewController.swift
//  banquemisr.challenge05
//
//  Created by mac on 27/08/2024.
//

import UIKit
import Combine

class UpcomingMoviesViewController: UIViewController {

    //Outlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tblMovies: UITableView!
    
    //Properties
    private lazy var refreshControl: UIRefreshControl = {
          let refreshControl = UIRefreshControl()
          return refreshControl
      }()
    var viewModel : UpcomingMoviesViewModel?
    private var contentSizeObservation: NSKeyValueObservation?
    
    var arrFetchedMovies : [Movie] = [Movie]()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UpcomingMoviesViewModel()
        setupHeaderView()
        setupTableview()
        
        setupRefreshController()
        observeTableView()
        observeError()
        
        contentSizeObservation = tblMovies.observe(\.contentSize, options: .new, changeHandler: { [weak self] (tv, _) in
            guard let self = self else { return }
            let height = tv.contentSize.height
            self.tableHeightConstraint.constant = height
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData(isRefresh: false)
    }
    
    @objc
    func updateScreen() {
        fetchData(isRefresh: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        contentSizeObservation?.invalidate()
    }
    
    
    func setupRefreshController(){
        refreshControl.tintColor = .black
        self.scrollView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)
    }
    
    private func setupHeaderView() {
        headerView.createCustomHeaderBar(title: "Upcoming Movies")
    }
    
    @objc func refreshControlTriggered(){
        self.fetchData(isRefresh: true)
    }
    
   @objc
    private func fetchData(isRefresh: Bool) {
        viewModel?.getUpcomingMovies(isRefreshController: isRefresh)
    }
    
    func observeTableView(){
        guard let viewModel = viewModel else {return}
        
        viewModel.moviesSubject?
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self = self else { return }
                self.arrFetchedMovies = movies
                self.tblMovies.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.isRefreshing?
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                if value{
                    self.refreshControl.endRefreshing()
                }
            }
            .store(in: &cancellables)
    }

    private func observeError(){
        guard let viewModel = viewModel else {return}
        
        viewModel.errorSubject?
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else {return}
                self.ShowAlertMessage(message: error)
            }
            .store(in: &cancellables)
    }

}


extension UpcomingMoviesViewController {
    func setupTableview(){
        tblMovies.registerCell(MovieTableViewCell.self)
        tblMovies.delegate = self
        tblMovies.dataSource = self
        tblMovies.separatorStyle = .none
        tblMovies.contentInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tblMovies.showsVerticalScrollIndicator = false
    }
}

extension UpcomingMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrFetchedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell  else { return UITableViewCell() }
        cell.setupData(movie: arrFetchedMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = arrFetchedMovies[indexPath.row].id ?? -1
        let VC = MovieDetailsViewController(movieID: selectedItem)
        present(VC, animated: true)
    }
}
