//
//  CategoryViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 3/12/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCategoryCell.h"
#import "JOLImageSlider.h"
#import "GlobalVariables.h"
#import "CategoryListTable.h"
@interface CategoryViewController : UIViewController <JOLImageSliderDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NSURLSessionDelegate>{
    NSArray *recipePhotos;
    NSMutableArray *topEventListArray;
    NSUserDefaults *defaults;
    NSMutableArray *topEventList;
    NSDictionary *dictionary;
    NSMutableData *receivedData;
     NSUInteger slideSelectedIndex;
}

@property (strong, nonatomic) IBOutlet UIView *mainSlider;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end
