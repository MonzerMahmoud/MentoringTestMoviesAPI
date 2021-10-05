//
//  MoviesTableViewCell.swift
//  MentoringTestMoviesAPI
//
//  Created by Syber Expertise on 04/10/2021.
//

import UIKit

class MoviesTableViewCell:UITableViewCell {
    
    fileprivate var bodyView:UIView!
    var movieName:UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        
    }
    
    override func layoutSubviews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    func setupView() {
        
        bodyView = {
           let view = UIView()
            view.layer.borderWidth = 0.8
            view.layer.borderColor = UIColor.init(red: 219/256, green: 182/256, blue: 143/256, alpha: 1).cgColor
            view.layer.cornerRadius = 25
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        movieName = {
           let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            return label
        }()
        
        contentView.addSubview(bodyView)
        bodyView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bodyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        bodyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        bodyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        bodyView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        bodyView.addSubview(movieName)
        movieName.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor, constant: 10).isActive = true
        movieName.topAnchor.constraint(equalTo: bodyView.topAnchor, constant: 5).isActive = true
        movieName.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
