//
//  HomeViewController.m
//  RTFReader
//
//  Created by Hiren J. Bhadreshwara on 30/05/14.
//  Copyright (c) 2014 digicorp. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"TempLetter" ofType:@"rtf"];
    NSString *myText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"My Text %@", myText);
    rtflbl.text  = myText;
    
    
    NSURL *rtfUrl = [[NSBundle mainBundle] URLForResource:@"TempLetter" withExtension:@".rtf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:rtfUrl];
    [webVw loadRequest:request];
    [webVw sizeToFit];

}
-(NSString *)readFile:(NSString *)fileName
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    documentsDirectory=[documentsDirectory stringByAppendingPathComponent:@"TempLetter.rtf"];

//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:documentsDirectory])
    {
        NSError *error= NULL;
        id resultData=[NSString stringWithContentsOfFile:documentsDirectory encoding:NSUTF8StringEncoding error:&error];
        if (error == NULL)
        {
            return resultData;
        }
    }
    return NULL;
}
-(void)writeFile:(NSString *)fileName data:(id)data
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSError *error=NULL;
    
    [data writeToFile:appFile atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (error != NULL)
    {
        //Check Error Here. if any.
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
