//
//  LoginViewController.h
//  AnP Salon
//
//  
//  Copyright © 2016 TeamD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
    UIButton* loginBtn;
    __weak IBOutlet UIView *viewLoginFB;
    
}

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *email;
@property IBOutlet UIImageView *imgView;
@property IBOutlet UILabel *lblTxt;
@property IBOutlet UILabel *lblTxt2;

@end
