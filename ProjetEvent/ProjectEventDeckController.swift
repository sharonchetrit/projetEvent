//
//  ProjectEventDeckController.swift
//  ProjetEvent
//
//  Created by Eric Shorr on 03/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit
import ViewDeck

class ProjectEventDeckController: IIViewDeckController
{
    lazy var menuController : UIViewController = {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Menu", bundle: Bundle.main)
        
        return storyboard.instantiateInitialViewController()!
        
    }()
    
    lazy var eventController : UIViewController = {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Event", bundle: Bundle.main)
        
        return storyboard.instantiateInitialViewController()!
        
    }()
    
    lazy var profileController : UIViewController = {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: Bundle.main)
        
        return storyboard.instantiateInitialViewController()!
        
    }()
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.leftViewController = self.menuController
        self.centerViewController = self.eventController
        self.rightViewController = nil
        
        self.isPanningEnabled = true
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}
