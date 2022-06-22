import Foundation
import AppKit

let CustomizeTouchBar = "Customize Touch Bar..."

//var flapRatioDataRef: XPLMDataRef! = nil

var gMenuContainerIdx: Int32! = nil
var gMenuId: XPLMMenuID! = nil

let myTouchBar = MyTouchBar()

@_cdecl("XPluginStart")
public func XPluginStart(outName: UnsafeMutablePointer<CChar>, outSig: UnsafeMutablePointer<CChar>, outDesc: UnsafeMutablePointer<CChar>) -> Int {
    
    NSLog("XPTouchBar XPluginStart")
    
    strcpy(outName, "XPTouchBar")
    strcpy(outSig, "com.chriskilding.XPTouchBar")
    strcpy(outDesc, "Control X-Plane with your Mac's Touch Bar.")
                
    return 1
}


@_cdecl("XPluginStop")
public func XPluginStop() {
    NSLog("XPTouchBar XPluginStop")
    
    end()
}

@_cdecl("XPluginDisable")
public func XPluginDisable() {
    NSLog("XPTouchBar XPluginDisable")
    
    end()
}

@_cdecl("XPluginEnable")
public func XPluginEnable() -> Int {
    NSLog("XPTouchBar XPluginEnable")
    
    begin()
    
    return 1
}

@_cdecl("XPluginReceiveMessage")
public func XPluginReceiveMessage(inFrom: XPLMPluginID, inMsg: Int, inParam: UnsafeRawPointer) { }

func begin() {
    //flapRatioDataRef = XPLMFindDataRef("sim/cockpit2/controls/flap_ratio")
    
    gMenuContainerIdx = XPLMAppendMenuItem(XPLMFindPluginsMenu(), "XPTouchBar", nil, 0)
    
    gMenuId = XPLMCreateMenu("XPTouchBar", XPLMFindPluginsMenu(), gMenuContainerIdx, menuHandler, nil)
    
    var d = CustomizeTouchBar.data(using: .utf8)!
    d.withUnsafeMutableBytes { itemRef in
        XPLMAppendMenuItem(gMenuId, CustomizeTouchBar, itemRef, 1)
    }
    
    NSApplication.shared.windows.forEach { window in
        let windowTitle = window.title
        NSLog("XPTouchBar will add custom Touch Bar to X-Plane window: '\(windowTitle)'")
        window.touchBar = myTouchBar.makeTouchBar()
    }
}

func end() {
    // Clean up our dataref subscriptions
    
    // Clean up the menu
    XPLMDestroyMenu(gMenuId)
    
    // Clean up the Touch Bar
    NSApplication.shared.windows.forEach { window in
        window.touchBar = nil
    }
}

func menuHandler(inMenuRef: UnsafeMutableRawPointer?, inItemRef: UnsafeMutableRawPointer?) {
    NSLog("XPTouchBar menuHandler")
    
    guard let inItemRef = inItemRef else {
        return
    }
    
//    let opaquePtr = OpaquePointer(inItemRef)
//    let ccharPtr = UnsafePointer<CChar>(opaquePtr)
//
//    NSLog("XPTouchBar will convert to String")
//
//    // character conversion somehow goes wrong
//    let item = String(cString: ccharPtr)
//
//    NSLog("XPTouchBar menu item name: '\(item)'")
//
//    if (item == CustomizeTouchBar) {
    NSLog("XPTouchBar will open Touch Bar customization palette")
    
    NSApplication.shared.toggleTouchBarCustomizationPalette(nil)
//    }
}
