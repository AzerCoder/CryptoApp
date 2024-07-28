//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 20/07/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image:UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let filemanager = LocalFileManager.intance
    private let folderName = "coin_images"
    private let imageName:String
    
    init(coin:CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage(){
        if let savedImage = filemanager.getImage(imageName: imageName, folderName: folderName){
             image = savedImage
        }else{
            downloadCoinImage()
        }
    }
    

    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }

        imageSubscription = NetworkingManager.download(url: url)
            .tryMap { data -> UIImage? in
                return UIImage(data: data)
            }
            .sink(receiveCompletion: { completion in
                NetworkingManager.handleComplition(complition: completion)
            }, receiveValue: { [weak self] returnedImage in
                guard let self = self else { return }
                if let image = returnedImage {
                    self.image = image
                    self.filemanager.saveImage(image: image, imageName: self.imageName, folderName: self.folderName)
                }
                self.imageSubscription?.cancel()
            })
    }

}
