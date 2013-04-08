//
//  WZRichTextVew.m
//  WZRichTextView
//
//  Created by Wei on 13-4-7.
//  Copyright (c) 2013年 Wei. All rights reserved.
//

#import "WZRichTextVew.h"
#import <CoreText/CoreText.h>
#import "MarkupParser.h"

#define REGEX_AT @"@([a-zA-Z0-9]+)"

@implementation WZRichTextVew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

#pragma mark - Private Method

- (void)analyzeContent:(NSString *)content byRegex:(NSString *)regex
{
    NSRange range;
    range = [content rangeOfString:regex options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        NSLog(@"String is %@", [content substringWithRange:range]);
    } else {
        NSLog(@"Not found.");
    }
}

#pragma mark -

- (void)setContent:(NSString *)content
{
    _content = content;
    
    // TODO:解析、刷新界面
    [self analyzeContent:content byRegex:REGEX_AT];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable(); //1
    CGPathAddRect(path, NULL, self.bounds);
    
//    NSAttributedString* attString = [[[NSAttributedString alloc] initWithString:@"Hello core text world!"] autorelease]; //2
    
    MarkupParser* p = [[[MarkupParser alloc] init] autorelease];
    NSAttributedString* attString = [p attrStringFromMarkup: @"Hello <font color=\"red\">core text <font color=\"blue\">world!"];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
    
    CTFrameDraw(frame, context); //4
    
    CFRelease(frame); //5
    CFRelease(path);
    CFRelease(framesetter);
}


@end
