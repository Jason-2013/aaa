//
//  PDFView.h
//  Biorhythm
//
//  Created by Jianhai Yu on 14/8/13.
//  Copyright (c) 2014年 JianhaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFView : UIView
{
    CGPDFDocumentRef pdf;
}

- (void)drawInContext:(CGContextRef)context;

@end
