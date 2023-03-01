//
//  ViewController.swift
//  Challenge_iOS
//
//  Created by BOMBSGIE on 2023/03/01.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let tableView = UITableView()
    private let loadAllButton = UIButton()
    
    lazy var loadImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo"))
        imageView.contentMode = .scaleToFill
        imageView.snp.makeConstraints { image in
            image.width.equalTo(120)
            image.height.equalTo(90)
        }
        return imageView
    }()
    
    lazy var progressbar: UIProgressView = {
        let progressbar = UIProgressView()
        progressbar.progressViewStyle = .default
        progressbar.trackTintColor = .systemGray4
        progressbar.progressTintColor = .blue
        progressbar.progress = 0.5
        return progressbar
    }()
    
    lazy var loadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Load", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        //        button.snp.makeConstraints { make in
        //            make.width.equalTo(80)
        //            make.height.equalTo(40)
        //        }
        button.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        return button
    }()
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(loadImageView)
        view.addSubview(progressbar)
        view.addSubview(loadButton)
        loadImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        progressbar.snp.makeConstraints { make in
            //            make.width.equalTo(100)
            make.top.equalTo(100)
            make.leading.equalTo(loadImageView.snp.trailing)
            make.trailing.equalTo(loadButton.snp.leading)
            make.centerX.equalToSuperview()
        }
        loadButton.snp.makeConstraints { make in
            make.top.equalTo(85)
            //            make.leading.equalTo(progressbar.snp.trailing)
            make.trailing.equalToSuperview()
        }
        
    }
    
    
}

class ImageCell: UITableViewCell {
    
}

//MARK: - 프리뷰
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiView: UIViewController, context: Context) {
        
    }
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        ViewController()
    }
    @available(iOS 13.0, *)
    struct SnapkitVCRepresentable_PreviewProvider: PreviewProvider {
        static var previews: some View {
            Group {
                ViewControllerRepresentable()
                    .ignoresSafeArea()
                    .previewDisplayName("Preview")
                    .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            }
        }
    }
}
