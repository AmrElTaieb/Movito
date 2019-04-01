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


@protocol IMovieView <IBaseView>

-(void) renderContactWithObject : (Movie*) movie;

@end


@protocol IMoviePresenter <NSObject>

-(void) getContact;
-(void) onSuccess : (Movie*) movie;
-(void) onFail : (NSString*) errorMessage;

@end



@protocol IMovieManager <NSObject>

-(void) getConatct : (id<IMoviePresenter>) moviePresenter;

@end
