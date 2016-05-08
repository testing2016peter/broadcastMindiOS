//
//  PostArticleViewController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMInsertPostViewController.h"
#import "BMService.h"
#import "BMImageSelectViewController.h"
#import "BMCameraRollLib.h"

@interface BMInsertPostViewController () <BMImageSelectViewControllerDelegate>
@property (strong, nonatomic) NSMutableArray *progressList;
@property (strong, nonatomic) NSMutableArray *cameraObjectList;
@property (strong, nonatomic) NSMutableString *textViewText;
@end

@implementation BMInsertPostViewController

- (void)setupView
{
    self.textViewText = [NSMutableString string];
    self.progressList = [NSMutableArray array];
    self.cameraObjectList = [NSMutableArray array];
    self.contentTextView.placeholderColor = [UIColor blueColor];
    self.contentTextView.placeholderString = @"靠北事件";//

    self.containerView.layer.cornerRadius = 5;
    self.containerView.layer.masksToBounds = YES;
    self.view.backgroundColor = [UIColor clearColor];
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.view.backgroundColor = [UIColor clearColor];

        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        [self.view addSubview:blurEffectView];
        [self.view bringSubviewToFront:self.containerView];
    }
    else {
        self.view.backgroundColor = [UIColor blackColor];
    }
    [self.contentTextView becomeFirstResponder];

}
- (IBAction)tapCancelButton:(id)sender
{
    [self.contentTextView resignFirstResponder];
    if ([self.postArticleViewControllerDelegate respondsToSelector:@selector(tapPostArticleViewController:cancelButton:)]) {
        [self.postArticleViewControllerDelegate tapPostArticleViewController:self cancelButton:self.cancelButton];

    }
}

- (IBAction)tapSendButton:(id)sender
{

    [self.contentTextView resignFirstResponder];
    if ([self.postArticleViewControllerDelegate respondsToSelector:@selector(tapPostArticleViewController:contentText:sendButton:)]) {
        [self.postArticleViewControllerDelegate tapPostArticleViewController:self contentText:self.textViewText sendButton:self.sendButton];

    }
}

- (IBAction)tapImageButton:(id)sender
{
    BMImageSelectViewController *vc = [[BMImageSelectViewController alloc] init];
    vc.bmImageSelectViewControllerDelegate = self;

    [self presentViewController:vc animated:YES completion:nil];
}

- (void)BMImageSelectViewController:(BMImageSelectViewController *)bmImageSelectViewController selectedCameraRollImageObjects:(NSArray *)selectedCameraRollImageObjects
{
    if ([self.textViewText length] == 0) {
        self.textViewText = [NSMutableString stringWithFormat:@"%@", self.contentTextView.text];
    }

    [selectedCameraRollImageObjects enumerateObjectsUsingBlock:^(CameraRollImageObject * _Nonnull cameraRollImageObject, NSUInteger idx, BOOL * _Nonnull stop) {


        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = cameraRollImageObject.thumbnailImage;
        CGFloat oldWidth = textAttachment.image.size.width;
        CGFloat scaleFactor = oldWidth / (self.contentTextView.frame.size.width - 10);
        textAttachment.image = [UIImage imageWithCGImage:textAttachment.image.CGImage scale:scaleFactor orientation:UIImageOrientationUp];
        NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
        NSMutableAttributedString *add =[[NSMutableAttributedString alloc] initWithAttributedString: self.contentTextView.attributedText];
        [add appendAttributedString:attrStringWithImage];

        [add appendAttributedString: [[NSAttributedString alloc] initWithString:@"\n\n"]];

        self.contentTextView.attributedText = add;
        [self.textViewText appendFormat:@"\n\n%@", cameraRollImageObject.localIdentifier];

        [BMCameraRollLib imageWithLocalIdentifier:cameraRollImageObject.localIdentifier useOriginalSize:YES complectedBlock:^(UIImage *image) {
            NSProgress *progress;
            [[BMService sharedInstance] uploadImage:image progress:&progress success:^(AFHTTPRequestOperation *operation, id response) {
                NSLog(@"sucess:%@", response);
                NSString *string  = [self.textViewText stringByReplacingOccurrencesOfString:cameraRollImageObject.localIdentifier withString:response[@"imageUrl"]];
                self.textViewText = [NSMutableString stringWithFormat:@"%@", string];
            } failure:^(AFHTTPRequestOperation *operation, NSError *err) {

                NSLog(@"err:%@", err);
            }];
            [progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:NULL];
            [self addCameraObjectListWithObject:cameraRollImageObject progress:progress];
        }];

        // self.contentTextView.text = [NSString stringWithFormat:@"%@\n\n%@",  self.contentTextView.text, cameraRollImageObject.localIdentifier];


    }];
    [bmImageSelectViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)addCameraObjectListWithObject:(CameraRollImageObject *)object progress:(NSProgress *)progress
{
    [self.cameraObjectList addObject:object];
    [self.progressList addObject:progress];
}

- (CameraRollImageObject *)cameraObjectIndexWithProgress:(NSProgress *)progress
{
    return [self.cameraObjectList objectAtIndex:[self.progressList indexOfObject:progress]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{

    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]]) {
        NSLog(@"change:%@", change);
        NSLog(@"cameraObjectIndexWithProgress:%@", [self cameraObjectIndexWithProgress:object]);
    }
}
- (void)tapCancelWithBMImageSelectViewController:(BMImageSelectViewController *)bmImageSelectViewController
{
    [bmImageSelectViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
