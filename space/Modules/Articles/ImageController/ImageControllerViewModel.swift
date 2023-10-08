//
//  ImageControllerViewModel.swift
//  space
//
//  Created by Vladimir Berezin on 8.10.23..
//

import Foundation

protocol ImageControllerViewModelProtocol {
    var imageUrl: URL { get }
}

final class ImageControllerViewModel: ImageControllerViewModelProtocol {

    let imageUrl: URL

    init(imageUrl: URL) {
        self.imageUrl = imageUrl
    }

}
