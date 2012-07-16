//
//  NavBarManager.m
//  Guide
//
//  Created by Scott Andrus on 7/15/12.
//  Copyright (c) 2012 Vanderbilt University. All rights reserved.
//

#import "NavBarManager.h"

@implementation NavBarManager

+ (UINavigationBar *)setLogo:(UIImageView *)logo onNavBar:(UINavigationBar *)navBar {
    // Set the logo on the navigation bar
    
    if ([[navBar subviews] count] > 2) {
        NSArray *navSubviews = [navBar subviews];
        
        for (UIView * subview in navSubviews) {
            if ([subview isKindOfClass:[UIImageView class]] && subview != [navSubviews objectAtIndex:0]) {
                [subview removeFromSuperview];
            }
        }
    }
    [navBar addSubview:logo];
    return navBar;
}

+ (UINavigationBar *)removeLogoFromNavBar:(UINavigationBar *)navBar {
    NSArray *navSubviews = [navBar subviews];
    //    NSLog(@"%@", navSubviews);
    for (UIView * subview in navSubviews) {
        if ([subview isKindOfClass:[UIImageView class]] && subview != [navSubviews objectAtIndex:0]) {
            [subview removeFromSuperview];
        }
    }
    return navBar;
}

@end
