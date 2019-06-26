//
//  GRPFiltersModel.h
//  ExerciseThirteenPhotoGallery
//
//  Created by Дмитрий Ванюшкин on 08/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GRPFiltersModel : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSDictionary <NSString*, id> *parameters;

-(instancetype) initWithName: (NSString*) name parameters: (NSDictionary *) parameters;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
