//
//  UserMenuViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 10/19/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "UserMenuViewController.h"

@interface UserMenuViewController ()

@end

@implementation UserMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      

    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSURL *imagePathFull =[NSURL URLWithString:[NSString stringWithFormat:@"%@", [defaults objectForKey:@"picture"]]];
    
    [[RemoteImageHandler shared] imageForUrl:imagePathFull callback:^(UIImage *image) {
        self.userImage.image = image;
    }];
    
    [self.userName setText:[defaults objectForKey:@"username"]];
    
    [self.view layoutIfNeeded];
    [self.userImage.layer setCornerRadius:self.userImage.frame.size.width/2];
    [self.userImage setClipsToBounds:YES];
    
    [self.userImageBorder.layer setCornerRadius:self.userImageBorder.frame.size.width/2];
    [self.userImageBorder.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.userImageBorder.layer setShadowOpacity:0.8];
    [self.userImageBorder.layer setShadowRadius:3.0];
    [self.userImageBorder.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [self.userImageBorder setClipsToBounds:YES];
    
    
    menuItems = @[@"edit_profile", @"privacy_policy", @"find_friends", @"tutorial", @"like_showme", @"about", @"log_out"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return menuItems.count;
}
 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if(indexPath.row == 6){
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logOut];
        [FBSDKAccessToken setCurrentAccessToken:nil];
        [self performSegueWithIdentifier:@"facebook_login_checker2" sender:self];
    }else if(indexPath.row == 3){
        [self performSegueWithIdentifier:@"show_tutorial" sender:self];
     
    }else if(indexPath.row == 4 ){
        NSURL *facebookURL = [NSURL URLWithString:@"https://www.facebook.com/ShowMeMgl"];
        if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
            [[UIApplication sharedApplication] openURL:facebookURL];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/ShowMeMgl"]];
        }
    }else if(indexPath.row == 2){
        [self performSegueWithIdentifier:@"find_friend_segue" sender:self];
    }else if(indexPath.row == 0){
        [self performSegueWithIdentifier:@"edit_profile_segue" sender:self];
    }else if(indexPath.row == 5){
        [self performSegueWithIdentifier:@"about_showme_segue" sender:self];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
