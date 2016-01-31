//
//  AppDelegate.swift
//  CertOSX
//
//  Created by Yannick Heinrich on 29.01.16.
//  Copyright © 2016 Yannick Heinrich. All rights reserved.
//

import Cocoa
import ApplicationServices.HIServices

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    var analyzer: ElementsAnalyzer?

    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        print("Starting agent...")
        
        // Check if API Enabled
        
        let value = kAXTrustedCheckOptionPrompt.takeUnretainedValue()
        let options: [String:AnyObject] = [value as String: (true as CFBooleanRef)]
        if(AXIsProcessTrustedWithOptions(options)){
            
            startAnalyzer()
        } else {
           
        }
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


    func startAnalyzer() {
        self.analyzer = ElementsAnalyzer()
        
        if let windows = self.analyzer?.simulatorWindows() {
            
            for w in windows {
                print("Window: \(w)")
                
                let actor = SimulatorOperator(simulator: w)
                actor.makeSimulatorVisible()
                // First Install
                actor.searchButtonAndClick("Install")
                
                NSThread.sleepForTimeInterval(3.0)
                actor.searchButtonAndClick("Install")

                // Need to be done two time
                NSThread.sleepForTimeInterval(3.0)
                actor.searchButtonAndClickQuartzCore("Install")                
                
                NSThread.sleepForTimeInterval(3.0)
                actor.searchButtonAndClick("Done")

                
            }
        }
    }

}
