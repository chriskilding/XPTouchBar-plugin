# XPTouchBar

Experimental X-Plane plugin version of [XPTouchBar](https://github.com/chriskilding/XPTouchBar).

## Overview

This is an experimental X-Plane plugin which presents aircraft controls in the Mac Touch Bar. It replicates the features of the XPTouchBar app, but in plugin form.

This plugin makes the Touch Bar functionality available simply by running X-Plane - as long as X-Plane is in focus, the Touch Bar controls will appear. This overcomes the single biggest limitation of the standalone app (the need to Cmd-Tab back-and-forth between it and X-Plane).

If this experiment is a success, the code will be merged into the main XPTouchBar repository, and the standalone app will disappear.

## Requirements

- Mac with Touch Bar
- macOS 12
- X-Plane 11.55 or higher

## Setup

1. Compile the plugin from source with Xcode.
2. Install the plugin `.xpl` in the X-Plane plugins folder.
3. Ensure you rename the .xpl file to `mac.xpl`, otherwise X-Plane will not load it.

## Usage

1. Start X-Plane and load a new flight.
2. The Touch Bar controls will appear.
3. (Optional) Configure the Touch Bar controls that are shown (see the Configuration section below).

## Configuration

1. While a flight is running, move your mouse to show the X-Plane menu bar.
2. Click `Plugins` -> `XPTouchBar` -> `Customize Touch Bar...` 
3. Add controls to the Touch Bar which are relevant to your aircraft and sim setup.

You can add any controls that you find useful. Here are some suggestions:

| Aircraft            | Controls                                     |
|---------------------|----------------------------------------------|
| Cessna 172          | Throttle, Mixture, Flaps                     |
| Cirrus Vision SF50  | Throttle, Flaps, Landing Gear                |
| Boeing 737          | Speedbrake, Throttle, Flaps, Landing Gear    |
| Beechcraft Baron 58 | Throttle, Prop, Mixture, Flaps, Landing Gear |


