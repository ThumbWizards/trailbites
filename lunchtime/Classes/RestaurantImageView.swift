//
//  RestaurantImageView.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/14/21.
//

import Foundation
import UIKit

struct ImageParameters {
    let photoReference: String
    let maxSize: Int
}

class RestuarantImageView: UIImageView {

    func loadImage(imageParameters: ImageParameters) {
        guard let url = requestURL(imageParameters: imageParameters) else {
            return
        }
        print(url.absoluteString)
        load(url: url)
    }

    func requestURL(imageParameters: ImageParameters) -> URL? {
        let baseURL = Constants.Network.photoBaseURL
        let size = String(imageParameters.maxSize)
        let urlString = "\(baseURL)maxwidth=\(size)&photo_reference=\(imageParameters.photoReference)&key=\(Constants.Network.apiKey)"
        return URL(string: urlString)
    }
}
