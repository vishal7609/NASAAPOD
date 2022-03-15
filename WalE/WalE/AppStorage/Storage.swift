//
//  Storage.swift
//  WalE
//
//  Created by Vishal Kumar on 11/03/22.
//

import Foundation


class Storage {
    
    static let shared = Storage()
    private init() {}
    
    private func createFolder() -> URL? {
        let documentDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        if let dirPath = documentDirectory.appendingPathComponent("APOD") {
            if !FileManager.default.fileExists(atPath: dirPath.path) {
                do {
                    try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print(error.localizedDescription);
                }
            }
            return dirPath
        }
        return nil
    }

    @discardableResult
    private func createFile(fileName: String, data: Data) -> Bool {
        deleteFile(fileName: fileName)
        if let path = createFolder() {
            let dirPath = path.appendingPathComponent(fileName)
            FileManager.default.createFile(atPath: dirPath.path, contents: data, attributes: nil)
            return true
        }
        return false
    }

    @discardableResult
    private func deleteFile(fileName: String) -> Bool {
        if let path = createFolder() {
            let dirPath = path.appendingPathComponent(fileName)
            do {
                try FileManager.default.removeItem(at: dirPath)
                return true
            } catch {
                print(error.localizedDescription);
            }
        }
        return  false
    }

    @discardableResult
    func saveData(apodData: ApodModel) -> Bool {
        if let dictionary = apodData.dictionary {
            if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) {
                return createFile(fileName: "response", data: jsonData)
            }
        }
        return false
    }
    
    @discardableResult
    func saveImageData(imageData: Data) -> Bool {
        return createFile(fileName: "imageResponse", data: imageData)
    }

    func reteriveData() -> (apodModel: ApodModel?, imageData: Data?) {
        if let path = createFolder() {
            let dirPath = path.appendingPathComponent("response")
            let apodModelData = try? Data.init(contentsOf: dirPath)
            let apodModel = Parser.decodeResponse(ApodModel.self, from: apodModelData).0
            
            let imageDirPath = path.appendingPathComponent("imageResponse")
            let imageData = try? Data.init(contentsOf: imageDirPath)
            
            return (apodModel: apodModel, imageData: imageData)
        }
        return (nil, nil)
    }
}
