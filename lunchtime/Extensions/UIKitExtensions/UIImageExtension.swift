//
//  UIImageExtension.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/14/21.
//

import Foundation
import UIKit

extension UIImage {
    static func imageWithImage(_ image: UIImage?, scaledToSize newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image?.draw(in: CGRect(x: 0.0, y: 0.0, width: newSize.width, height: newSize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
