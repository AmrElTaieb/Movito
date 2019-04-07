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

@interface DatabaseAdapter : NSObject

@property (strong , nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

+(DatabaseAdapter*)sharedInstance;

-(void)createMoviesTable;
-(NSMutableArray*)selectMoviesTable;
-(BOOL)deleteFromMoviesTable:(NSString*)identifier;
-(BOOL)insertInMoviesTableIdentifier:(Movie*)movie;
-(BOOL)updateMoviesTableIdentifier:(Movie*)movie;

@end

