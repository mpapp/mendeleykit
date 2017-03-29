//
//  Color+Addons.swift
//  MendeleyKit
//
//  Created by Piamonti, Stefano (ELS) on 22/01/2016.
//  Copyright © 2016 Mendeley. All rights reserved.
//

#if os(iOS)
    import UIKit
    typealias MendeleyKitColor = UIColor
#else
    import Cocoa
    typealias MendeleyKitColor = NSColor
#endif

public extension MendeleyKitColor {
    
    @objc convenience init(redInt: UInt32, greenInt: UInt32, blueInt:UInt32, alpha: CGFloat = 1) {
        
        self.init(
            red:   (CGFloat(redInt))/255.0,
            green: (CGFloat(greenInt))/255.0,
            blue:  (CGFloat(blueInt))/255.0,
            alpha: alpha)
    }
    
    @objc convenience init(hex: String, alpha: CGFloat = 1) {
        assert(hex[hex.startIndex] == "#", "Expected hex string of format #RRGGBB")
        
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1  // skip #
        
        var rgb: UInt32 = 0
        scanner.scanHexInt32(&rgb)
        
        let red = ((rgb & 0xFF0000) >> 16)
        let green = ((rgb &   0xFF00) >>  8)
        let blue = (rgb &     0xFF)
        
        self.init(redInt:red, greenInt:green, blueInt:blue, alpha:alpha)
    }

    @objc func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
    
    @objc func redComponentInt() -> UInt32
    {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (UInt32)(r*255)
    }
    
    @objc func greenComponentInt() -> UInt32
    {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (UInt32)(g*255)
    }
    
    @objc func blueComponentInt() -> UInt32
    {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (UInt32)(b*255)
    }
}
