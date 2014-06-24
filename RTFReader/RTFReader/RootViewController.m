//
//  RootViewController.m
//  RTFReader
//
//  Created by Hiren J. Bhadreshwara on 30/05/14.
//  Copyright (c) 2014 digicorp. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BNHtmlPdfKit.h"

#define kDefaultPageHeight 1024
#define kDefaultPageWidth  768
#define kMargin 50

@interface RootViewController ()
{
        BNHtmlPdfKit *htmlPdfKit;
        NSString *htmlString;
}
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)tapDetected2:(UITapGestureRecognizer *)tapRecognizer{
    NSLog(@"Self.view");
}
- (void)tapDetected3:(UITapGestureRecognizer *)tapRecognizer{
    NSLog(@"web view");
}


- (void)scrollVwSetDisable:(NSNotification *)notification{
    webVw.scrollView.scrollEnabled = NO;
}
- (void)scrollVwSetEnable:(NSNotification *)notification{
    webVw.scrollView.scrollEnabled = YES;
}


-(void)viewDidUnload{
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *rtfUrl = [[NSBundle mainBundle] URLForResource:@"TempLetter" withExtension:@".rtf"];
    NSString *str = @"http://demo.digi-corp.com/Clipboard/RTFFiles/192-655.rtf";
    NSURL *url1 = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url1];
    [webVw loadRequest:request];
    webVw.scrollView.delegate = self;
    [self.signatureController viewDidLoad];
    self.signatureController.delegate = self;
    
    htmlPdfKit = [[BNHtmlPdfKit alloc] init];
    htmlPdfKit.delegate = self;

/*
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.cancelsTouchesInView = NO;
    tapRecognizer.delegate = self;
    [self.signatureController.view addGestureRecognizer:tapRecognizer];

//    UITapGestureRecognizer *tapRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected1:)];
//    tapRecognizer1.numberOfTapsRequired = 1;
//    tapRecognizer1.cancelsTouchesInView = NO;
//    tapRecognizer1.delegate = self;
//    [webVw.scrollView addGestureRecognizer:tapRecognizer1];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeDetected:)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    
//    swipe.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;

    swipe.cancelsTouchesInView = NO;
    swipe.delegate = self;
    [webVw.scrollView addGestureRecognizer:swipe];
    [self.view addGestureRecognizer:swipe];

    for (UIGestureRecognizer *gesture in webVw.scrollView.gestureRecognizers)
    {
        [gesture requireGestureRecognizerToFail:swipe];
        NSLog(@"%@", gesture);
    }
    
    for (UIGestureRecognizer *gesture in webVw.scrollView.gestureRecognizers)
    {
        // don't want to mention any Apple TM'ed class names ;-)
        NSString *className = NSStringFromClass([gesture class]);
        if ([className rangeOfString:@"Swipe"].location!=NSNotFound)
        {
            [gesture requireGestureRecognizerToFail:swipe];
        }
    }

    /*  UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected2:)];
    tapRecognizer2.numberOfTapsRequired = 1;
    tapRecognizer2.delegate = self;
    [self.view addGestureRecognizer:tapRecognizer2];

    UITapGestureRecognizer *tapRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected3:)];
    tapRecognizer3.numberOfTapsRequired = 1;
    tapRecognizer3.delegate = self;
    [webVw addGestureRecognizer:tapRecognizer3];*/
}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer{
    NSLog(@"FALSE TAP DETECTED");
    webVw.scrollView.scrollEnabled = NO;
}
- (void)tapDetected1:(UITapGestureRecognizer *)tapRecognizer{
    NSLog(@"scroll view");
    webVw.scrollView.scrollEnabled = YES;
}
-(void)SwipeDetected:(id)sender{
    NSLog(@"Swipe view");
    webVw.scrollView.scrollEnabled = YES;
}
/*
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if(touch.view == self.signatureController.view){
        if([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]){
            NSLog(@"Signature ");
            return YES;
        }
    }
    if (touch.view == webVw.scrollView) {
        if([gestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]){
            NSLog(@"Scroll View");
            return YES;
        }
    }
    
    return YES;
}*/
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
-(void) handleTap {

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    int webHeight = [result integerValue];
    NSLog(@"%f",webView.scrollView.contentSize.height);
    
    CGRect frame = _signatureController.view.frame;
    frame.origin.x = 50;
    frame.origin.y = webHeight;
    frame.size.width = 668;
    frame.size.height = 250;
    _signatureController.view.frame = frame;

    [webVw.scrollView addSubview:_signatureController.view];

    clearBtn.frame = CGRectMake(frame.origin.x+550,frame.size.height + frame.origin.y + 20, 100, 60);
    [webVw.scrollView addSubview:clearBtn];
    PDFbtn.frame = CGRectMake(frame.origin.x+100,frame.size.height + frame.origin.y + 20, 100, 60);
    [webVw.scrollView addSubview:PDFbtn];
    webVw.scrollView.contentSize = CGSizeMake(webVw.scrollView.contentSize.width,[[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue]+350);
    
    
    NSString * textArticle = [webVw stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
    NSLog(@"Text Article %@", textArticle.description);


}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    webVw.scrollView.scrollEnabled = YES;
}
#pragma mark SignatureViewController delegate methods
- (void) signatureViewController:(SignatureViewController *)viewController didSign:(NSData *)signatureData;
{
    NSLog(@"signatureData: %@",signatureData.description);
}
-(void)scrollDisable:(SignatureViewController *)viewController{
    NSLog(@"Disable");
    webVw.scrollView.scrollEnabled = NO;
}
-(void)scrollenable:(SignatureViewController *)viewController{
    NSLog(@"enable");
    webVw.scrollView.scrollEnabled = YES;
}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view{
    NSLog(@"Scroll View should Starts");
    return YES;
}
-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event //here enable the touch
{
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint touchLocation = [touch locationInView:self.view];
    if (CGRectContainsPoint(_signatureController.view.frame, touchLocation))
    {
        NSLog(@" touched");
        //Your logic
    }
    else{
        NSLog(@"Don't");
    }
}


-(void)createPDFfromUI:(UIWebView *)webView saveToDocumentsWithFileName:(NSString*)aFilename
{
  	/*
     Idea and partial code from : http://itsbrent.net/2011/06/printing-converting-uiwebview-to-pdf/
     Credit where credit's due.
	 */
	
	// Store off the original frame so we can reset it when we're done
	CGRect origframe = webView.frame;
    NSString *heightStr = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"]; // Get the height of our webView
    int height = [heightStr intValue];
    
	// Size of the view in the pdf page
    CGFloat maxHeight	= kDefaultPageHeight - 2*kMargin;
	CGFloat maxWidth	= kDefaultPageWidth - 2*kMargin;
	int pages = ceil(height / maxHeight);
	
//	[webView setFrame:CGRectMake(0.f, 0.f, maxWidth, maxHeight)];
	
	// Normally we'd want a temp directory and a unique file name, but I want to see the final pdf from Simulator
	//NSString *path = NSTemporaryDirectory();
	//self.pdfPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.pdf", [[NSDate date] timeIntervalSince1970] ]];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *path = [paths objectAtIndex:0];
    self.pdfPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"tmp.pdf"]];
	
	// Set up we the pdf we're going to be generating is
	UIGraphicsBeginPDFContextToFile(self.pdfPath, CGRectZero, nil);
	int i = 0;
	for ( ; i < pages; i++)
	{
		if (maxHeight * (i+1) > height) { // Check to see if page draws more than the height of the UIWebView
            CGRect f = [webView frame];
            f.size.height -= (((i+1) * maxHeight) - height);
            [webView setFrame: f];
        }
		// Specify the size of the pdf page
		UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, kDefaultPageWidth, kDefaultPageHeight), nil);
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
		[self drawPageNumber:(i+1)];
		// Move the context for the margins
        CGContextTranslateCTM(currentContext, kMargin, kMargin);
		// offset the webview content so we're drawing the part of the webview for the current page
        [[[webView subviews] lastObject] setContentOffset:CGPointMake(0, maxHeight * i) animated:NO];
		// draw the layer to the pdf, ignore the "renderInContext not found" warning.
        [webView.layer renderInContext:currentContext];
    }
	// all done with making the pdf
    UIGraphicsEndPDFContext();
	// Restore the webview and move it to the top.
	[webView setFrame:origframe];
	[[[webView subviews] lastObject] setContentOffset:CGPointMake(0, 0) animated:NO];
}
/****************************************************************************/
- (void)drawPageNumber:(NSInteger)pageNum
{
	NSString* pageString = [NSString stringWithFormat:@"Page %d", pageNum];
	UIFont* theFont = [UIFont systemFontOfSize:12];
	CGSize maxSize = CGSizeMake(612, 72);
	
	CGSize pageStringSize = [pageString sizeWithFont:theFont
								   constrainedToSize:maxSize
                                       lineBreakMode:NSLineBreakByClipping];
	CGRect stringRect = CGRectMake(((612.0 - pageStringSize.width) / 2.0),
								   720.0 + ((72.0 - pageStringSize.height) / 2.0) ,
								   pageStringSize.width,
								   pageStringSize.height);
	
	[pageString drawInRect:stringRect withFont:theFont];
}

-(void)createPDFfromUIView1:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
{
    // Creates a mutable data object for updating with binary data, like a byte array
    UIWebView *webView = (UIWebView*)aView;
    NSString *heightStr = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    
    int height = [heightStr intValue];
    //  CGRect screenRect = [[UIScreen mainScreen] bounds];
    //  CGFloat screenHeight = (self.contentWebView.hidden)?screenRect.size.width:screenRect.size.height;
    CGFloat screenHeight = webView.bounds.size.height;
    int pages = ceil(height / screenHeight);
    
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, webView.bounds, nil);
    CGRect frame = [webView frame];
    for (int i = 0; i < pages; i++) {
        // Check to screenHeight if page draws more than the height of the UIWebView
        if ((i+1) * screenHeight  > height) {
            CGRect f = [webView frame];
            f.size.height -= (((i+1) * screenHeight) - height);
            [webView setFrame: f];
        }
        
        UIGraphicsBeginPDFPage();
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        //      CGContextTranslateCTM(currentContext, 72, 72); // Translate for 1" margins
        
        [[[webView subviews] lastObject] setContentOffset:CGPointMake(0, screenHeight * i) animated:NO];
        [webView.layer renderInContext:currentContext];
    }
    
    UIGraphicsEndPDFContext();
    // Retrieves the document directories from the iOS device
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
    
    // instructs the mutable data object to write its context to a file on disk
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    [webView setFrame:frame];
}
-(IBAction)generatePDF:(id)sender{
    // Generate the pdf.
    [htmlPdfKit saveCustomLoadPagetoPDF:webVw];
//
//    [self createPDFfromUIView1:webVw saveToDocumentsWithFileName:@"ConsentForm"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
