//
//  DatabaseAdapter.h
//  Lab3SQLite
//
//  Created by Amr Mohamed Koritem on 3/24/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseAdapter : NSObject

@property (strong , nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

+(DatabaseAdapter*)sharedInstance;

-(void)createTable;
-(NSMutableArray*)selectTable;
-(void)deleteFromTable:(NSString*)identifier;
-(BOOL)insertInTableIdentifier:(NSInteger)identifier andPosterPath:(NSString*)posterPath andOriginalTitle:(NSString*)originalTitle andOverview:(NSString*)overview andVoteAverage:(double)voteAverage andReleaseDate:(NSString*)releaseDate andIsFavourite:(NSString*)isFavourite;
-(BOOL)updateTableIdentifier:(NSInteger)identifier andPosterPath:(NSString*)posterPath andOriginalTitle:(NSString*)originalTitle andOverview:(NSString*)overview andVoteAverage:(double)voteAverage andReleaseDate:(NSString*)releaseDate andIsFavourite:(NSString*)isFavourite;

@end

