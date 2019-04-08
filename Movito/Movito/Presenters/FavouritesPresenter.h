//
//  FavouritesPresenter.h
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/7/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../MVP Movies/MovieContract.h"

@interface FavouritesPresenter : NSObject <IFavouritesPresenter>

@property id<IFavouriteView> favouriteView;
    
-(instancetype) initWithMovieView : (id<IFavouriteView>) favouriteView;
    
@end
