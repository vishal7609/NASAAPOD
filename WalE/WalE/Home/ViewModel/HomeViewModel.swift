//
//  HomeViewModel.swift
//  WalE
//
//  Created by Vishal Kumar on 11/03/22.
//

import Foundation

class HomeViewModel {
    
    var networkManager = HomeNetworkManager(router: Router())
    var apodModel: ApodModel?
    
    var showError: ((_ errorString: String) -> Void)?
    var setupView: ((_ apodModel: ApodModel, _ imageData: Data) -> Void)?

    func fetchAPOD() {
        let response = Storage.shared.reteriveData()
        if let savedApodModel = response.apodModel, let savedImageData = response.imageData {
            let currentDate = Date().string(format: DateFormatterString.onlydate.rawValue)
            if currentDate == savedApodModel.date {
                self.setupView?(savedApodModel, savedImageData)
            } else {
                fetchDataFromServer()
            }
        } else {
            fetchDataFromServer()
        }
    }
    
    func showPrevData() {
        let response = Storage.shared.reteriveData()
        if let savedApodModel = response.apodModel, let savedImageData = response.imageData {
            self.setupView?(savedApodModel, savedImageData)
        }
    }

    func fetchDataFromServer() {
        networkManager.getAstronomyPictures { apodModel, error in
            DispatchQueue.main.async {
                if error == nil, let apodModel = apodModel {
                    Storage.shared.saveData(apodData: apodModel)
                    self.apodModel = apodModel
                    self.downloadImage(urlString: apodModel.url)
                } else {
                    let message = "We are not connected to the internet, showing you the last image we have."
                    self.showError?(message)
                    self.showPrevData()
                }
            }
        }
    }
    
    func downloadImage(urlString: String) {
        networkManager.downloadImage(url: urlString) { imageData, errorString in
            DispatchQueue.main.async {
                if errorString == nil, let imageData = imageData {
                    Storage.shared.saveImageData(imageData: imageData)
                    if let apodModel = self.apodModel {
                        self.setupView?(apodModel, imageData)
                    }
                } else {
                    self.showError?(errorString ?? "Error")
                }
            }
        }
    }
}
