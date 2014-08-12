//
//  PDFView.m
//  Biorhythm
//
//  Created by Jianhai Yu on 14/8/13.
//  Copyright (c) 2014年 JianhaiYu. All rights reserved.
//

#import "PDFView.h"

@implementation PDFView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (self != nil) {
            CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("Document.pdf"), NULL, NULL);
            pdf = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
            CFRelease(pdfURL);
        }
    }
    return self;
}
- (void)drawInContext:(CGContextRef)context
{
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGPDFPageRef page = CGPDFDocumentGetPage(pdf, 1);
    CGContextSaveGState(context);
    CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFCropBox,self.bounds, 0, true);
    CGContextConcatCTM(context, pdfTransform);
    CGContextDrawPDFPage(context, page);
    CGContextRestoreGState(context);
}
- (void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
