//
//  FavouriteCollectionViewController.h
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/7/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MovieContract.h"

@interface FavouriteCollectionViewController : UICollectionViewController <IFavouriteView>
@property NSArray* movies;
@end

