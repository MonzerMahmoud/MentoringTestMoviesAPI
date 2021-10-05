//
//  ViewController+UIExtension.swift
//  MentoringTestMoviesAPI
//
//  Created by Syber Expertise on 03/10/2021.
//

import UIKit

extension ViewController {
    
    func configureUI() {
        
        view.backgroundColor = UIColor(red: 8/256, green: 146/256, blue: 165/256, alpha: 1)
        initViews()
        anchorViews()
    }
    
    func initViews() {
        
        searchTextLabel = {
           let label = UILabel()
            label.text = "Search for your favorite movie"
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        searchBarView = UISearchBar()
        searchBarView.searchBarStyle = .minimal
        searchBarView.placeholder = " Search for your movie ..."
        searchBarView.sizeToFit()
        searchBarView.isTranslucent = true
        searchBarView.delegate = self
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        
        moviesTableView = UITableView(frame: .zero)
        moviesTableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: "cell")
        moviesTableView.backgroundColor = .clear
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.separatorStyle = .none
        moviesTableView.allowsSelection = false
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func anchorViews() {
        
        view.addSubview(searchTextLabel)
        searchTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        
        view.addSubview(searchBarView)
        searchBarView.topAnchor.constraint(equalTo: searchTextLabel.bottomAnchor, constant: 10).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: searchTextLabel.leadingAnchor).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: searchTextLabel.trailingAnchor).isActive = true
        
        view.addSubview(moviesTableView)
        moviesTableView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 20).isActive = true
        moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchActive {
            return filterdMovieList.count
        } else {
            return moviesList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoviesTableViewCell
        if searchActive {
            cell.movieName.text = filterdMovieList[indexPath.section].title
        } else {
            cell.movieName.text = moviesList[indexPath.section].title
        }
        
        return cell
        
    }
}

extension ViewController: UISearchBarDelegate{
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
               searchActive = true
        }
           
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
               searchBar.resignFirstResponder()
               searchActive = false
        }
           
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
               searchBar.resignFirstResponder()
               searchActive = false
        }
           
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
               searchBar.resignFirstResponder()
               searchActive = false
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.count == 0 {
                searchActive = false
                self.moviesTableView.reloadData()
            } else {
                filterdMovieList = moviesList.filter({ (movie: MoviesModel) -> Bool in
                    let tmp: NSString = movie.title as NSString
                    let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                    return range.location != NSNotFound
                })
                if(filterdMovieList.count == 0){
                    searchActive = true
                } else {
                    searchActive = true
                }
                self.moviesTableView.reloadData()
            }
        }
}
