//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Clay Mills on 2/24/17.
//  Copyright © 2017 Clay Mills. All rights reserved.
//

import UIKit

// set delegate, searchbar outlet, didSet Movie array, search function, resignFirstResponder(), fetchdata, dispatchQueue, segue to more detailed view

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text else { print("No text added to search bar!")
            return}
        
        MovieController.fetchMovieWith(searchTerm: searchTerm) { (movie) in
            self.movies = movie
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.searchBar.resignFirstResponder()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = movies[indexPath.row]
        cell.movies = movie
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
