//
//  RoundCardImage.m
//  ShowMe
//
//  Created by Nuk3denE on 6/23/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "RoundCardImage.h"

@implementation RoundCardImage
+(NSString *) imageName:(NSString *)categoryName{
    NSString *fileName;
    
    if([categoryName isEqualToString:@"Night Club"]){
        fileName = @"cat_night_round";
        return fileName;
    }else if([categoryName isEqualToString:@"Shop"]){
        fileName = @"cat_shop_round";
        return fileName;
    }else if([categoryName isEqualToString:@"Pub"]){
        fileName = @"cat_pub_round";
        return fileName;
    }else if([categoryName isEqualToString:@"Theatre"]){
        fileName = @"cat_theatre_round";
        return fileName;
    }else if([categoryName isEqualToString:@"Lounge"]){
        fileName = @"cat_lounge_round";
        return fileName;
    }else if([categoryName isEqualToString:@"Coffee Shop"]){
        fileName = @"cat_coffee_round";
        return fileName;
    }else if([categoryName isEqualToString:@"Restaurant"]){
        fileName = @"cat_restaurant_round";
        return fileName;
    }else if([categoryName isEqualToString:@"Mall"]){
        fileName = @"cat_mall_round";
        return fileName;
    }else{
        fileName = @"cat_activity_round";
        return  fileName;
    }
}
@end
