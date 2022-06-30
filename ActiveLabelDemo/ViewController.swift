//
//  ViewController.swift
//  ActiveLabelDemo
//
//  Created by Johannes Schickling on 9/4/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import UIKit
import ActiveLabel

class ViewController: UIViewController {
    
    let label = ActiveLabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        label.frame = CGRect(x: 20, y: 40, width: view.frame.width - 40, height: 300)
        view.addSubview(label)
        let customType = ActiveType.custom(pattern: "\\sare\\b") //Looks for "are"
        let customType2 = ActiveType.custom(pattern: "\\sit\\b") //Looks for "it"
        let customType3 = ActiveType.custom(pattern: "\\ssupports\\b") //Looks for "supports"

        label.enabledTypes.append(customType)
        label.enabledTypes.append(customType2)
        label.enabledTypes.append(customType3)
        label.hasDefaultSelectedColor = true
        label.urlMaximumLength = 31

        label.text = "This is a post with #multiple #hashtags and a @userhandle. Links are also supported like" +
        " this one: http://optonaut.co. Now it also supports custom patterns -> are\n\n" +
            "Let's trim a long link: \nhttps://twitter.com/twicket_app/status/649678392372121601"
        label.numberOfLines = 0
        label.lineSpacing = 4
        
        label.textColor = UIColor(red: 102.0/255, green: 117.0/255, blue: 127.0/255, alpha: 1)
        label.setNormalColor(for: .hashtag, color: UIColor(red: 85.0/255, green: 172.0/255, blue: 238.0/255, alpha: 1))
        label.setNormalColor(for: .mention, color: UIColor(red: 238.0/255, green: 85.0/255, blue: 96.0/255, alpha: 1))
        label.setNormalColor(for: .url, color: UIColor(red: 85.0/255, green: 238.0/255, blue: 151.0/255, alpha: 1))
        label.setSelectedColor(for: .url, color: UIColor(red: 82.0/255, green: 190.0/255, blue: 41.0/255, alpha: 1))

        // Custom types
        label.setNormalColor(for: customType, color: UIColor.purple)
        label.setSelectedColor(for: customType, color: UIColor.green)
        label.setNormalColor(for: customType2, color: UIColor.magenta)
        label.setSelectedColor(for: customType2, color: UIColor.green)
        
        label.configureLinkAttribute = { (type, attributes, isSelected) in
            var atts = attributes
            switch type {
            case customType3:
                atts[NSAttributedString.Key.font] = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.boldSystemFont(ofSize: 14)
            default: ()
            }
            
            return atts
        }

        label.handleMentionTap { self.alert("Mention", message: $0) }
        label.handleHashtagTap { self.alert("Hashtag", message: $0) }
        label.handleURLTap { self.alert("URL", message: $0.absoluteString) }

        label.handleCustomTap(for: customType) { self.alert("Custom type", message: $0) }
        label.handleCustomTap(for: customType2) { self.alert("Custom type", message: $0) }
        label.handleCustomTap(for: customType3) { self.alert("Custom type", message: $0) }
    }

    func alert(_ title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        vc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(vc, animated: true, completion: nil)
    }
}
