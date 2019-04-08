//
//  FavouritesPresenter.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/7/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "FavouritesPresenter.h"
#import "../Service Layer/MoviesService.h"

@implementation FavouritesPresenter

-(instancetype)initWithMovieView:(id<IFavouriteView>)favouriteView
{
    self = [super init];
    if (self) {
        _favouriteView = favouriteView;
    }
    return self;
}

-(void) getFavourite
{
    MoviesService *movieService = [MoviesService new];
    [movieService loadFavouritesFromDatabase:self];
    printf("Presenter: getFavourite\n");
}
    
-(void) sendMovieToView : (NSArray*) favourites
{
    [_favouriteView supplyMovieArrayWithObject:favourites];
}

//-(void) updateFavouritesView
//{
//    printf("Presenter: updateFavouritesView\n");
//    [_favouriteView reloadView];
//}

@end
