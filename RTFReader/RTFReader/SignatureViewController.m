//
//  SignatureViewController.m
//
//  Created by John Montiel on 5/11/12.
//

#import "SignatureViewController.h"

@interface SignatureViewController ()
@property (strong, nonatomic) NSData *signature;

@end

@implementation SignatureViewController
@synthesize delegate;
@synthesize signatureTextField;
@synthesize view;
@synthesize signature;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beganSignature:) name:kBeganSignature object:self.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(continueSignature:) name:kBeganScroll object:self.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endSignature:) name:kEndScroll object:self.view];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kBeganSignature object:self.view];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kEndScroll object:self.view];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kBeganScroll object:self.view];
    [self setView:nil];
    [self setSignatureTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)signatureClearTapped:(id)sender 
{
    [self.view erase];
    
    [UIView animateWithDuration:0.6 animations:^
     {
         [self.signatureTextField setAlpha:1.0];
     }];
}

- (IBAction)signatureSignTapped:(id)sender 
{
    [self checkSign];
}

-(void)checkSign
{
    if ((self.signature = UIImagePNGRepresentation([self.view getSignatureImage])))
    {
        [self.delegate signatureViewController:self didSign:self.signature];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Signature" message:@"Please sign" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)beganSignature:(NSNotification *)notification
{
    [self.delegate scrollDisable:self];
    if ([notification object] == self.view)
    {
        [UIView animateWithDuration:0.6 animations:^
         {
             [self.signatureTextField setAlpha:0.2];
         }];
    }
}
- (void)endSignature:(NSNotification *)notification
{
    NSLog(@"END ");
    [self.delegate scrollenable:self];
}
- (void)continueSignature:(NSNotification *)notification
{
    NSLog(@"START");
    [self.delegate scrollDisable:self];
}

@end
