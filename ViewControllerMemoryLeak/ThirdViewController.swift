//
//  ThirdViewController.swift
//  ViewControllerMemoryLeak
//
//  Created by Saidi Farid on 3/17/16.
//  Copyright © 2016 Fafrotskies. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController
{

    @IBOutlet weak var spaceshipMiddle:     UIImageView!
    @IBOutlet weak var spaceshipTopRight:   UIImageView!
    @IBOutlet weak var spaceshipBottomLeft: UIImageView!
    @IBOutlet weak var spaceshipBottomRight:UIImageView!

    var setViews        = false
    var animOver        = false

    var imgArray        : [UIImageView]!

    var middlePoint     : CGPoint!
    var topRightPoint   : CGPoint!
    var bottomLeftPoint : CGPoint!
    var bottomRightPoint: CGPoint!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        imgArray = [spaceshipMiddle, spaceshipTopRight, spaceshipBottomLeft, spaceshipBottomRight]

    }

    override func viewDidLayoutSubviews()
    {
        if (!setViews)
        {
            setViews = true

            prepareSpaceshipsForAnimation()
        }
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)

        if (!animOver)
        {
            animOver = true

            animateSpaceships()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(sender: UIButton)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }


    deinit
    {
        imgArray.removeAll()
        imgArray                = nil
        spaceshipMiddle         = nil
        spaceshipTopRight       = nil
        spaceshipBottomLeft     = nil
        spaceshipBottomRight    = nil

        print("Third ViewController De-Inited Successfully!")
    }

    func prepareSpaceshipsForAnimation()
    {
        view.userInteractionEnabled = false

        middlePoint                 = spaceshipMiddle       .center
        topRightPoint               = spaceshipTopRight     .center
        bottomLeftPoint             = spaceshipBottomLeft   .center
        bottomRightPoint            = spaceshipBottomRight  .center

        for image in imgArray
        {
            image.center            = middlePoint
        }

        scaleSpaceshipsDown()

        view.layoutIfNeeded()
    }

    func animateSpaceships()
    {
        UIView.animateWithDuration(0.6, animations:
        { () -> Void in
            self.scaleSpaceshipsUp()
            self.repositionSpaceships()
        })
        { (finished) -> Void in
            self.view.userInteractionEnabled = true
        }
    }

    func repositionSpaceships()
    {
        spaceshipMiddle     .center = middlePoint
        spaceshipTopRight   .center = topRightPoint
        spaceshipBottomLeft .center = bottomLeftPoint
        spaceshipBottomRight.center = bottomRightPoint
    }

    func scaleSpaceshipsDown()
    {
        for image in imgArray
        {
            image       .transform  = CGAffineTransformMakeScale(0.1, 0.1)
        }
    }

    func scaleSpaceshipsUp()
    {
        for image in imgArray
        {
            image       .transform  = CGAffineTransformMakeScale(1, 1)
        }
    }
}
