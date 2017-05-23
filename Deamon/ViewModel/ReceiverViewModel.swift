//
//  ReceiverViewModel.swift
//  Deamon
//
//  Created by Pawel Kowalczuk on 18/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Foundation

struct ReceiverViewModel {
    
    let shouldRegister: Bool
    let disableTextField: Bool
    let textViewResult: String
    
    init(shouldRegister: Bool = true,
         disableTextField: Bool = true,
         textViewResult: String = "") {
        
        self.shouldRegister = shouldRegister
        self.disableTextField = disableTextField
        self.textViewResult = textViewResult
    }
}
