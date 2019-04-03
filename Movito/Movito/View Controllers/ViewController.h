//
//  ViewController.h
//  Movito
//
//  Created by Amr Mohamed Koritem on 3/30/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieContract.h"
#import "MoviePresenter.h"

@interface ViewController : UIViewController <IMovieCollectionView>

@property (weak, nonatomic) IBOutlet UILabel *movieLabel;

- (IBAction)getMovieAction:(id)sender;

@end

