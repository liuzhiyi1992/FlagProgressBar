# FlagProgressBar
a progress bar(index, volume) with above image flag, and bottom title flag if you need


![Alt Text](https://raw.githubusercontent.com/liuzhiyi1992/FlagProgressBar/master/FlagProgressBar/image/display_two.gif)





#**explain：**
####the key of dictionary:
\#define KEY_FLAGIMAGE       @"KEY_FLAGIMAGE"          //UIImage
\#define KEY_TITLE           @"KEY_TITLE"                			//NSString
\#define KEY_INDEX           @"KEY_INDEX"                			//NSString
\#define KEY_OFFSET_X        @"KEY_OFFSET_X"            		//NSString
\#define KEY_OFFSET_Y        @"KEY_OFFSET_Y"             	//NSString
\#define KEY_TITLE_COLOR     @"KEY_TITLE_COLOR"       //UIColor
\#define KEY_ATTRIBUTED_STRING   @"KEY_ATTRIBUTED_STRING"//NSAttributedString

####PARA:
*index*：The total number of the progress bar

*volum*： The total number of the progress bar

*holderBarColor*：bar backgroundcolor

*contentBarColor*：bar contentcolor

*imageTitleOffSet*：offset with the title in flagImage which above the progressBar(CGPoint)

*imageTitleColor*：color with the title in flagImage which above the progressBar

*flagImageDictionaryList*：a NSArray with flagImage dictionaries（contains:KEY_FLAGIMAGE, KEY_TITLE,KEY_INDEX,KEY_OFFSET_X,KEY_OFFSET_Y） example:
```
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
```


*bottomFlagTitleDictionary*：a NSDictionary with bottomFlagTitle which bottom the progressBar. example:

```
NSDictionary *bottomFlagTitleDict = [NSDictionary dictionaryWithObjectsAndKeys:attributeStr, KEY_ATTRIBUTED_STRING, @"0", KEY_OFFSET_X, @"2", KEY_OFFSET_Y, nil];
```




#**usage：**
The simplest method of use, add in or storyBoard xib ZYProgressBar, associated to. M file, so you will have a ZYProgressBar object, you can start the game happily!!
>If you want it to be animated, use ZYProgressBarV2


then， begin configure with the update method like this:

```
- (void)updateBarWithIndex:(int)index
                     volum:(int)volum
            holderBarColor:(UIColor *)holderBarColor
           contentBarColor:(UIColor *)contentBarColor
          imageTitleOffSet:(CGPoint)imageTitleOffSet
           imageTitleColor:(UIColor *)imageTitleColor
   flagImageDictionaryList:(NSArray *)flagImageDictionaryList
 bottomFlagTitleDictionary:(NSDictionary *)bottomFlagTitleDictionary;
```

that all !  
Your progressBar will work according to your rules。
> If you intend to use ZYProgressBar in the code without xib, you have to create an initializer,and implement "configureDefault" method in ZYProgressBar.m

###thanks ! 