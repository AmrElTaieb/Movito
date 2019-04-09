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

@protocol IFavouriteView <IBaseView>
    
-(void) supplyMovieArrayWithObject : (NSArray*) movie;
//-(void) reloadView;

@end


@protocol IMoviesPresenter <NSObject>

-(void) getMovie;
-(void) onSuccess : (NSArray*) movie;
-(void) onFail : (NSString*) errorMessage;
//-(void) updateFavouritesService;

@end

@protocol IFavouritesPresenter <NSObject>

-(void) getFavourite;
-(void) sendMovieToView : (NSArray*) favourites;
//-(void) updateFavouritesView;

@end

@protocol IMovieDetailsPresenter <NSObject>

-(void) toggleFavourites : (Movie*) movie;
-(void) sendMovieToView : (Movie*) movie;

@end


@protocol IMovieManager <NSObject>

-(void) getMovie : (id<IMoviesPresenter>) moviePresenter;
-(void) toggleFavouriteStatus : (Movie*) movie forDetailsPresenter : (id<IMovieDetailsPresenter>) movieDetailsPresenter;
-(void) loadFavouritesFromDatabase:(id<IFavouritesPresenter>)favouritesPresenter;
//-(void) updateFavouritesPresenter;

@end

@protocol ITrailerManager <NSObject>

-(void) getTrailer : (Movie*) movie;

@end
