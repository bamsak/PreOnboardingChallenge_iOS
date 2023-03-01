//
//  ImageCell.swift
//  Challenge_iOS
//
//  Created by BOMBSGIE on 2023/03/01.
//

import UIKit
import SnapKit

class ImageCell: UITableViewCell {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loadImageView, progressBar, loadButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-15)
        }
        
        return stackView
    }()
    
    lazy var loadImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo"))
        imageView.contentMode = .scaleToFill
        imageView.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(90)
        }
        return imageView
    }()
    
    lazy var progressBar: UIProgressView = {
        let progressbar = UIProgressView()
        progressbar.progressViewStyle = .default
        progressbar.trackTintColor = .systemGray4
        progressbar.progressTintColor = .systemBlue
        progressbar.progress = 0.5

        return progressbar
    }()
    
    lazy var loadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Load", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        button.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(stackView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func loadImage(sender: UIButton!) {
        self.loadImageView.image = UIImage(systemName: "photo")
        
        let url = URL(string: "https://picsum.photos/200/300")!
        
        URLSession.shared.downloadTask(with: url, completionHandler: { (location, reponse, error) -> Void in
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    self.loadImageView.image = image
                }
            }
        }).resume()
    }
}
