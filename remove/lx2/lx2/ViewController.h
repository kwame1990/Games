//
//  ViewController.h
//  lx2
//
//  Created by teluor on 14-2-23.
//  Copyright (c) 2014年 teluor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController : UIViewController
-(int)clear;
-(int)clearone : (UIButton *) btton : (int)fx;
-(int)xialuo;
-(void)swap : (UIButton *) b1 : (UIButton *)b2;
-(void)randimage;
-(void)sound : (int) lev;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (nonatomic) IBOutlet UIImage *image1,*image2,*image3,*image4,*image5,*image6,*image7,*image8;
@property (nonatomic) IBOutlet NSString *sound1,*sound2,*sound3,*sound4,*sound5,*sound6,*sound7;
@property (nonatomic) int tagf;
@property (nonatomic) IBOutlet UIButton * bts,*bt;
@property (nonatomic)IBOutlet NSMutableArray * btarr,*bsarr;
@property (nonatomic)IBOutlet NSArray *im,*sounds;
@property (nonatomic) int samebt;
@property (nonatomic)IBOutlet NSTimer *timer,*timer2,*timer1,*timer3;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (nonatomic)int mark,levs,f_jh,f_xl,fx_xl2,f_sound,f_levtime,f_rd,level;
@end
