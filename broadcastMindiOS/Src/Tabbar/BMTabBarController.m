//
//  BMTabBarController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 6/2/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMTabBarController.h"

@interface BMTabBarController () <UITabBarControllerDelegate>

@end

@implementation BMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Essential methods

- (void)setupView
{
    // Set up foundational style for tab bar controller
    self.tabBar.translucent = NO;
    //    self.tabBar.tintColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor whiteColor]; //for selected image color
    self.tabBar.barTintColor = [UIColor whiteColor];//for no select background color
    self.intendedSelectedIndex = NSNotFound;
    self.delegate = self;
}



- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if ([self tabBarController:self shouldSelectViewController:self.viewControllers[selectedIndex]]) {
        [super setSelectedIndex:selectedIndex];
        self.previousSelectedIndex = self.currentSelectedIndex;
        self.currentSelectedIndex = selectedIndex;
        self.intendedSelectedIndex = NSNotFound;
    }
}


- (void)selectIntendedIndex
{
    if (self.intendedSelectedIndex != NSNotFound) {
        NSUInteger index = self.intendedSelectedIndex;
        self.intendedSelectedIndex = NSNotFound;
        [self setSelectedIndex:index];
    }
}

- (void)resetIntendedIndex
{
    self.intendedSelectedIndex = NSNotFound;
}



#pragma mark - UITabBarControllerDelegate delegate methods

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{

    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    self.previousSelectedIndex = self.currentSelectedIndex;
    self.currentSelectedIndex = [self.viewControllers indexOfObject:viewController];
    self.intendedSelectedIndex = NSNotFound;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSUInteger indexOfTab = [[tabBar items] indexOfObject:item];
    self.currentSelectedIndex = indexOfTab;
}

#pragma mark - PostViewController delegate function
- (void)dismissViewController:(UIViewController *) viewController presentViewController:(UIViewController *)presentViewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (presentViewController) {
            [self presentViewController:presentViewController animated:YES completion:nil];
        }
    }];
}

- (void)dismissViewController:(UIViewController *) viewController pushViewController:(UIViewController *)pushViewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (pushViewController) {
            [(UINavigationController *)self.selectedViewController pushViewController:pushViewController animated:YES];
        }
    }];
}

#pragma mark - Interface Orientation

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    //fix iOS 8 rotate issue
    //Do not call [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    [self.selectedViewController viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

//- (void)viewWillLayoutSubviews
//{
//    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
//    tabFrame.size.height = 65.0f;
//    tabFrame.origin.y = self.view.frame.size.height - tabFrame.size.height;
//    self.tabBar.frame = tabFrame;
//}
@end
