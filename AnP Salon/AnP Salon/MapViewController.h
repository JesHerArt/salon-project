//
//  MapViewController.h
//  AnP Salon
//
//  Created by alain alberto alzuri on 4/1/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController{
    IBOutlet UIWebView* webView;
}
@property UIWebView* webView;
@property (weak, nonatomic) IBOutlet UIButton *reviewBtn;
@property (weak, nonatomic) IBOutlet UITextField *reviewTxt;

@end