//
//  ViewController.m
//  demo_bitmap
//
//  Created by Lwgfangz on 13-5-30.
//  Copyright (c) 2013年 Lwgfangz. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import <CoreText/CoreText.h>
#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 240
//void myDrawFlag (CGContextRef context, CGRect* contextRect)
//{
//    int          i, j,
//    num_six_star_rows = 5,
//    num_five_star_rows = 4;
//    CGFloat      start_x = 5.0,// 1
//    start_y = 108.0,// 2
//    red_stripe_spacing = 34.0,// 3
//    h_spacing = 26.0,// 4
//    v_spacing = 22.0;// 5
//    CGContextRef myLayerContext1,
//    myLayerContext2;
//    CGLayerRef   stripeLayer,
//    starLayer;
//    CGRect       myBoundingBox,// 6
//    stripeRect,
//    starField;
//    // ***** Setting up the primitives *****
//    const CGPoint myStarPoints[] = {{ 5, 5},   {10, 15},// 7
//        {10, 15},  {15, 5},
//        {15, 5},   {2.5, 11},
//        {2.5, 11}, {16.5, 11},
//        {16.5, 11},{5, 5}};
//    
//    stripeRect  = CGRectMake (0, 0, 400, 17); // stripe// 8
//    starField  =  CGRectMake (0, 102, 160, 119); // star field// 9
//    
//    myBoundingBox = CGRectMake (0, 0, contextRect->size.width, // 10
//                                contextRect->size.height);
//    
//    // ***** Creating layers and drawing to them *****
//    stripeLayer = CGLayerCreateWithContext (context, // 11
//                                            stripeRect.size, NULL);
//    myLayerContext1 = CGLayerGetContext (stripeLayer);// 12
//    
//    CGContextSetRGBFillColor (myLayerContext1, 1, 0 , 0, 1);// 13
//    CGContextFillRect (myLayerContext1, stripeRect);// 14
//    
//    starLayer = CGLayerCreateWithContext (context,
//                                          starField.size, NULL);// 15
//    myLayerContext2 = CGLayerGetContext (starLayer);// 16
//    CGContextSetRGBFillColor (myLayerContext2, 1.0, 1.0, 1.0, 1);// 17
//    CGContextAddLines (myLayerContext2, myStarPoints, 10);// 18
//    CGContextFillPath (myLayerContext2);    // 19
//    
//    // ***** Drawing to the window graphics context *****
//    CGContextSaveGState(context);    // 20
//    for (i=0; i< 7;  i++)   // 21
//    {
//        CGContextDrawLayerAtPoint (context, CGPointZero, stripeLayer);// 22
//        CGContextTranslateCTM (context, 0.0, red_stripe_spacing);// 23
//    }
//    CGContextRestoreGState(context);// 24
//    
//    CGContextSetRGBFillColor (context, 0, 0, 0.329, 1.0);// 25
//    CGContextFillRect (context, starField);// 26
//    
//    CGContextSaveGState (context);              // 27
//    CGContextTranslateCTM (context, start_x, start_y);      // 28
//    for (j=0; j< num_six_star_rows;  j++)   // 29
//    {
//        for (i=0; i< 6;  i++)
//        {
//            CGContextDrawLayerAtPoint (context,CGPointZero,
//                                       starLayer);// 30
//            CGContextTranslateCTM (context, h_spacing, 0);// 31
//        }
//        CGContextTranslateCTM (context, (-i*h_spacing), v_spacing); // 32
//    }
//    CGContextRestoreGState(context);
//    
//    CGContextSaveGState(context);
//    CGContextTranslateCTM (context, start_x + h_spacing/2, // 33
//                           start_y + v_spacing/2);
//    for (j=0; j< num_five_star_rows;  j++)  // 34
//    {
//        for (i=0; i< 5;  i++)
//        {
//            CGContextDrawLayerAtPoint (context, CGPointZero,
//                                       starLayer);// 35
//            CGContextTranslateCTM (context, h_spacing, 0);// 36
//        }
//        CGContextTranslateCTM (context, (-i*h_spacing), v_spacing);// 37
//    }
//    CGContextRestoreGState(context);
//    
//    CGLayerRelease(stripeLayer);// 38
//    CGLayerRelease(starLayer);        // 39
//}

@interface ViewController ()
{
    CGRect m_keyboardRect;
    CGRect m_originalRect;//原始的尺寸，没有出现键盘之前的。
    UIImageView *m_imageView;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = {{0,0},{320,240}};
    m_imageView = [UIImageView new];
    [m_imageView setFrame:frame];
    
    //m_imageView.backgroundColor = [UIColor greenColor];
    UIColor *color=[UIColor colorWithRed:0.5 green:1 blue:1 alpha:1];
    _ibScrollView.backgroundColor = color;
    
    CGSize size = frame.size;
    _ibScrollView.contentSize=size;
    [_ibScrollView addSubview:m_imageView];
    
	// Do any additional setup after loading the view, typically from a nib.
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
   [notificationCenter addObserver:self selector:@selector(handleKeyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    self.ibTextField.layer.cornerRadius=8.0;
    self.ibTextField.borderStyle = UITextBorderStyleRoundedRect;
    m_originalRect = self.view.frame;
    
    
    //m_imageView=[UIImageView new];
    
   // [self HandleBitmap:@"123456"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleKeyBoardDidShow:(NSNotification *)paramNotification
{
    NSValue *keyboardRectAsObject = [[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];/*get the frame of the keyboard*/
    //CGRect keyboardRect;
    [keyboardRectAsObject getValue:&m_keyboardRect];/*place it in a CGRect*/
    
    CGRect viewFrame=m_originalRect;
    viewFrame.origin.y -= m_keyboardRect.size.height;
    
    [UIView beginAnimations:@"push" context:nil];
    [UIView setAnimationDuration:0.00001];
    self.view.frame=viewFrame;
    [UIView commitAnimations];

    //self.view.frame.origin.x=0;
    //self.view.frame.origin.y=0;//keyboardRect.size.height;
    //self.view.center = CGPointMake(0,20);
    //_ibTextFiled.contentInset = UIEdgeInsetsMake(0.0f,0.0f,  keyboarddRect.size.height,0.0f);
}


- (void)dealloc {
    [_ibTextField release];
    [_ibScrollView release];
    [_ibScreenImageView release];
    [m_imageView release];
    [super dealloc];
}
- (IBAction)EditingDidEndOnExit:(id)sender 
{
    
    CGRect viewFrame=self.view.frame;
    viewFrame.origin.y+=m_keyboardRect.size.height;
    
   // [UIView beginAnimations:@"pull" context:nil];
    [UIView setAnimationDuration:0.1];
    self.view.frame=viewFrame;
    [UIView commitAnimations];
    [self HandleBitmap:self.ibTextField.text];
}
-(void)HandleBitmap:(NSString*)string
{
    NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:string];
    //CGPoint point={0,0};
    CGSize imageRect={SCREEN_WIDTH,SCREEN_HEIGHT};
    UIGraphicsBeginImageContextWithOptions(imageRect,NO,0.0);

    //[attrString drawAtPoint:point];
    CGRect drawRect={{0,0},{320,240}};
    //CGContextRef context = UIGraphicsGetCurrentContext ();
    //myDrawFlag(context,&drawRect);
    //CTFontRef font = CTFontCreateWithName((CFStringRef)@"STHeitiSC-Medium",24.,NULL);
    //NSDictionary *fontDic=[NSDictionary dictionaryWithObject:(id)font forKey:(NSString *)kCTFontAttributeName];
    NSRange range={0,[attrString length]};
   // [attrString addAttributes:fontDic range:range];
    
    //CGContextSetRGBFillColor (context, 0, 0, 0, 1);// 25
    //CGContextFillRect(context, CGRectMake(0,0,320,239));
    
    UIFont *font1=[UIFont fontWithName:@"STHeitiSC-Medium" size:48.0];
    [attrString addAttribute:NSFontAttributeName value:font1 range:range];
    //[attrString addAttributes:fontDic range:range];
    //[self getSystemFont];
    [attrString drawInRect:drawRect];
    //[attrString drawAtPoint:point];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    [m_imageView setImage:img];
    
    CGImageRef cgImgRef=img.CGImage;
    NSData *data = (NSData *) CGDataProviderCopyData(CGImageGetDataProvider(cgImgRef));//TODO,release it
    unsigned char *pixels                = (unsigned char *)[data bytes];

    //size_t width                = CGImageGetWidth(cgImgRef);
    //size_t height               = CGImageGetHeight(cgImgRef);
    //size_t bitsPerComponent     = CGImageGetBitsPerComponent(cgImgRef);//刚好是一个Byte
    //size_t bitsPerPixel         = CGImageGetBitsPerPixel(cgImgRef);
    //size_t bytesPerRow          = CGImageGetBytesPerRow(cgImgRef);
    unsigned char buffer[SCREEN_WIDTH*SCREEN_HEIGHT/8];
    [self getScreenBuffer:buffer originBuffer:pixels];
    UIGraphicsEndImageContext();
    [self displayBuffer:buffer length:SCREEN_WIDTH*SCREEN_HEIGHT/8];
}


-(void)getScreenBuffer:(unsigned char *)buffer originBuffer:(unsigned char *)originBuffer
{
    if((buffer==0)||(originBuffer==0))
    {
        return;
    }
    memset(buffer,0,SCREEN_WIDTH*SCREEN_HEIGHT/8);
    for(int i=0;i<SCREEN_HEIGHT;i++)
    {
        for(int j=0;j<SCREEN_WIDTH;j++)
        {
            int position=(i*SCREEN_WIDTH*4) + (j*4);
            unsigned char *p= &originBuffer[position];
            int value=(p[0]+p[1]+p[2]+p[3])!=0?1:0;
            //NSLog(@"%X,%X,%X,%X",p[0],p[1],p[2],p[3]);
            if(value==1)
            {
                int bytePosion=position/(8*4);
                
                int left=position%(8*4);
                int bitPosion=left/4;
                unsigned char point=1<<bitPosion;
                
                unsigned char *p=&buffer[bytePosion];
                (*p)=(*p)|point;
                
                NSLog(@"");
            }
        }
    }
}


//TODO,下一行没有显示。

-(void)displayBuffer:(unsigned char *)buffer length:(int)len
{
    if(buffer==0)
    {
        return;
    }
    CGSize imageRect={SCREEN_WIDTH,SCREEN_HEIGHT};
    UIGraphicsBeginImageContextWithOptions(imageRect,NO,0.0);
    CGContextRef context = UIGraphicsGetCurrentContext ();
    
    int x = 0;
    int y = 0;
    for(int i=0;i<len;i++)
    {
        for(int j=0;j<8;j++)
        {
            y = (i*8)/SCREEN_WIDTH;
            x = (i*8+j)%SCREEN_WIDTH; 
            unsigned char *p = &buffer[i];
            unsigned char testBit = 0x1<<j;
            int testValue = (*p)&testBit;
            
            if(testValue)
            {
                CGContextSetRGBFillColor (context, 0, 0, 0, 1.0);// 25
                CGContextFillRect(context, CGRectMake(x,y,1,1));
            }
        }

    }

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    [_ibScreenImageView setImage:img];
    UIGraphicsEndImageContext();
}


-(void)getSystemFont
{
    //获取字体
    NSMutableArray *mListFontName = [[NSMutableArray alloc] init];
    
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames )
    {
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames )
        {
            printf( "\tFont: %s \n", [fontName UTF8String] );
            [mListFontName addObject:fontName]; 
        }
    }
}


@end
