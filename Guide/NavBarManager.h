//
//  NavBarManager.h
//  Guide
//
//  Created by Scott Andrus on 7/15/12.
//  Copyright (c) 2012 Vanderbilt University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavBarManager : NSObject

+ (UINavigationBar *)setLogo:(UIImageView *)logo onNavBar:(UINavigationBar *)navBar;

+ (UINavigationBar *)removeLogoFromNavBar:(UINavigationBar *)navBar;

@end
