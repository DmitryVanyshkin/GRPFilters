//
//  GRPFiltersModel.m
//  ExerciseThirteenPhotoGallery
//
//  Created by Дмитрий Ванюшкин on 08/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "GRPFiltersModel.h"

@interface GRPFiltersModel()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSDictionary <NSString*, id> *parameters;
@end

@implementation GRPFiltersModel

-(instancetype) initWithName: (NSString*) name parameters: (NSDictionary *) parameters
{
    self = [super init];
    
    if (self)
    {
        _name = [name copy];
        _parameters = [parameters copy];
    }
    
    return self;
}

@end
