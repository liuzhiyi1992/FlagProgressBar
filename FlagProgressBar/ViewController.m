//
//  ViewController.m
//  FlagProgressBar
//
//  Created by lzy on 15/12/16.
//  Copyright © 2015年 lzy. All rights reserved.
//

#import "ViewController.h"
#import "ZYProgressBar.h"
#import "ZYProgressBarV2.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet ZYProgressBar *progressBar;
@property (weak, nonatomic) IBOutlet ZYProgressBar *firstProgressBar;
@property (weak, nonatomic) IBOutlet ZYProgressBar *secondProgressBar;

@property (weak, nonatomic) IBOutlet ZYProgressBarV2 *version2Bar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    int index = 5;
    int volum = 7;
    
    UIColor *holderBarColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    UIColor *contentBarColor = [UIColor colorWithRed:122.3/255.0 green:163.0/255.0 blue:233.5/255.0 alpha:1.0];
    
    
#pragma mark - flagImageDictionaryList
    NSMutableDictionary *dict_one = [NSMutableDictionary dictionary];
    [dict_one setValue:[UIImage imageNamed:@"dialogButton_center_gray"] forKey:KEY_FLAGIMAGE];
    [dict_one setValue:@"及格" forKey:KEY_TITLE];
    [dict_one setValue:holderBarColor forKey:KEY_TITLE_COLOR];
    [dict_one setValue:@"3" forKey:KEY_INDEX];
    [dict_one setValue:@"0" forKey:KEY_OFFSET_X];
    [dict_one setValue:@"-5" forKey:KEY_OFFSET_Y];
    
    NSMutableDictionary *dict_two = [NSMutableDictionary dictionary];
    UIImage *image = [UIImage imageNamed:@"dialogButton_right_gray"];
    [dict_two setValue:image forKey:KEY_FLAGIMAGE];
    [dict_two setValue:@"满分" forKey:KEY_TITLE];
    [dict_two setValue:holderBarColor forKey:KEY_TITLE_COLOR];
    [dict_two setValue:@"7" forKey:KEY_INDEX];
    [dict_two setValue:[NSString stringWithFormat:@"%0.f", -image.size.width/2 + 2] forKey:KEY_OFFSET_X];
    [dict_two setValue:@"-5" forKey:KEY_OFFSET_Y];
    
    NSArray *flagImageList = [NSArray arrayWithObjects:dict_one, dict_two, nil];
    
    
#pragma mark - bottomFlagTitleDictionary
    UIColor *indexColor = [UIColor colorWithRed:120/255.0 green:163/255.0 blue:243/255.0 alpha:1.0];
    UIColor *volumColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1.0];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d/%d", index, volum]];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:(id)indexColor.CGColor range:NSMakeRange(0, 1)];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0f] range:NSMakeRange(0, 1)];
    
    [attributeStr addAttribute:NSForegroundColorAttributeName value:(id)volumColor.CGColor range:NSMakeRange(1, 2)];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12.0f] range:NSMakeRange(1, 2)];
    
    NSDictionary *bottomFlagTitleDict = [NSDictionary dictionaryWithObjectsAndKeys:attributeStr, KEY_ATTRIBUTED_STRING, @"0", KEY_OFFSET_X, @"2", KEY_OFFSET_Y, nil];
    
    [self.firstProgressBar updateBarWithIndex:index-4 volum:volum holderBarColor:holderBarColor contentBarColor:contentBarColor imageTitleOffSet:CGPointMake(0, -2) imageTitleColor:[UIColor whiteColor] flagImageDictionaryList:nil bottomFlagTitleDictionary:nil];
    
    [self.secondProgressBar updateBarWithIndex:index-2 volum:volum holderBarColor:holderBarColor contentBarColor:contentBarColor imageTitleOffSet:CGPointMake(0, -2) imageTitleColor:[UIColor whiteColor] flagImageDictionaryList:flagImageList bottomFlagTitleDictionary:nil];
    
    [self.progressBar updateBarWithIndex:index volum:volum holderBarColor:holderBarColor contentBarColor:contentBarColor imageTitleOffSet:CGPointMake(0, -2) imageTitleColor:[UIColor whiteColor] flagImageDictionaryList:flagImageList bottomFlagTitleDictionary:bottomFlagTitleDict];
    
    
    
#pragma mark - try to animated
    NSMutableAttributedString *otherAttributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d/%d", index+1, volum]];
    [otherAttributeStr addAttribute:NSForegroundColorAttributeName value:(id)indexColor.CGColor range:NSMakeRange(0, 1)];
    [otherAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0f] range:NSMakeRange(0, 1)];
    
    [otherAttributeStr addAttribute:NSForegroundColorAttributeName value:(id)volumColor.CGColor range:NSMakeRange(1, 2)];
    [otherAttributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12.0f] range:NSMakeRange(1, 2)];
    NSDictionary *otherBottomFlagTitleDict = [NSDictionary dictionaryWithObjectsAndKeys:otherAttributeStr, KEY_ATTRIBUTED_STRING, @"0", KEY_OFFSET_X, @"2", KEY_OFFSET_Y, nil];
    
    [self.version2Bar updateBarWithIndex:index+1 volum:volum holderBarColor:holderBarColor contentBarColor:contentBarColor imageTitleOffSet:CGPointMake(0, -2) imageTitleColor:[UIColor whiteColor] flagImageDictionaryList:flagImageList bottomFlagTitleDictionary:otherBottomFlagTitleDict];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
