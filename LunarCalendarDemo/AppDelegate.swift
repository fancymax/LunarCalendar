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
    @IBOutlet weak var dateFormatter:NSDateFormatter!
    
    var calendarPopover:NSPopover?
    var calendarView:LunarCalendarView!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        self.dateField.stringValue = dateFormatter.stringFromDate(NSDate())
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func showCalendar(sender: NSButton){
        self.createCalenderPopover()
    	let date = self.dateFormatter.dateFromString(dateField.stringValue)
    	self.calendarView.date = date
    	self.calendarView.selectedDate = date;
        
        let cellRect = sender.bounds
        self.calendarPopover?.showRelativeToRect(cellRect, ofView: sender, preferredEdge: .MaxY)
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
            myPopover!.behavior = NSPopoverBehavior.Transient
        }
        self.calendarPopover = myPopover
    }

    func didSelectDate(selectedDate: NSDate) {
        self.calendarPopover?.close()
        self.dateField.stringValue = self.dateFormatter.stringFromDate(selectedDate)
    }
}

