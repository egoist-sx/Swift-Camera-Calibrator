//
//  CVWrapper.h
//  SFM-iOS
//
//  Created by Xin Sun on 11/5/14.
//  Copyright (c) 2014 Xin Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//IMPORTANT! THIS FILE HAS TO BE PURE OBJECTIVE_C

@interface CVWrapper : NSObject
+ (void) calibrateWithImageArray:(NSArray*)images;
@end
