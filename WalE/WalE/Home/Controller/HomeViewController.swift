//
//  HomeViewController.swift
//  WalE
//
//  Created by Vishal Kumar on 11/03/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgApod: UIImageView!

    lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addListner()
        viewModel.fetchAPOD()
    }

    func addListner() {
        viewModel.setupView = { [weak self] apodModel, imageData in
            self?.lblTitle.text = apodModel.title
            self?.lblDesc.text = apodModel.explanation
            self?.imgApod.image = UIImage(data: imageData)
        }

        viewModel.showError = { [weak self] message in
            self?.alert(message: message)
        }
    }

}
