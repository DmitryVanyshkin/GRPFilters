//
//  GRPFiltersFactory.h
//  ExerciseThirteenPhotoGallery
//
//  Created by Дмитрий Ванюшкин on 08/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRPFiltersModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GRPFiltersFactory : NSObject

-(GRPFiltersModel*) createMaskToAlpha;
-(GRPFiltersModel*) createPhotoEffectTransferMode;
-(GRPFiltersModel*) createGaussianBlur;
-(GRPFiltersModel*) createNoirEffect;
-(GRPFiltersModel*) createSmoothLinearGradient;
-(GRPFiltersModel*) createFalseColor;

@end

NS_ASSUME_NONNULL_END
