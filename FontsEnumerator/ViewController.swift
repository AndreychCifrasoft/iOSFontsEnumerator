//
//  ViewController.swift
//  FontsEnumerator
//
//  Created by Andrey Brusnikin on 23/09/15.
//  Copyright (c) 2015 Andrey Brusnikin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let cellIdentifier = "FontCell"
    let testText = "So many books, so little time"
    
    var fontsFamilies:[String]!
    var fontsNames:[[String]] = []
    var fontsSamples:[String] = []
    
    let white:UIColor = UIColor(white: 0.98, alpha: 1.0)
    let gray:UIColor = UIColor(white: 0.94, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        let families = UIFont.familyNames() as [String]
        fontsFamilies = families.sort({ (famOne, famTwo) -> Bool in
            return famOne.localizedCompare(famTwo) != NSComparisonResult.OrderedDescending
        })
        
        for famInd in 0...(fontsFamilies.count-1) {
            fontsNames.append(UIFont.fontNamesForFamilyName(fontsFamilies[famInd]) as [String])
            var filtered = fontsNames[famInd].filter({ (fontName:String) -> Bool in
                if (fontName == self.fontsFamilies[famInd]) {
                    return true
                }
                if (fontName.hasSuffix("Regular")) {
                    return true
                }
                return false
            })
            if filtered.count > 0 {
                fontsSamples.append(filtered[0])
            }
            else {
                fontsSamples.append(fontsNames[famInd][0])
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        if indexPath.section%2 == 0 {
            cell.backgroundColor = white
        }
        else {
            cell.backgroundColor = gray
        }
        
        cell.textLabel?.text = testText
        cell.detailTextLabel?.text = fontsFamilies[indexPath.section]
        cell.textLabel?.font = UIFont(name: fontsSamples[indexPath.section], size: 18)
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fontsFamilies.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        for font in fontsNames[indexPath.section] {
            print("\(font)")
        }
    }
}

