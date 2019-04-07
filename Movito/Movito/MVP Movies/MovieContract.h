//
//  MovieContract.h
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/1/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseContract.h"
#import "Movie.h"


@protocol IMovieCollectionView <IBaseView>

-(void) supplyMovieArrayWithObject : (NSArray*) movie;

@end

@protocol IMovieView <IBaseView>

-(void) renderMovieDataToView;
-(void) rebindFavouriteStatus : (Movie*) movie;

@end


@protocol IMoviesPresenter <NSObject>

-(void) getMovie;
-(void) onSuccess : (NSArray*) movie;
-(void) onFail : (NSString*) errorMessage;

@end

@protocol IMovieDetailsPresenter <NSObject>

-(void) toggleFavourites : (Movie*) movie;
-(void) sendMovieToView : (Movie*) movie;

@end


@protocol IMovieManager <NSObject>

-(void) getMovie : (id<IMoviesPresenter>) moviePresenter;
-(void) toggleFavouriteStatus : (Movie*) movie forDetailsPresenter : (id<IMovieDetailsPresenter>) movieDetailsPresenter;

@end
