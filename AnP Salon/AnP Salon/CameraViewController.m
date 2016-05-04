//
//  CameraViewController.m
//  AnP Salon
//
//  Created by alain alberto alzuri on 4/23/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "CameraViewController.h"
#import "User.h"

@interface CameraViewController ()

@end

@implementation CameraViewController
{
    User *user;
}

@synthesize imageView, image, blobStr, reviewTxt, slider;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageView.image = [UIImage imageNamed:@"stockPhoto.gif"];
}



- (void)viewDidUnload
{
    [self setImageView:nil];
    [super viewDidUnload];

}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    // Does hardware support a camera
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    // Create the picker object
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    // Specify the types of camera features available
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    // Displays a control that allows the user to take pictures only.
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    // Specify which object contains the picker's methods
    cameraUI.delegate = delegate;
    
    // Picker object view is attached to view hierarchy and displayed.
    [controller presentViewController: cameraUI animated: YES completion: nil ];
    return YES;
}



- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    // Create an image and store the acquired picture
    
    UIImage  *imageToSave;
    imageToSave = (UIImage *) [info objectForKey:
                               UIImagePickerControllerOriginalImage];
    
    // Save the new image to the Camera Roll
    UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
    
    // View the image on screen
    //imageView.image = imageToSave;
    image = imageToSave;
    imageView.image = image;

    
    
    // Tell controller to remove the picker from the view hierarchy and release object.
    [self dismissViewControllerAnimated: YES completion: ^{[self doSomethingElse];} ];
}

- (void) doSomethingElse {
    NSLog(@"Camera Dismissed");
    
}

-(IBAction)sharePic:(id)sender{
    
    //****save image into DB *******
    
    if (image != NULL) {
        
        
        blobStr = [self encodeToBase64String:image];
        
        //creates user singleton
        user = [User userData];
        user.imgStr = blobStr;
        user.review = reviewTxt.text;
        user.rating = [NSNumber numberWithFloat:slider.value];
        
        //post to external DB
        
        NSDictionary *dict = @{@"photo" : user.imgStr,
                               @"user_id" : user.uId ,
                               @"comment" : user.review ,
                               @"rating"  : user.rating};
        
        NSData * jsonC = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        
        NSURL * url = [NSURL URLWithString:@"http://salonapi.jesherart.design/salon/review"];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPBody:jsonC];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"requestReply: %@", requestReply);
            
            
        }] resume];
        
        //return to mapview after posting
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
        [vc setSelectedIndex:3];
        
        [self presentViewController:vc animated:YES completion:nil];
        
        
    }
    
    
    
}

//open camera
- (IBAction)openCamera:(id)sender{
    [self startCameraControllerFromViewController : self usingDelegate:self];
    
}

//return to map controller
-(IBAction)goBack:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    [vc setSelectedIndex:3];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

//Encode image base64

- (NSString *)encodeToBase64String:(UIImage *)img {
    
    return [UIImageJPEGRepresentation(img,0.0) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

//Decode image from base64
- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

//dismiss keyboard on pressing return button
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


//dismiss keyboard
- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}

//dismiss keyboard

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [reviewTxt resignFirstResponder];
}





@end
