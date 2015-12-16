//
//  ZYProgressBarV2.h
//  FlagProgressBar
//
//  Created by lzy on 15/12/16.
//  Copyright © 2015年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KEY_FLAGIMAGE       @"KEY_FLAGIMAGE"            //UIImage
#define KEY_TITLE           @"KEY_TITLE"                //NSString
#define KEY_INDEX           @"KEY_INDEX"                //NSString
#define KEY_OFFSET_X        @"KEY_OFFSET_X"             //NSString
#define KEY_OFFSET_Y        @"KEY_OFFSET_Y"             //NSString
#define KEY_TITLE_COLOR     @"KEY_TITLE_COLOR"          //UIColor


#define KEY_ATTRIBUTED_STRING   @"KEY_ATTRIBUTED_STRING"//NSAttributedString


@interface ZYProgressBarV2 : UIView

- (void)updateBarWithIndex:(int)index
                     volum:(int)volum
            holderBarColor:(UIColor *)holderBarColor
           contentBarColor:(UIColor *)contentBarColor
          imageTitleOffSet:(CGPoint)imageTitleOffSet
           imageTitleColor:(UIColor *)imageTitleColor
   flagImageDictionaryList:(NSArray *)flagImageDictionaryList
 bottomFlagTitleDictionary:(NSDictionary *)bottomFlagTitleDictionary;


@end