//
//  ViewController.h
//  demo_bitmap
//
//  Created by Lwgfangz on 13-5-30.
//  Copyright (c) 2013年 Lwgfangz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *ibTextField;
@property (retain, nonatomic) IBOutlet UIScrollView *ibScrollView;
@property (retain, nonatomic) IBOutlet UIImageView *ibScreenImageView;

- (IBAction)EditingDidEndOnExit:(id)sender;
@end
