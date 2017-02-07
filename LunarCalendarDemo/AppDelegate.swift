//
//  AppDelegate.swift
//  LunarCalendarDemo
//
//  Created by fancymax on 15/12/27.
//  Copyright © 2015年 fancy. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, LunarCalendarViewDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var dateField:NSTextField!
    @IBOutlet weak var dateFormatter:DateFormatter!
    
    var calendarPopover:NSPopover?
    var calendarView:LunarCalendarView!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.dateField.stringValue = dateFormatter.string(from: Date())
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func showCalendar(_ sender: NSButton){
        self.createCalenderPopover()
    	let date = self.dateFormatter.date(from: dateField.stringValue)
    	self.calendarView.date = date
    	self.calendarView.selectedDate = date;
        print("\(date) \(self.calendarView.selectedDate)")
        
        let cellRect = sender.bounds
        self.calendarPopover?.show(relativeTo: cellRect, of: sender, preferredEdge: .maxY)
    }
    
    func createCalenderPopover(){
        var myPopover = self.calendarPopover
        if(myPopover == nil){
            myPopover = NSPopover()
            self.calendarView = LunarCalendarView()
            self.calendarView.delegate = self
            myPopover!.contentViewController = self.calendarView
            myPopover!.appearance = NSAppearance(named: "NSAppearanceNameAqua")
            myPopover!.animates = true
            myPopover!.behavior = NSPopoverBehavior.transient
        }
        self.calendarPopover = myPopover
    }

    func didSelectDate(_ selectedDate: Date) {
        self.calendarPopover?.close()
        self.dateField.stringValue = self.dateFormatter.string(from: selectedDate)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

