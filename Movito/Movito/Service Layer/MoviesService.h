//
//  MoviesService.h
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/1/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkObserver.h"
#import "ServiceProtocol.h"
#import "../MVP Movies/MovieContract.h"
#import "NetworkManager.h"

@interface MoviesService : NSObject <NetworkObserver , ServiceProtocol , IMovieManager>

@property id<IMoviesPresenter> moviesPresenter;
@property id<IMovieDetailsPresenter> movieDetailsPresenter;
@property id<IFavouritesPresenter> favouritesPresenter;

@property int counter;
@property NSString* serviceName;
@property NSArray* moviesArray;
@property Movie* movie;
@property BOOL isByPopularity;

@end

