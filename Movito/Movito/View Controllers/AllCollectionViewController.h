//
//  AllCollectionViewController.h
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/1/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieContract.h"
#import "MoviePresenter.h"

@interface AllCollectionViewController : UICollectionViewController <IMovieCollectionView>

@property NSArray* movies;

@end

