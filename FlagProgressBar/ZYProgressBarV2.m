//
//  ZYProgressBarV2.m
//  FlagProgressBar
//
//  Created by lzy on 15/12/16.
//  Copyright © 2015年 lzy. All rights reserved.
//

#import "ZYProgressBarV2.h"
#import <CoreText/CTLine.h>

#define MARGIN_CELL 3.0f
#define HEIGHT_CELL 5.0f
#define SPACE_BORDER 5.0f
#define FONT_SIZE_FLAGIMAGE_TITLE 10.0f
@interface ZYProgressBarV2()

@property (assign, nonatomic) CGRect contentRect;
@property (assign, nonatomic) CGFloat cellWidth;
@property (assign, nonatomic) CGContextRef context;

@property (assign, nonatomic) int volume;
@property (assign, nonatomic) int index;
@property (strong, nonatomic) UIColor *holderBarColor;
@property (strong, nonatomic) UIColor *contentBarColor;
@property (assign, nonatomic) CGPoint imageTitleOffSet;
@property (strong, nonatomic) UIColor *imageTitleColor;
@property (strong, nonatomic) NSArray *flagImageDictionaryList;
@property (strong, nonatomic) NSDictionary *bottomFlagTitleDictionary;

@property (assign, nonatomic) CGFloat progressBarOriginY;
@end

@implementation ZYProgressBarV2

//如需在非xib使用，补上init方法
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundColor:[UIColor clearColor]];
    
    //TODO: default值，使用时请修改
    self.volume = 6;
    self.index = 0;
    self.holderBarColor = [UIColor clearColor];
    self.imageTitleOffSet = CGPointMake(0, -2);
    
    //TODO:进度条初始位置
    self.progressBarOriginY = self.bounds.size.height - HEIGHT_CELL;
}

- (void)updateBarWithIndex:(int)index
                     volum:(int)volum
            holderBarColor:(UIColor *)holderBarColor
           contentBarColor:(UIColor *)contentBarColor
          imageTitleOffSet:(CGPoint)imageTitleOffSet
           imageTitleColor:(UIColor *)imageTitleColor
   flagImageDictionaryList:(NSArray *)flagImageDictionaryList
 bottomFlagTitleDictionary:(NSDictionary *)bottomFlagTitleDictionary
{
    self.index = index;
    self.volume = volum;
    self.holderBarColor = holderBarColor;
    self.contentBarColor = contentBarColor;
    self.imageTitleOffSet = imageTitleOffSet;
    self.imageTitleColor = imageTitleColor;
    self.flagImageDictionaryList = flagImageDictionaryList;
    self.bottomFlagTitleDictionary = bottomFlagTitleDictionary;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.context = UIGraphicsGetCurrentContext();
    
    //drawBottomFlagTitle
    if (self.bottomFlagTitleDictionary != nil) {
        NSAttributedString *attributedStr = [self.bottomFlagTitleDictionary objectForKey:KEY_ATTRIBUTED_STRING];
        CGFloat offsetX = [[self.bottomFlagTitleDictionary objectForKey:KEY_OFFSET_X] floatValue];
        CGFloat offsetY = [[self.bottomFlagTitleDictionary objectForKey:KEY_OFFSET_Y] floatValue];
        [self drawBottomFlagTitleWithAttributeString:attributedStr offSet:CGPointMake(offsetX, offsetY)];
    }
    
    //drawProgressBar
    [self drawCellWithIndex:_volume volume:_volume color:self.holderBarColor];
    [self drawCellWithIndex:_index volume:_volume color:self.contentBarColor];
    
    //drawFlagImage
    for (NSDictionary *dict in _flagImageDictionaryList) {
        UIImage *image = [dict objectForKey:KEY_FLAGIMAGE];
        NSString *title = [dict objectForKey:KEY_TITLE];
        int index = [[dict objectForKey:KEY_INDEX] intValue];
        CGFloat offsetX = [[dict objectForKey:KEY_OFFSET_X] floatValue];
        CGFloat offsetY = [[dict objectForKey:KEY_OFFSET_Y] floatValue];
        CGPoint offset = CGPointMake(offsetX, offsetY);
        [self drawFlagImage:image title:title titleColor:_imageTitleColor index:index offset:offset];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentRect = self.bounds;
    self.cellWidth = (self.contentRect.size.width - MARGIN_CELL * (_volume - 1) - 2 * SPACE_BORDER) / _volume;
    self.context = UIGraphicsGetCurrentContext();
}

- (CGFloat)cellOriginXWithCellWidth:(CGFloat)cellWidth Index:(int)index volume:(int)volume {
    return SPACE_BORDER + index * (MARGIN_CELL + cellWidth);
}

- (void)drawCellWithIndex:(int)index volume:(int)volume color:(UIColor *)color {
    //裁剪圆角画布
    CGContextSaveGState(self.context);
    CGRect rounderRect = CGRectMake(SPACE_BORDER, self.progressBarOriginY, self.contentRect.size.width - 2 * SPACE_BORDER, HEIGHT_CELL);
    UIBezierPath *cutPath = [UIBezierPath bezierPathWithRoundedRect:rounderRect cornerRadius:HEIGHT_CELL/2];
    [cutPath addClip];
    
    //作画
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    UIBezierPath *beginPath = [path copy];
    CGFloat pointY = _progressBarOriginY + 0.5 * HEIGHT_CELL;
    
    for (int i = 0; i < index; i ++) {
        [path moveToPoint:CGPointMake([self cellOriginXWithCellWidth:_cellWidth Index:i volume:volume], pointY)];
        [path addLineToPoint:CGPointMake((path.currentPoint.x + _cellWidth), pointY)];
    }
    
    [color setStroke];
    [path setLineWidth:HEIGHT_CELL];
    //    [path stroke];
    shapeLayer.path = path.CGPath;
    shapeLayer.frame = self.bounds;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineWidth = HEIGHT_CELL;
    
    //    CGContextRestoreGState(self.context);
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    shapeLayer.strokeEnd = 1.0f;
    [CATransaction commit];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    pathAnimation.fromValue = @(0);
    pathAnimation.toValue = @(1);
    pathAnimation.duration = 1;
    if (index != volume) {
        [shapeLayer addAnimation:pathAnimation forKey:NSStringFromSelector(@selector(strokeEnd))];
    }
    [self.layer addSublayer:shapeLayer];
    CGContextRestoreGState(self.context);
}

//default flagImage above the progressBar
- (void)drawFlagImage:(UIImage *)flagImage title:(NSString *)title titleColor:(UIColor *)titleColor index:(int)index offset:(CGPoint)offset {
    CGSize imageSize = flagImage.size;
    CGFloat flagCenterX = [self cellOriginXWithCellWidth:_cellWidth Index:index volume:_volume];
    
    CGRect imageRect = CGRectMake(flagCenterX - imageSize.width/2 - MARGIN_CELL/2 + offset.x, self.progressBarOriginY - imageSize.height + offset.y, imageSize.width, imageSize.height);
    
    CGContextSaveGState(self.context);
    [flagImage drawInRect:imageRect];
    CGContextRestoreGState(self.context);
    
    [self drawFlagImageTitle:title color:titleColor imageRect:imageRect offSet:_imageTitleOffSet];
}

- (void)drawFlagImageTitle:(NSString *)title color:(UIColor *)color imageRect:(CGRect)imageRect offSet:(CGPoint)offSet {
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:FONT_SIZE_FLAGIMAGE_TITLE], NSFontAttributeName, paragraph, NSParagraphStyleAttributeName, color, NSForegroundColorAttributeName, nil];
    
    CGSize titleSize = [title sizeWithAttributes:attribute];
    
    CGFloat fontOriginX = imageRect.origin.x + (imageRect.size.width - titleSize.width)/2 + offSet.x;
    CGFloat fontOriginY = imageRect.origin.y + (imageRect.size.height - titleSize.height)/2 + offSet.y;
    CGRect fontRect = CGRectMake(fontOriginX, fontOriginY, titleSize.width, titleSize.height);
    
    [title drawInRect:fontRect withAttributes:attribute];
}

- (void)drawBottomFlagTitleWithAttributeString:(NSAttributedString *)attributeString offSet:(CGPoint)offSet {
    
    //TODO: 例子：写死
    //    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"4/6"];
    //    [attributeStr addAttribute:NSForegroundColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, 1)];
    //    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.0f] range:NSMakeRange(0, 1)];
    //
    //    [attributeStr addAttribute:NSForegroundColorAttributeName value:(id)[UIColor yellowColor].CGColor range:NSMakeRange(1, 2)];
    //    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.0f] range:NSMakeRange(1, 2)];
    
    
    CGSize titleSize = attributeString.size;
    CGFloat titleOriginX = [self cellOriginXWithCellWidth:_cellWidth Index:_index volume:_volume] - 0.5 * titleSize.width + offSet.x;
    CGFloat titleOriginY = self.bounds.size.height - titleSize.height;
    CGRect titleRect = CGRectMake(titleOriginX, titleOriginY, titleSize.width, titleSize.height);
    
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attributeString);
    CGContextSaveGState(_context);
    CGContextSetTextPosition(_context, titleOriginX, titleOriginY);
    CGContextTranslateCTM(_context, 0, self.bounds.size.height);//3
    CGContextScaleCTM(_context, 1.0, -1.0);//2
    CGContextTranslateCTM(_context, 0, (self.bounds.size.height - CGRectGetMaxY(titleRect) - CGRectGetMinY(titleRect)));
    CTLineDraw(line, _context);
    CGContextRestoreGState(_context);
    
    self.progressBarOriginY = self.bounds.size.height - titleSize.height - offSet.y - HEIGHT_CELL;
    //重画
    [self setNeedsDisplay];
}


@end

