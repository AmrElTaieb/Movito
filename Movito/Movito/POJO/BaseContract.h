//
//  BaseContract.h
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/1/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IBaseView <NSObject>

-(void) showLoading;
-(void) hideLoading;
-(void) showErrorMessage : (NSString*) errorMessage;

@end
