//
//  CameraViewController.h
//  AnP Salon
//
//  Created by alain alberto alzuri on 4/23/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface CameraViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider * slider;;
@property (weak, nonatomic) IBOutlet UITextView * reviewTxt;
@property (weak, nonatomic) UIImage *image;
@property (weak, nonatomic) NSString * blobStr;

-(IBAction)openCamera:(id)sender;
-(IBAction)goBack:(id)sender;
-(IBAction)sharePic:(id)sender;

@end
