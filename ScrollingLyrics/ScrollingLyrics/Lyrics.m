//
//  Lyrics.m
//  ScrollingLyrics
//
//  Created by Tsihsin Lee on 2019/2/18.
//  Copyright © 2019 Tsihsin Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lyrics.h"

@interface Lyrics()

//@property (nonatomic, strong) NSMutableArray * lyricsArray;
{
   NSMutableArray * lyricsArray;
}
@end

@implementation Lyrics

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self importLyricsFile];
    }
    return self;
}

- (NSArray *)lyricsArray {
    return [lyricsArray copy];
}

- (void)importLyricsFile {
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource: @"Lyrics" ofType: @"txt"];
    NSError * error;
    NSString * fileContents = [NSString stringWithContentsOfFile: filePath encoding: NSUTF8StringEncoding error: &error];
    
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
    
    lyricsArray = [[fileContents componentsSeparatedByString: @"\n"] mutableCopy];
    
    NSInteger index = lyricsArray.count - 1;
    
    while ([lyricsArray[index] length] == 0) {
        [lyricsArray removeObjectAtIndex: index];
        index -= 1;
    }
    
    [lyricsArray addObject: @"- END -"];
}

@end
