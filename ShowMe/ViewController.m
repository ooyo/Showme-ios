//
//  ViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 3/9/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *animationImageView;
@property (nonatomic, strong) CADisplayLink *displayLink;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    CGRect newFrame = self.videoView.frame;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"Userid :%@", [defaults objectForKey:@"userid"]);
    newFrame.size.width = [UIScreen mainScreen].bounds.size.width;
    newFrame.size.height = [UIScreen mainScreen].bounds.size.height;
    [self.videoView setFrame:newFrame];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil
     ];

    
    
 }
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
//    for(int i = 1 ; i<= 56 ; i++)
//        [imagesArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"master-%d.png",i]]];
//    
//    self.animationImageView.animationImages = imagesArray;
//    self.animationImageView.animationDuration = 2.0f;
//    self.animationImageView.animationRepeatCount = 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animateBtn:(id)sender {
//     [UIView animateWithDuration:0.5 animations:^{
//        [_animationBtn setAlpha:0];
//        
//    } completion: ^(BOOL finished) {
//        
//        [self.animationImageView startAnimatingWithCompletionBlock:^(BOOL success){
//             if ([FBSDKAccessToken currentAccessToken]) {
//                        [self performSegueWithIdentifier:@"main_screen" sender:self];
//             }else{
//                 [self performSegueWithIdentifier:@"face_login" sender:self];
//
//             }
//        }];
//    }];
    
    [_animationBtn setHidden:YES];
    [self createVideoPlayer];
}

- (void)createVideoPlayer {
    NSLog(@"VIDEO PLAYER");
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *moviePath = [bundle pathForResource:@"btn_animation" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:moviePath];
    
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    self.player.volume = PLAYER_VOLUME;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    playerLayer.frame = self.videoView.layer.bounds;
    [self.videoView.layer addSublayer:playerLayer];

    
    [self.player play];
    
    
    [self.player.currentItem addObserver:self forKeyPath:AVPlayerItemDidPlayToEndTimeNotification options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    
    
    
    

    
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"Observ dictionary: %@", change);
    NSNumber *changeNumber = [NSNumber numberWithInt:2];
    if([[change objectForKey:@"new"] isEqualToNumber:changeNumber]){
        if ([FBSDKAccessToken currentAccessToken]) {
            [self performSegueWithIdentifier:@"main_screen" sender:self];
        }else{
             [self performSegueWithIdentifier:@"face_login" sender:self];
        }
    }
    
   
}


// 视频循环播放
- (void)moviePlayDidEnd:(NSNotification*)notification{
    NSLog(@"video end");
    AVPlayerItem *item = [notification object];
    [item seekToTime:kCMTimeZero];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [self performSegueWithIdentifier:@"main_screen" sender:self];
    }else{
        [self performSegueWithIdentifier:@"face_login" sender:self];
    }
}



- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
    for (UIView *subview in self.view.subviews) {
        if ([subview isEqual:self.videoView]) {
            continue;
        }
        CGRect frame = subview.frame;
        frame.origin.y += yOffset;
        subview.frame = frame;
    }
}



- (void)dealloc {
    NSLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)animationDone
{
    NSLog(@"Done");
}
@end
