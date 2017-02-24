//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Clay Mills on 2/24/17.
//  Copyright © 2017 Clay Mills. All rights reserved.
//

import UIKit
// Oulets from the tableView

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieRatingLabel: UILabel!
    
    @IBOutlet weak var movieOverviewTextView: UITextView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movies: Movie? {
        didSet {
            updateViews()
        }
    }
    func updateViews() {
        guard let movie = movies else {return}
        movieTitleLabel.text = movie.title
        movieRatingLabel.text = "\(movie.rating)"
        movieOverviewTextView.text = movie.overview
        ImageController.image(forURL: (movie.imageURL)) { (image) in
            self.posterImageView.image = image
        }
    }
    
}
