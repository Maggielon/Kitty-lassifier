//
//  ContentView.swift
//  KittyСlassifier
//
//  Created by Анастасия on 13.12.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import SwiftUI
import Vision

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            CameraViewController { pixelBuffer in
                let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
                do {
                    try imageRequestHandler.perform([self.viewModel.request].compactMap{ $0 })
                } catch {
                    print(error)
                }
            }
            VStack {
                Text("Результаты").font(.largeTitle)
                HStack {
                    ForEach(self.viewModel.results, id: \.self.identifier) { item in
                        VStack {
                            Text(item.identifier).font(.title)
                            Text("\(Int(item.confidence * 100))%").font(.title)
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
