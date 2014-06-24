//
//  RootViewController.h
//  RTFReader
//
//  Created by Hiren J. Bhadreshwara on 30/05/14.
//  Copyright (c) 2014 digicorp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignatureViewController.h"
#import "BNHtmlPdfKit.h"

@interface RootViewController : UIViewController<UIWebViewDelegate, UIScrollViewDelegate,SignatureViewControllerDelegate,UIGestureRecognizerDelegate,BNHtmlPdfKitDelegate>
{
    IBOutlet UIWebView *webVw;
//    int height;
    IBOutlet UIButton *clearBtn;
    IBOutlet UIButton *PDFbtn;
    IBOutlet UITextView *txtVw;
	NSString *pdfPath;    
}
@property (nonatomic, retain) NSString *pdfPath;
@property (nonatomic, strong) NSString *pdfFilePath;
@property (strong, nonatomic) IBOutlet SignatureViewController *signatureController;

-(IBAction)generatePDF:(id)sender;

@end
