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
    
    private let count: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        makeTableView()
        makeAllButton()
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
    
    func makeAllButton() {
        view.addSubview(loadAllButton)
        loadAllButton.setTitle("Load All Images", for: .normal)
        loadAllButton.backgroundColor = .systemBlue
        loadAllButton.layer.cornerRadius = 5
        loadAllButton.snp.makeConstraints { make in
            make.bottom.equalTo(-50)
            make.leading.equalTo(16)
            //            make.trailing.equalTo(-16)
            make.centerX.equalToSuperview()
        }
        loadAllButton.addTarget(self, action: #selector(allImageLoadButton), for: .touchUpInside)
    }
    
    @objc func allImageLoadButton(sender: UIButton!) {
        for index in 0..<count {
            guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ImageCell else {return}
            cell.loadImage(sender: sender)
        }
    }
}
//MARK: - Extension ViewController
extension ViewController: UITableViewDelegate{
    
}


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
