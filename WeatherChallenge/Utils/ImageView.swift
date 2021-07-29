//
//  ImageView.swift
//  WeatherChallenge
//
//  Created by Francisco Cantos
//

import SDWebImage

extension UIImageView {
    /// Method that gets an image from url. Shows a temp image while downloading from url
    func setNetworkImage(urlString: String) {
        let imageURL = URL(string: urlString)
        self.sd_setImage(with: imageURL,
                         placeholderImage: notFoundImage,
                         options: SDWebImageOptions(rawValue: 0),
                         completed: { [weak self] (image, error, cacheType, imgURL) in
                            if (error == nil) {
                                self?.image = image
                            } else {
                                self?.image = notFoundImage
                            }
                         })
    }
}
