//
//  Swift+Extensions.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

extension Optional {
    func unwrapOrElse(_ val:Wrapped) -> Wrapped  {
        if self != nil {
            return self!
        } else {
            return val
        }
    }
}

