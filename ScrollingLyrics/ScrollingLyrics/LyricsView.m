//
//  LyricsView.m
//  ScrollingLyrics
//
//  Created by Tsihsin Lee on 2019/2/15.
//  Copyright © 2019 Tsihsin Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LyricsView.h"
#import "LyricsLayer.h"

@interface LyricsView()

@property (strong, nonatomic) NSMutableArray * layerArray;
@property double positionY;

@end

@implementation LyricsView

- (instancetype)initWithFrame: (CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {

        [self setBackgroundColor: [UIColor blackColor]];
        [self addLyricsContentView];
    }
    return self;
}

- (void)addBlurView {
    
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.backgroundColor = [UIColor blackColor];
        
        UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleDark];
        UIVisualEffectView * blurEffectView = [[UIVisualEffectView alloc] initWithEffect: blurEffect];
        blurEffectView.frame = self.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview: blurEffectView];
    } else {
        self.backgroundColor = [UIColor blackColor];
    }
}

- (void)addLyricsContentView {
    
    self.lyricsContentView = [UIView new];
    [self.lyricsContentView setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.lyricsContentView setBackgroundColor: [UIColor clearColor]];
    [self addSubview: self.lyricsContentView];

    [self addConstraint: [NSLayoutConstraint constraintWithItem: self.lyricsContentView
                                                                 attribute: NSLayoutAttributeTop
                                                                 relatedBy: NSLayoutRelationEqual
                                                                    toItem: self
                                                                 attribute: NSLayoutAttributeTop
                                                                multiplier: 1
                                                                  constant: 0]];
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem: self.lyricsContentView
                                                                 attribute: NSLayoutAttributeBottom
                                                                 relatedBy: NSLayoutRelationEqual
                                                                    toItem: self
                                                                 attribute: NSLayoutAttributeBottom
                                                                multiplier: 1
                                                                  constant: 0]];
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem: self.lyricsContentView
                                                      attribute: NSLayoutAttributeLeadingMargin
                                                      relatedBy: NSLayoutRelationEqual
                                                         toItem: self
                                                      attribute: NSLayoutAttributeLeadingMargin
                                                     multiplier: 1
                                                       constant: 0]];
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem: self.lyricsContentView
                                                      attribute: NSLayoutAttributeTrailingMargin
                                                      relatedBy: NSLayoutRelationEqual
                                                         toItem: self
                                                      attribute: NSLayoutAttributeTrailingMargin
                                                     multiplier: 1
                                                       constant: 0]];
    [self layoutIfNeeded];
}

- (void)addLyricsLayersWith: (NSArray *)lyricsArray {
    
    NSMutableArray * array = [NSMutableArray arrayWithArray: lyricsArray];
    int i = 0;
    CGSize lyricsLayerSize = self.lyricsContentView.frame.size;
    CGFloat textLayerHeight = 30.0;

    while (array.count) {
        
        LyricsLayer * textLayer = [[LyricsLayer alloc] init];
        [textLayer setFrame: CGRectMake(0, textLayerHeight * i, lyricsLayerSize.width, textLayerHeight)];
        [textLayer setString: array[0]];
        [textLayer setFontSize: 20];
        [textLayer setAlignmentMode: kCAAlignmentCenter];
        
        UIAccessibilityElement *anElement = [[UIAccessibilityElement alloc]
                                             initWithAccessibilityContainer:self];
        anElement.accessibilityLabel = lyricsArray[i];
        anElement.accessibilityIdentifier = [NSString stringWithFormat:@"Lyrics %lu", (unsigned long)i];
        anElement.accessibilityTraits = UIAccessibilityTraitNone;
        textLayer.accessibilityElement = anElement;
        
        [self.lyricsContentView.layer addSublayer: textLayer];
        
        [array removeObjectAtIndex: 0];
        i ++;
    }
    
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
    
    self.lyricsContentView.clipsToBounds = YES;
    self.layerArray = [NSMutableArray arrayWithArray: self.lyricsContentView.layer.sublayers];
    self.positionY = [self.layerArray[8] position].y;
}

- (void)highlightLyrics: (CATextLayer *)layer with: (BOOL)isHighlight {
    
    if (!isHighlight) {
        [layer setBackgroundColor: [UIColor clearColor].CGColor];
        [layer setForegroundColor: [UIColor whiteColor].CGColor];
    
    } else {
        [layer setBackgroundColor: [UIColor whiteColor].CGColor];
        [layer setForegroundColor: [UIColor blackColor].CGColor];
    }
}

- (void)addMoveAnimation: (CATextLayer *)layer {
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath: @"position"];
    animation.fromValue = [layer valueForKey: @"position"];
    CGPoint point = CGPointMake(layer.position.x, layer.position.y - 30);
    animation.toValue = [NSValue valueWithCGPoint: point];
    layer.position = point;
    [layer addAnimation: animation forKey: @"position"];
}

- (void)startLyrics {
    
    
    CATextLayer * layer = self.layerArray[8];

    while ([[layer string] length] == 0) {
        [self scrollLyrics];
    }
    
    [self highlightLyrics: layer with: YES];
}

- (BOOL)isLastLayer: (CATextLayer *)layer {
    
    NSString * lastLayerString = [self.layerArray.lastObject string];
    
    if ([[layer string] isEqualToString: lastLayerString]) {
        return YES;
    }
    return NO;
}

- (BOOL)scrollLyrics {
    
    CATextLayer * highlightLayer;
    
    for (CATextLayer * layer in self.layerArray) {
        if (layer.position.y == self.positionY) {
            [self highlightLyrics: layer with: NO];
        }
        
        [self addMoveAnimation: layer];
        
        if (layer.position.y == self.positionY) {
            [self highlightLyrics: layer with: YES];
            highlightLayer = layer;
        }
    }
    
    NSInteger length = [[highlightLayer string] length];
    if (length == 0) {
        NSLog(@"EMPTY!!!!!!!!!!!!!");
        [self scrollLyrics];
    }
    
    return [self isLastLayer: highlightLayer];
}

- (BOOL)isAccessibilityElement
{
    return NO;
}

- (NSInteger)accessibilityElementCount
{
    return [self.layerArray count];
}

- (id)accessibilityElementAtIndex:(NSInteger)index
{
    LyricsLayer *aLayer = self.layerArray[index];
    CGRect frame = aLayer.frame;
    aLayer.accessibilityElement.accessibilityFrame = [[UIApplication sharedApplication].keyWindow convertRect:frame fromView:self];
    return aLayer.accessibilityElement;
}

- (NSInteger)indexOfAccessibilityElement:(id)element
{
    NSInteger index = 0;
    for (LyricsLayer *aLayer in self.layerArray) {
        if ([aLayer.accessibilityElement isEqual:element]) {
            return index;
        }
        index++;
    }
    return NSNotFound;
}

@end
