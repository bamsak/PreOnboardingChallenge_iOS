//
//  ViewController.swift
//  Challenge_iOS
//
//  Created by BOMBSGIE on 2023/03/01.
//

import UIKit
import SnapKit

class ViewController: UIViewController{
    
    private let tableView = UITableView()
    private let loadAllButton = UIButton()
    
    let count: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //        view.addSubview(stackView)
        //
        //        stackView.snp.makeConstraints { make in
        //            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        //            make.centerX.equalToSuperview()
        //        }
        makeTableView()
    }
    
    func makeTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 50, left: 0, bottom: 100, right: 0))
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(ImageCell.self, forCellReuseIdentifier: "imageCell")
    }
    
}

extension ViewController: UITableViewDelegate{
    
}

//MARK: - Extension ViewController
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageCell else { return .init() }
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - imageCell
class ImageCell: UITableViewCell {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loadImageView, progressBar, loadButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-15)
            $0.bottom.equalToSuperview().offset(-15)
        }
        
        return stackView
    }()
    
    lazy var loadImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo"))
        imageView.contentMode = .scaleToFill
        imageView.snp.makeConstraints { image in
            image.width.equalTo(120)
            image.height.equalTo(90)
        }
        return imageView
    }()
    
    lazy var progressBar: UIProgressView = {
        let progressbar = UIProgressView()
        progressbar.progressViewStyle = .default
        progressbar.trackTintColor = .systemGray4
        progressbar.progressTintColor = .blue
        progressbar.progress = 0.5
//        progressbar.snp.makeConstraints { make in
//            make.width.equalTo(150)
//        }
        return progressbar
    }()
    
    lazy var loadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Load", for: .normal)
        button.backgroundColor = .blue
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

//MARK: - 프리뷰
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiView: UIViewController, context: Context) {
        
    }
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        ViewController()
    }
    
}

@available(iOS 13.0, *)
struct Challenge_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
                .ignoresSafeArea()
                .previewDisplayName("Preview")
                .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
        }
    }
}
