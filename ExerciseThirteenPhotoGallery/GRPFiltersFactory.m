//
//  GRPFiltersFactory.m
//  ExerciseThirteenPhotoGallery
//
//  Created by Дмитрий Ванюшкин on 08/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "GRPFiltersFactory.h"
#import <CoreImage/CoreImage.h>

@implementation GRPFiltersFactory

-(GRPFiltersModel*) createMaskToAlpha;
{
    NSString *name = @"CIMaskToAlpha";
    NSDictionary* params = @{};
    
    GRPFiltersModel* filter = [[GRPFiltersModel alloc] initWithName:name parameters:params];
    
    return filter;
}
-(GRPFiltersModel*) createPhotoEffectTransferMode
{
    NSString *name = @"CIPhotoEffectTransfer";
    NSDictionary* params = @{};
    
    GRPFiltersModel* filter = [[GRPFiltersModel alloc] initWithName:name parameters:params];
    
    return filter;
}
-(GRPFiltersModel*) createGaussianBlur;
{
    NSString *name = @"CIGaussianBlur";
    
   NSDictionary<NSString*, id>* params = @{@"inputRadius" : @(10)};
//    NSDictionary* params = @{};
    
    GRPFiltersModel* filter = [[GRPFiltersModel alloc] initWithName:name parameters:params];
    
    return filter;
}
-(GRPFiltersModel*) createNoirEffect
{
    NSString *name = @"CIPhotoEffectNoir";

    NSDictionary* params = @{};
    
    GRPFiltersModel* filter = [[GRPFiltersModel alloc] initWithName:name parameters:params];
    
    return filter;
}

-(GRPFiltersModel*) createSmoothLinearGradient
{
    NSString *name = @"CIEdges";
    

    NSDictionary* params = @{@"inputIntensity" : @(3)};

    GRPFiltersModel* filter = [[GRPFiltersModel alloc] initWithName:name parameters:params];
    
    return filter;
}

-(GRPFiltersModel*) createFalseColor
{
    NSString *name = @"CIFalseColor";
    
    
    NSDictionary* params = @{@"inputColor0" : CIColor.blueColor, @"inputColor1" : CIColor.redColor };
    
    GRPFiltersModel* filter = [[GRPFiltersModel alloc] initWithName:name parameters:params];
    
    return filter;
}


@end
