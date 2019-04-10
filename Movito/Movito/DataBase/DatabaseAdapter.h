//
//  DatabaseAdapter.h
//  Lab3SQLite
//
//  Created by Amr Mohamed Koritem on 3/24/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Movie.h"
#import "../POJO/Trailer.h"
#import "../POJO/Review.h"

@interface DatabaseAdapter : NSObject

@property NSMutableArray* favourites;

@property (strong , nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

+(DatabaseAdapter*)sharedInstance;

-(void)createMoviesTable;
-(NSMutableArray*)selectMoviesTable;
-(BOOL)deleteFromMoviesTable:(NSString*)identifier;
-(BOOL)emptyMoviesTable;
-(BOOL)insertInMoviesTableIdentifier:(Movie*)movie;
-(BOOL)updateMoviesTableIdentifier:(Movie*)movie;

-(void)createFavouritesTable;
-(NSArray*)selectFavouritesTable;
-(BOOL)deleteFromFavouritesTable:(NSString*)identifier;
-(BOOL)insertInFavouritesTableIdentifier:(Movie*)movie;

-(void)createTrailersTable;
-(NSArray*)selectTrailersTableWithIdentifier:(NSInteger)identifier;
-(BOOL)deleteFromTrailersTable:(NSString*)mIdentifier;
-(BOOL)insertInTrailersTableIdentifier:(Trailer*)trailer;

-(void)createReviewsTable;
-(NSArray*)selectReviewsTableWithIdentifier:(NSInteger)identifier;
-(BOOL)deleteFromReviewsTable:(NSString*)mIdentifier;
-(BOOL)insertInReviewsTableIdentifier:(Review*)review;

@end

