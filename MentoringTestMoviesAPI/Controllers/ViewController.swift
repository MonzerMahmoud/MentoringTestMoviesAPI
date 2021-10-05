//
//  ViewController.swift
//  MentoringTestMoviesAPI
//
//  Created by Syber Expertise on 03/10/2021.
//

import UIKit

class ViewController: UIViewController {

    // MARK: IB OUTLETS
    var searchTextLabel: UILabel!
    var searchBarView: UISearchBar!
    var moviesTableView: UITableView!
    
    // MARK:
    var moviesList: [MoviesModel] = []
    var filterdMovieList: [MoviesModel] = []
    var searchActive: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getMovies()
    }
    
    func getMovies() {
        let headers = [
            "x-rapidapi-host": "data-imdb1.p.rapidapi.com",
            "x-rapidapi-key": "8a03bc4763msh9aa7d25d7aeb685p1f1f35jsn0fc6af26580c"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://data-imdb1.p.rapidapi.com/movie/byYear/2020/")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                //print(httpResponse)
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        
                        // try to read out a string array
                        if let movies = json["Data"] as? [Any] {
                            for movie in movies {
                                let currentMovie = movie as! [String:String]
                                self.moviesList.append(MoviesModel(imdb_id: currentMovie["imdb_id"]!, title: currentMovie["title"]!))
                                
                            }
                            DispatchQueue.main.async {
                                self.moviesTableView.reloadData()
                            }
                        }
                    }
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
        })

        dataTask.resume()
    }


}

