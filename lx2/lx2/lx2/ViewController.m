#import "ViewController.h"
@interface ViewController ()
@end
@implementation ViewController
-(void) handleTimer: (NSTimer *) timer
{
    //在这里进行处理
    if(self.f_jh == 1)
    {
        sleep(0.5);
        [self swap:self.bt :self.bts];
        self.levs = 0;
        [self sound:6];
        self.f_jh = 0;
    }
    if(self.f_xl == 1)
    {
        sleep(0.5);
        while ([self xialuo] != 1)
            ;
        NSLog(@"xialuo ok!!");
        [self randimage];
        self.fx_xl2 = 1;
        self.f_xl = 0;
    }
}
//-(void)randim : (NSTimer *)timer3
//{
//    if(self.f_rd == 1)
//    {
//        self.f_rd =0;
//        [self randimage];
//    }
//}
-(void) handleTimer1: (NSTimer *) timer1
{
    if (self.fx_xl2 == 1)
    {
        self.f_sound = 0;
        self.fx_xl2 = 0;
        while([self clear] != 1)
            self.f_sound = 1;
        NSLog(@"OK  !!!!!");
        if(self.f_sound == 1)
        {
            [self sound : self.levs];
            if(self.levs == 5)
                self.levs = 4;
            self.levs += 1;
            
        }
        self.f_xl = 1;
        [self.timer fire];
        //[self randimage];
    }
}
-(void)fanbeitime:(NSTimer *) timer2
{
    if(self.f_levtime == 0)
        self.levs = 0;
    self.f_levtime = 0;
}
//-(void)leveup
//{
//    ;
//}
-(void)sound : (int) lev
{
    NSString* path = [self.sounds objectAtIndex:lev];
    NSURL * afUrl = [NSURL fileURLWithPath:path];
    UInt32 soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)afUrl, &soundID);
    AudioServicesPlaySystemSound (soundID);
}
-(void)randimage                            //为 空位置 按钮  随机分配图片
{
    
    int i,r;
    for(i = 0;i < 8 * 11; i++)
    {
        UIButton *b1 = [self.btarr objectAtIndex:i];
        if(b1.tag / 100 >= 7)
        {
            r = arc4random()%(6);
            [b1 setImage:[self.im objectAtIndex:r] forState:UIControlStateNormal];
            b1.tag = b1.tag % 100 + (r + 1) * 100;
            
            b1.frame = CGRectMake(9 + b1.tag % 100 / 11 * 38, 10 ,38.0f, 38.0f);
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDuration:0.5];
            b1.frame = CGRectMake(9 + b1.tag % 100 / 11 * 38, 50 + b1.tag % 100 % 11 * 38,38.0f, 38.0f);
            [UIView commitAnimations];
            
        }
    }
}
-(void)swap:(UIButton *)b1 :(UIButton *)b2
{
    int t;
   //当前按钮 移动到 第一次点击按钮的位置
    b1.frame = CGRectMake(9 + b1.tag % 100 / 11 * 38, 50 + b1.tag % 100 % 11 * 38,38.0f, 38.0f);
    [UIView beginAnimations:Nil context:NULL];
    [UIView setAnimationDuration:0.5];
    b1.frame = CGRectMake(9 + b2.tag % 100 / 11 * 38, 50 + b2.tag % 100 % 11 * 38,38.0f, 38.0f);
    [UIView commitAnimations];
    
    //第一次点击的按钮 移动到 第二次点击的按钮的位置
    b2.frame = CGRectMake(9 + b2.tag % 100 / 11 * 38, 50 + b2.tag % 100 % 11 * 38,38.0f, 38.0f);
    [UIView beginAnimations:Nil context:NULL];
    [UIView setAnimationDuration:0.5];
    b2.frame = CGRectMake(9 + b1.tag % 100 / 11 * 38, 50 + b1.tag % 100 % 11 * 38,38.0f, 38.0f);
    [UIView commitAnimations];
    
    //把两个按钮在数组里的位置交换
    UIButton *temp = [self.btarr objectAtIndex:b1.tag % 100];
    [self.btarr replaceObjectAtIndex:b1.tag % 100 withObject:[self.btarr objectAtIndex:b2.tag % 100]];
    [self.btarr replaceObjectAtIndex:b2.tag % 100 withObject:temp];
    
    //交换下它们的tag
    t = b1.tag;
    b1.tag = b1.tag / 100  * 100 + b2.tag % 100;
    b2.tag = b2.tag / 100 * 100 + t % 100;
}
-(int)xialuo                          //找到被消除的按钮并和它的上一个图片按钮交换位置
{
   

    int i;
    int num = 0;
    for(i = 0;i < 8 * 11; i++)
    {
        if(i % 11 > 0 )
        {
            UIButton *b1 = [self.btarr objectAtIndex:i];
            UIButton *b2 = [self.btarr objectAtIndex:i];
            UIButton *b3 = [self.btarr objectAtIndex:i - 1];
            if(i % 11 < 10)
                b2 = [self.btarr objectAtIndex:i + 1];
           

            if (b1.tag / 100 >= 7 && b1.tag % 11 != 0 && b3.tag / 100 < 7)
            {
               NSLog(@"xialuo .....%d,%d,%d",b1.tag ,b2.tag,b3.tag);
                if(b2.tag / 100 >= 7 && i % 11 < 10)
                {
                    NSLog(@"xialuo  lie");
                    num = 0;
                    while (b2.tag / 100 >= 7 && (i + num + 1) % 11 <= 10)
                    {
                        num += 1;
                        b2 = [self.btarr objectAtIndex:i + num +1];
                    }
                    NSLog(@" x l %d",num);
                    if(num >= 0)
                    {
                        int n = num;
                        int s;
                        for(s = 0; s < i % 11; s++)
                        {
                           NSLog(@"l swap %d,%d",i - s - 1,i - s + n);
                            [self swap:[self.btarr objectAtIndex:i - s - 1] :[self.btarr objectAtIndex:i - s + n]];
                        }
                     
                    }
                }
                else if((b1.tag % 100) / 11 < 8)
                {
                     NSLog(@"xialuo  hang");
                    num = 0;
                    if((b1.tag % 100) / 11 < 7)
                        b2 = [self.btarr objectAtIndex:i + 11];
                    else
                    {
                        b2 = [self.btarr objectAtIndex:i];
                        num -= 1;
                    }
                    while (b2.tag / 100 >= 7 && (b2.tag % 100) / 11 <= 7)
                    {
                        num += 1;
                        if((b2.tag % 100) / 11 < 7)
                            b2 = [self.btarr objectAtIndex:i + num * 11 + 11];
                        else break;
                    }
                    NSLog(@" x h %d",num);
                    if(num >= 0)
                    {
                        int s1,s2;
                        int n1 = num;
                        for(s1 = 0 ;s1 <= n1; s1++)
                        {
                            for(s2 = 0; s2 < i % 11; s2++)
                            {
                                NSLog(@" swap %d,%d",i + (s1 * 11) - s2,i + (s1 * 11) - s2 - 1);
                                [self swap:[self.btarr objectAtIndex:i + (s1 * 11) - s2] :[self.btarr objectAtIndex:i + (s1 * 11) - s2 - 1]];
                            }
                        }
                    }
                }
                return 0;
            }
        }
    }
    return 1;
}
-(int)clear                                 //遍历每一个按键，看周围是否符合消除条件
{
    
    int i,j;
    
    UIButton * btton;
    int fx = 1;
    fx = 1;
    for(i = 0 ; i < 8 * 11; i++)
        {
            self.samebt = 0;
            if(i % 11 < 9)
                [self clearone:[self.btarr objectAtIndex:i]:fx];
            if (self.samebt >= 2)
            {
                for(j = 0;j <= self.samebt;j++)
                {
                    btton = [self.btarr objectAtIndex:i + j];
                    //[btton setImage:[self.im objectAtIndex:6] forState:UIControlStateNormal];
                    btton.frame = CGRectMake(9 + btton.tag % 100 / 11 * 38, 50 + btton.tag % 100 % 11 * 38,38.0f, 38.0f);
                    [UIView beginAnimations:Nil context:NULL];
                    [UIView setAnimationDuration:0.3];
                    btton.frame = CGRectMake(25 + btton.tag % 100 / 11 * 38, 65 + btton.tag % 100 % 11 * 38,4.0f, 4.0f);
                    [UIView commitAnimations];
                    self.f_levtime = 1;
                    btton.tag = btton.tag % 100 + (7 + j) * 100;
                }
           
                self.mark += 10 * self.levs;
                self.lab.text = [NSString stringWithFormat:@"%d",self.mark];
                self.samebt = 0;
                return 0;

            }
            else if(i / 11 < 6)
            {
                self.samebt = 0;
                [self clearone:[self.btarr objectAtIndex:i]:11];
                if(self.samebt >= 2)
                {
                    for(j = 0; j <= self.samebt; j++)
                    {
                        btton = [self.btarr objectAtIndex:i % 100 + j * 11];
                        //[btton setImage:[self.im objectAtIndex:6] forState:UIControlStateNormal];
                        
                        btton.frame = CGRectMake(9 + btton.tag % 100 / 11 * 38, 50 + btton.tag % 100 % 11 * 38,38.0f, 38.0f);
                        [UIView beginAnimations:Nil context:NULL];
                        [UIView setAnimationDuration:0.3];
                        btton.frame = CGRectMake(25 + btton.tag % 100 / 11 * 38, 65 + btton.tag % 100 % 11 * 38,4.0f, 4.0f);
                
                        [UIView commitAnimations];
                        
                        self.f_levtime = 1;
                        btton.tag = btton.tag % 100 + (7 + j) * 100;
                    }
                  
                    self.mark += 10 * (self.levs + 1);
                    self.lab.text = [NSString stringWithFormat:@"%d",self.mark];
                    self.samebt = 0;
                    return 0;
                }
            }
          
        }
    return 1;
}
-(int)clearone : (UIButton *) btton : (int)fx
{
    int bttonum = btton.tag % 100;
    UIButton * bttonnext = [self.btarr objectAtIndex:bttonum + fx];
    if (btton.tag / 100 ==  bttonnext.tag / 100 )
    {
        
        if ((fx == 1 && bttonum % 11 < 9) || (fx == 11 && bttonum / 11 < 6))
        {
            if((fx == 11 && bttonum / 11 == 5) || (fx == 1 && bttonum % 11 == 8))
            {
                
                self.samebt += 1;   
                UIButton * bn = [self.btarr objectAtIndex:bttonum + fx * 2];
                if(bn.tag / 100 == btton.tag / 100)
                {
                    self.samebt += 1;
                }
            }
            else
            {
                [self clearone:bttonnext:fx];
                self.samebt += 1;
            }
        }
    }
    return btton.tag;
}
- (IBAction)buttonclick:(id)sender
{
    self.f_sound = 0;
    UIButton * bt = sender;
    if(self.tagf == 100)
    {
        self.tagf = bt.tag;
        self.bts = bt;
    }
    else
    {
        if(bt.tag % 100 == self.tagf % 100 + 1 || bt.tag % 100 == self.tagf % 100 - 1 || bt.tag % 100 == self.tagf % 100 + 11 || bt.tag % 100 == self.tagf % 100 - 11)
        {
            

            [self swap:bt :self.bts];
            self.tagf = 100;
           while([self clear] != 1)
               self.f_sound = 1;
            NSLog(@"OK!");
            if(self.f_sound == 1)
            {
                [self sound : self.levs];
                if(self.levs == 5)
                    self.levs = 4;
                 self.levs += 1;
            
            }
            else
            {
                self.bt = bt;
                self.f_jh = 1;
            }
        }
        else
            self.tagf = 100;
        
    }
     self.f_xl = 1;
}
- (void)viewDidLoad
{
    UIColor *background = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"ba.jpg"]];
    self.view.backgroundColor = background;
    self.levs = 0;
    self.f_jh = 0;
    self.f_xl = 0;
    self.fx_xl2 = 0;
    self.f_sound = 0;
    self.f_levtime = 0;
    self.level = 1;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                             target: self
                                           selector: @selector(handleTimer:)
                                           userInfo: nil
                                            repeats: YES];
    
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval: 0.5
                                             target: self
                                           selector: @selector(handleTimer1:)
                                           userInfo: nil
                                            repeats: YES];
   
    self.timer2 = [NSTimer scheduledTimerWithTimeInterval: 2
                                              target: self
                                            selector: @selector(fanbeitime:)
                                            userInfo: nil
                                             repeats: YES];
  
    [super viewDidLoad];
    self.mark = 0;
    self.image1 = [UIImage imageNamed:@"1.png"];
    self.image2 = [UIImage imageNamed:@"2.png"];
    self.image3 = [UIImage imageNamed:@"3.png"];
    self.image4 = [UIImage imageNamed:@"4.png"];
    self.image5 = [UIImage imageNamed:@"5.png"];
    self.image6 = [UIImage imageNamed:@"6.png"];
    self.image7 = [UIImage imageNamed:@"7.png"];
    self.image8 = [UIImage imageNamed:@"bs.png"];
    self.im = [[NSArray alloc] initWithObjects : self.image1, self.image2, self.image3, self.image4,self.image5,self.image6,self.image7,nil];
    
    self.sound1 = [[NSBundle mainBundle] pathForResource:@"A_combo1" ofType:@"wav"];
    self.sound2 = [[NSBundle mainBundle] pathForResource:@"A_combo2" ofType:@"wav"];
    self.sound3 = [[NSBundle mainBundle] pathForResource:@"A_combo3" ofType:@"wav"];
    self.sound4 = [[NSBundle mainBundle] pathForResource:@"A_combo4" ofType:@"wav"];
    self.sound5 = [[NSBundle mainBundle] pathForResource:@"A_combo5" ofType:@"wav"];
    self.sound7 = [[NSBundle mainBundle] pathForResource:@"UI_normalpopup" ofType:@"wav"];
    self.sound6 = [[NSBundle mainBundle] pathForResource:@"S_crossbomb" ofType:@"wav"];
    self.sounds = [[NSArray alloc]initWithObjects:self.sound1,self.sound2,self.sound3,self.sound4,self.sound5,self.sound6,self.sound7, nil];

    self.btarr = [NSMutableArray alloc];
    self.btarr = [self.btarr init];
    self.bsarr = [NSMutableArray alloc];
    self.bsarr = [self.bsarr init];
    
    self.tagf = 100;
    int i=0,j=0;
    int r;
    UIButton *c = [[UIButton alloc]init];
//    c.frame = CGRectMake(250, 22, 25, 25);
//    [c setImage:self.image8 forState:UIControlStateNormal];
//    [self.view addSubview:c];
    c.tag = -1;
    for(i=0;i<8;i++)
    {
        for(j=0;j<11;j++)
        {
            UIButton *b= [[UIButton alloc] init];
            [self.btarr addObject:b];
            [self.bsarr addObject:c];
            b.frame = CGRectMake(9 + i * 38, 50 + j * 38,38.0f, 38.0f);
            
            [b addTarget:self action : @selector(buttonclick :) forControlEvents : UIControlEventTouchUpInside];
            
            r = arc4random()%(6);
            b.tag = (r + 1) * 100 +i * 11 + j;
         
            [b setImage : [self.im objectAtIndex : r] forState : UIControlStateNormal];
            
            [self.view addSubview:b];
        }
    }
    for(i = 0;i < 4;i++)
    {
        UIButton *bs = [[UIButton alloc]init];
        [bs setImage : self.image8 forState : UIControlStateNormal];
        r = arc4random()%(88);
        bs.tag = r;
        bs.frame = CGRectMake(17 + bs.tag / 11 * 38, 59 + bs.tag % 11 * 38,21.0f, 21.0f);
        [self.view addSubview:bs];
        [self.bsarr replaceObjectAtIndex:r withObject:bs];
 }
   while([self clear] != 1)
        ;
   NSLog(@"OK!");
   self.f_xl = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
