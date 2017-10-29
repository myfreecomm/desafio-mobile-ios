//
//  RoundedImage.swift
//  nexaas-desafio-ios
//
//  Created by Rogerio Cervasio on 27/10/17.
//  Copyright © 2017 ACME. All rights reserved.
//

import UIKit
import AlamofireImage

class RoundedImage: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func imageFromUrl(link: String? = nil, rounded: Bool? = true){
        
        if link == nil {
            
            if rounded! == false {
                self.image = UIImage(named: "userplaceholder")
            }else{
                self.image = UIImage(named: "userplaceholder")!.af_imageRoundedIntoCircle()
            }
            
            return
            
        }
        
        let url = URL(string: link!)
        
        if url == nil {
            
            if rounded! == false{
                self.image = UIImage(named: "userplaceholder")
            }else{
                self.image = UIImage(named: "userplaceholder")!.af_imageRoundedIntoCircle()
            }
            
            return
            
        }
        
        if rounded! == false{
            self.af_setImage(withURL: url!, placeholderImage: UIImage(named: "userplaceholder"), imageTransition: ImageTransition.crossDissolve(0.3)) { response in}
        }else{
            self.af_setImage(withURL: url!, placeholderImage: UIImage(named: "userplaceholder"), filter: CircleFilter(), imageTransition: ImageTransition.crossDissolve(0.3)) { response in}
        }
        
    }
    
    public struct CircleFilter: ImageFilter {
        
        public init() {}
        
        public var filter: (Image) -> Image {
            return { image in
                return image.af_imageRoundedIntoCircle()
            }
        }
    }
    
}

