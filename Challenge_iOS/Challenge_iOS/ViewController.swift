//
//  ViewController.swift
//  Challenge_iOS
//
//  Created by BOMBSGIE on 2023/03/01.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
//    let tableView = UITableView()
//    let loadAllButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        
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
