//
//  SquareColorView.swift
//  Pikko_Example
//
//  Created by Sandra Grujovic on 05.10.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public class BrightnessSaturationColorView: UIView {
    
    // FIXME: Make sampling rate parametric depending on size of canvas.
    var samplingRate: CGFloat = 25.0
    var brightnessSaturationView: UIView!
    var brightnessLayer: CAGradientLayer?
    var saturationLayer: CAGradientLayer?
    var selector: UIView!
    
    init(frame: CGRect, borderWidth: CGFloat, scale: CGFloat) {
        super.init(frame: frame)
        createView(frame)
        createSelector(borderWidth, scale)
    }
    
    private func createView(_ frame: CGRect) {
        saturationLayer = createSaturationLayer(hue: 0.0)
        brightnessLayer = createBrightnessLayer()
        brightnessSaturationView = UIView(frame: frame)
        
        brightnessSaturationView.layer.addSublayer(saturationLayer!)
        brightnessSaturationView.layer.addSublayer(brightnessLayer!)
        addSubview(brightnessSaturationView)
    }
    
    private func createSelector(_ borderWidth: CGFloat, _ scale: CGFloat) {
        let selectorWidth = borderWidth * scale
        selector = UIView(frame: CGRect(x: 0-selectorWidth/2, y: 0-selectorWidth/2, width: selectorWidth, height: selectorWidth))
        selector.backgroundColor = .white
        selector.layer.cornerRadius = selectorWidth/2
        selector.layer.borderColor = UIColor.white.cgColor
        selector.layer.borderWidth = 1
        selector.isUserInteractionEnabled = true
        
        setUpGestureRecognizer()
        addSubview(selector)
    }
    
    private func setUpGestureRecognizer() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(selectorPanned(_:)))
        longPressGestureRecognizer.minimumPressDuration = 0.0
        selector?.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func selectorPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        var location = panGestureRecognizer.location(in: self)
        
        if location.x <= 0 {
            location.x = 0
        }
        
        if location.x >= frame.width {
            location.x = frame.width - 1
        }
        
        if location.y <= 0 {
            location.y = 0
        }
        
        if location.y >= frame.height {
            location.y = frame.height - 1
        }
        
        updateColor(point: location)
        selector.center = location
    }
    
    private func updateColor(point: CGPoint) {
        selector?.backgroundColor = ColorUtilities.getPixelColorAtPoint(point: point, sourceView: brightnessSaturationView)
    }
    
    private func generateSaturationInterpolationArray(hue: CGFloat) -> [CGColor] {
        var colorArray = [CGColor]()
        
        for i in 0..<Int(samplingRate) {
            let interpolationValue = CGFloat(CGFloat(i) / samplingRate)
            let color = UIColor(hue: hue, saturation: interpolationValue, brightness: 1.0, alpha: 1.0)
            colorArray.append(color.cgColor)
        }
        
        return colorArray
    }
    
    private func createSaturationLayer(hue: CGFloat) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = generateSaturationInterpolationArray(hue: hue)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = frame
        
        return gradientLayer
    }
    
    private func createBrightnessLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        var colorArray = [CGColor]()
        
        for i in 0..<Int(samplingRate) {
            let interpolationValue = CGFloat(CGFloat(i) / samplingRate)
            let color = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: interpolationValue)
            colorArray.append(color.cgColor)
        }
        
        gradientLayer.colors = colorArray
        gradientLayer.frame = frame
        
        return gradientLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let pointForTargetView = selector.convert(point, from: self)

        if self.selector.bounds.contains(pointForTargetView) {
            return selector.hitTest(pointForTargetView, with: event)
        }
        
        return super.hitTest(point, with: event)
    }
}
