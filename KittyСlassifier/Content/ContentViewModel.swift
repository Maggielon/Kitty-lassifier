//
//  ContentViewModel.swift
//  KittyСlassifier
//
//  Created by Анастасия on 14.12.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation
import Combine
import CoreML
import Vision

class ContentViewModel: ObservableObject {
    
    let model = Kitty()
    var request: VNCoreMLRequest?
    var visionModel: VNCoreMLModel?
    
    @Published var results: [VNClassificationObservation] = []
    
    init() {
        self.setup()
    }
    
    func setup() {
        if let visionModel = try? VNCoreMLModel(for: model.model) {
            self.visionModel = visionModel
            self.request = VNCoreMLRequest(model: visionModel) { request, error in
                DispatchQueue.main.async(execute: {
                    self.results = []
                    if let results = request.results {
                        for observation in results where observation is VNClassificationObservation {
                            guard let klassifierObservation = observation as? VNClassificationObservation else {
                                return
                            }
                            self.results.append(klassifierObservation)
                        }
                    }
                })
            }
        }
    }
}
