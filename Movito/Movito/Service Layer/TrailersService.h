//
//  TrailersService.h
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/9/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkObserver.h"
#import "ServiceProtocol.h"
#import "MovieContract.h"
#import "NetworkManager.h"
#import "../POJO/Movie.h"

@interface TrailersService : NSObject <NetworkObserver , ServiceProtocol , ITrailerManager>

@property Movie* movie;

@end
