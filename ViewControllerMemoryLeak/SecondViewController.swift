//
//  SecondViewController.swift
//  ViewControllerMemoryLeak
//
//  Created by Saidi Farid on 3/17/16.
//  Copyright © 2016 Fafrotskies. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{

    @IBOutlet weak var nextButton:          UIButton!
    @IBOutlet weak var spaceshipTopRight:   UIImageView!
    @IBOutlet weak var spaceshipBottomLeft: UIImageView!
    @IBOutlet weak var spaceshipBottomRight:UIImageView!
    @IBOutlet weak var collection:          UICollectionView!

    var setViews        = false
    var animOver        = false

    var imgArray        : [UIImageView]!

    var middlePoint     : CGPoint!
    var topRightPoint   : CGPoint!
    var bottomLeftPoint : CGPoint!
    var bottomRightPoint: CGPoint!

    var bigImageArray   : [UIImage]!

    let reuseIdentifier = "Cell"

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Second ViewController Loaded Successfully!")

        imgArray        = [spaceshipTopRight, spaceshipBottomLeft, spaceshipBottomRight]
        bigImageArray   = []

        for _ in 1...1000
        {
            let newImage = UIImage(named: "Spaceship")!
            bigImageArray.append(newImage)
        }

        collection.delegate     = self
        collection.dataSource   = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if (!setViews)
        {
            setViews = true

            prepareSpaceshipsForAnimation()
        }
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)

        if(!animOver)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    deinit
    {
        imgArray                .removeAll()
        bigImageArray           .removeAll()
        bigImageArray           = nil
        imgArray                = nil
        nextButton              = nil
        spaceshipTopRight       = nil
        spaceshipBottomLeft     = nil
        spaceshipBottomRight    = nil
        print("Second ViewController De-Inited Successfully!")
    }

    func prepareSpaceshipsForAnimation()
    {
        view.userInteractionEnabled = false

        middlePoint                 = nextButton            .center
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

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return bigImageArray.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)

        if let image = cell.subviews.first?.subviews.first as? UIImageView
        {
            image.image = bigImageArray[indexPath.item]
        }

        return cell
    }
}
