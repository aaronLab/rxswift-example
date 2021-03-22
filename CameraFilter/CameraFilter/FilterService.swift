//
//  FilterService.swift
//  CameraFilter
//
//  Created by Aaron Lee on 2021/03/23.
//

import UIKit
import CoreImage

class FilterService {
    
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> Void)) {
        
        let filter = CIFilter(name: "CICMYKHalftone")
        filter?.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputImage) {
            
            filter?.setValue(sourceImage, forKey: kCIInputImageKey)
            
            guard let outputImage = filter?.outputImage else { return }
            
            if let cgImg = self.context.createCGImage(outputImage, from: outputImage.extent) {
                
                let processedImage = UIImage(cgImage: cgImg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                completion(processedImage)
                
            }
            
        }
        
    }
    
}
