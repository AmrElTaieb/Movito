//
//  ViewController.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 3/30/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)getMovieAction:(id)sender
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        
        MoviePresenter *moviePresenter = [[MoviePresenter alloc] initWithMovieView:self];
        
        [moviePresenter getMovie];
    });
}


-(void)renderMovieWithObject:(Movie *)movie
{
    [_movieLabel setText:[movie name]];
}

-(void)showLoading
{
    printf("Show Loading\n");
}

-(void) hideLoading
{
    printf("hide Loading\n");
}

-(void)showErrorMessage:(NSString *)errorMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
}

@end
