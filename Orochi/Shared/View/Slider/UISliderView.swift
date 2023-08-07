//
//  UISliderView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/11/22.
//

import SwiftUI

struct UISliderView: UIViewRepresentable {
    @Binding var value: Double
    
    var minValue = 1.0
    var maxValue = 100.0
    
    class Coordinator: NSObject {
        var value: Binding<Double>
        
        init(value: Binding<Double>) {
            self.value = value
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = Double(sender.value)
        }
    }
    
    func makeCoordinator() -> UISliderView.Coordinator {
        Coordinator(value: $value)
    }
    
    func makeUIView(context: Context) -> UISlider {
        let normalImage = UIImage(
            systemName: "circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(scale: .small)
        )
        let slider = UISlider(frame: .zero)
        slider.setThumbImage(normalImage, for: .normal)
        slider.setThumbImage(normalImage, for: .highlighted)
        slider.tintColor = UIColor.white
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.value = Float(value)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
    }
}

struct UISliderView_Previews: PreviewProvider {
    static var previews: some View {
        UISliderView(value: .constant(1))
    }
}
