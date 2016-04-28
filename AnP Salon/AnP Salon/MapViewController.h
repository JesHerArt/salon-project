//
//  MapViewController.h
//  AnP Salon
//
//  Created by alain alberto alzuri on 4/1/16.
//  Copyright © 2016 TeamD. All rights reserved.
//
//Alain
#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController{
    IBOutlet UIWebView* webView;
}
@property UIWebView* webView;
@property (weak, nonatomic) UIButton *cameraBtn;
@property (weak, nonatomic) UIButton *reviewBtn;

-(IBAction)ReviewClicked:(id)sender;
-(IBAction)CameraClicked:(id)sender;

@end