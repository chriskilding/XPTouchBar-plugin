import AppKit

class MyTouchBar: NSObject, NSTouchBarDelegate {
        
    func makeTouchBar() -> NSTouchBar {
        let touchBar = NSTouchBar()
        touchBar.customizationIdentifier = .xpTouchBar
        touchBar.defaultItemIdentifiers = [.throttle, .mixture, .flaps]
        touchBar.customizationAllowedItemIdentifiers = [.throttle, .pitch, .mixture, .flaps, .gear, .parkingBrake, .speedbrake, .simSpeed, .lights, .camera]
        touchBar.delegate = self
        return touchBar
    }
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case .speedbrake:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = "S"
            sliderTouchBarItem.customizationLabel = "Speedbrake"
            sliderTouchBarItem.slider.trackFillColor = .systemMint
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.doubleValue = 0
            sliderTouchBarItem.slider.target = self
            sliderTouchBarItem.slider.action = #selector(Self.speedbrakeChanged(_:))
            return sliderTouchBarItem
        case .throttle:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = "T"
            sliderTouchBarItem.customizationLabel = "Throttle"
            sliderTouchBarItem.slider.trackFillColor = .white
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.doubleValue = 1
            sliderTouchBarItem.slider.target = self
            sliderTouchBarItem.slider.action = #selector(Self.throttleChanged(_:))
            return sliderTouchBarItem
        case .pitch:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = "P"
            sliderTouchBarItem.customizationLabel = "Propeller Pitch"
            sliderTouchBarItem.slider.trackFillColor = .systemBlue
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.doubleValue = 1
            sliderTouchBarItem.slider.target = self
            sliderTouchBarItem.slider.action = #selector(Self.pitchChanged(_:))
            return sliderTouchBarItem
        case .mixture:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = "M"
            sliderTouchBarItem.customizationLabel = "Mixture"
            sliderTouchBarItem.slider.trackFillColor = .systemRed
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.doubleValue = 1
            sliderTouchBarItem.slider.target = self
            sliderTouchBarItem.slider.action = #selector(Self.mixtureChanged(_:))
            return sliderTouchBarItem
        case .flaps:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = "F"
            sliderTouchBarItem.customizationLabel = "Flaps"
            sliderTouchBarItem.slider.trackFillColor = .systemPurple
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.doubleValue = 0
            sliderTouchBarItem.slider.target = self
            sliderTouchBarItem.slider.action = #selector(Self.flapsChanged(_:))
            return sliderTouchBarItem
        case .gear:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Gear", target: self, action: #selector(Self.gearChanged(_:)))
            toggle.customizationLabel = "Landing Gear"
            return toggle
        case .parkingBrake:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Park", target: self, action: #selector(Self.parkingBrakeChanged(_:)))
            toggle.customizationLabel = "Parking Brake"
            return toggle
        case .simSpeed:
            let simSpeedImages = [
                NSImage(systemSymbolName: "pause.fill", accessibilityDescription: "Pause")!,
                NSImage(systemSymbolName: "play.fill", accessibilityDescription: "1x Speed")!,
                NSImage(systemSymbolName: "forward.fill", accessibilityDescription: "2x Speed")!
            ]
            let control = NSPickerTouchBarItem(identifier: identifier, images: simSpeedImages, selectionMode: .selectOne, target: self, action: #selector(Self.simSpeedChanged(_:)))
            control.controlRepresentation = .expanded
            control.customizationLabel = "Simulation Speed"
            return control
        case .beaconLight:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Beacon", target: self, action: #selector(Self.beaconChanged(_:)))
            toggle.customizationLabel = "Beacon Light"
            return toggle
        case .landingLights:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Land", target: self, action: #selector(Self.landingChanged(_:)))
            toggle.customizationLabel = "Landing Lights"
            return toggle
        case .navigationLights:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Nav", target: self, action: #selector(Self.navigationChanged(_:)))
            toggle.customizationLabel = "Navigation Lights"
            return toggle
        case.taxiLight:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Taxi", target: self, action: #selector(Self.taxiChanged(_:)))
            toggle.customizationLabel = "Taxi Light"
            return toggle
        case .strobeLights:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Strobe", target: self, action: #selector(Self.strobeChanged(_:)))
            toggle.customizationLabel = "Strobe Lights"
            return toggle
        case .lights:
            let popover = NSPopoverTouchBarItem(identifier: identifier)
            popover.customizationLabel = "Lights"
            popover.collapsedRepresentationImage = NSImage(systemSymbolName: "lightbulb", accessibilityDescription: "Lights")
            popover.popoverTouchBar.customizationIdentifier = .lightsBar
            popover.popoverTouchBar.defaultItemIdentifiers = [.beaconLight, .landingLights, .navigationLights, .strobeLights, .taxiLight]
            // This method will also construct the items of the popover touchbar
            popover.popoverTouchBar.delegate = touchBar.delegate!
            return popover
        case .camera:
            let labels = [
                "Cockpit",
                "Chase",
                "Circle",
                "HUD",
                "Linear Spot",
                "Runway",
                "Still Spot",
                "Tower",
            ]
            let control = NSPickerTouchBarItem(identifier: identifier, labels: labels, selectionMode: .selectOne, target: self, action: #selector(Self.cameraChanged(_:)))
            control.controlRepresentation = .collapsed
            control.customizationLabel = "Camera"
            control.collapsedRepresentationImage = NSImage(systemSymbolName: "video", accessibilityDescription: "Camera")
            return control
        default:
            return nil
        }
    }
    
    @objc func throttleChanged(_ sender: NSSlider) {
//        props.throttle = sender.floatValue
    }
    
    @objc func pitchChanged(_ sender: NSSlider) {
//        props.pitch = sender.floatValue
    }
    
    @objc func mixtureChanged(_ sender: NSSlider) {
//        props.mixture = sender.floatValue
    }
    
    @objc func flapsChanged(_ sender: NSSlider) {
//        props.flaps = sender.floatValue
    }
    
    @objc func speedbrakeChanged(_ sender: NSSlider) {
//        props.speedbrake = sender.floatValue
    }
    
    @objc func simSpeedChanged(_ sender: NSPickerTouchBarItem) {
//        switch sender.selectedIndex {
//        case 0:
//            props.simSpeed = .pause
//        case 1:
//            props.simSpeed = .x1
//        case 2:
//            props.simSpeed = .x2
//        default:
//            break
//        }
    }
    
    @objc func cameraChanged(_ sender: NSPickerTouchBarItem) {
//        switch sender.selectedIndex {
//        case 0:
//            props.camera = .cockpit
//        case 1:
//            props.camera = .chase
//        case 2:
//            props.camera = .circle
//        case 3:
//            props.camera = .hud
//        case 4:
//            props.camera = .linearSpot
//        case 5:
//            props.camera = .runway
//        case 6:
//            props.camera = .stillSpot
//        case 7:
//            props.camera = .tower
//        default:
//            break
//        }
    }
    
    @objc func gearChanged(_ sender: NSButton) {
//        props.gear.toggle()
    }
    
    @objc func parkingBrakeChanged(_ sender: NSButton) {
//        props.parkingBrake.toggle()
    }
    
    @objc func beaconChanged(_ sender: NSButton) {
//        props.beaconLights.toggle()
    }
    
    @objc func landingChanged(_ sender: NSButton) {
//        props.landingLights.toggle()
    }
    
    @objc func navigationChanged(_ sender: NSButton) {
//        props.navigationLights.toggle()
    }
    
    @objc func taxiChanged(_ sender: NSButton) {
//        props.taxiLight.toggle()
    }
    
    @objc func strobeChanged(_ sender: NSButton) {
//        props.strobeLights.toggle()
    }
    
}

fileprivate func lightsBezelColor(_ isOn: Bool) -> NSColor {
    if isOn {
        return .systemYellow
    } else {
        return .controlColor
    }
}

