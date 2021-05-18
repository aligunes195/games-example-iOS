//
//  UIImage.swift
//  games
//
//  Created by Ali Güneş on 17.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

extension UIImage {
    func compressForThumbnail() -> Data? {
        return self.resized(toWidth: 200)?.jpegData(compressionQuality: 0.4)
    }
    
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
