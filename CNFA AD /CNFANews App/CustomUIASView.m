
#import "CustomUIASView.h"


@implementation CustomUIASView

@synthesize weChatButton;
@synthesize smsButton;
@synthesize tencentButton,emailButton,sinaweiboButton,cancleBtn;

- (id)initWithFrame:(CGRect)frame {
  
  if ((self = [super initWithFrame:frame])) {
    
    //self.alpha           = 1.8;
   // self.backgroundColor = [UIColor clearColor];
    //self.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.1];
      self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"transparent-bg.png"] ];
    //-58, g-76, b-83
   // [UIColor colorWithRed:68/255.0f green:192/255.0f blue:181/255.0f alpha:1];;

      
      self.cancleBtn =[UIButton buttonWithType:UIButtonTypeCustom];
      self.cancleBtn.frame=CGRectMake(193.75+44,157.5-10,34,34);
//      self.cancleBtn.backgroundColor=[UIColor redColor];
//      self.cancleBtn.titleLabel.font=[UIFont systemFontOfSize:13.0f];
//      [self.cancleBtn setTitle:@"Cancle" forState:UIControlStateNormal];
//      [self.cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [self.cancleBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"close" ofType:@"png"]] forState:UIControlStateNormal];
      [self addSubview:self.cancleBtn];

      
      
      self.weChatButton =[UIButton buttonWithType:UIButtonTypeCustom];
      self.weChatButton.frame=CGRectMake(24.75+10,40,67.5,64.5);
      [self.weChatButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"we-chat" ofType:@"png"]] forState:UIControlStateNormal];
     // [self.weChatButton addTarget:self action:@selector(sendTextContent_WeChat) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:self.weChatButton];
      
      UILabel *celltxt_lbl3=[[UILabel alloc] init];

      celltxt_lbl3.frame=CGRectMake(24.75+10,84,67.5,64.5);
 
     
      celltxt_lbl3.text=[NSString stringWithFormat:@"微信"];
      celltxt_lbl3.textAlignment=UITextAlignmentCenter;
      celltxt_lbl3.textColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
      celltxt_lbl3.backgroundColor=[UIColor clearColor];
      celltxt_lbl3.font=[UIFont fontWithName:@"ZhunYuan" size:13];
     
      [self addSubview:celltxt_lbl3];
      [celltxt_lbl3 release];
      
#pragma Weibo chat Button
      self.sinaweiboButton =[UIButton buttonWithType:UIButtonTypeCustom];
      self.sinaweiboButton.frame=CGRectMake(109.25+17,40,67.5,64.5);
      [self.sinaweiboButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sina-weibo" ofType:@"png"]] forState:UIControlStateNormal];
     // [self.sinaweiboButton addTarget:self action:@selector(SinaWeibo:) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:self.sinaweiboButton];
      UILabel *celltxt_lbl1=[[UILabel alloc] init];
      
      celltxt_lbl1.frame=CGRectMake(109.25+17,84,67.5,64.5);
      
      celltxt_lbl1.textAlignment=UITextAlignmentCenter;
      celltxt_lbl1.text=[NSString stringWithFormat:@"新浪微博"];
      
      celltxt_lbl1.textColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
      celltxt_lbl1.backgroundColor=[UIColor clearColor];
      celltxt_lbl1.font=[UIFont fontWithName:@"ZhunYuan" size:13];
      
      [self addSubview:celltxt_lbl1];
      [celltxt_lbl1 release];
      
#pragma Tencet chat Button
      self.tencentButton =[UIButton buttonWithType:UIButtonTypeCustom];
      self.tencentButton .frame=CGRectMake(193.75+24,40,67.5,64.5);
      [self.tencentButton  setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tecent-weibo" ofType:@"png"]] forState:UIControlStateNormal];
     // [self.tencentButton  addTarget:self action:@selector(TencentWeibo:) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:self.tencentButton];
      UILabel *celltxt_lbl2=[[UILabel alloc] init];
      
      celltxt_lbl2.frame=CGRectMake(193.75+24,84,67.5,64.5);
      
      celltxt_lbl2.textAlignment=UITextAlignmentCenter;
      celltxt_lbl2.text=[NSString stringWithFormat:@"腾讯微博"];
      
      celltxt_lbl2.textColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
      celltxt_lbl2.backgroundColor=[UIColor clearColor];
      celltxt_lbl2.font=[UIFont fontWithName:@"ZhunYuan" size:13];
      
      [self addSubview:celltxt_lbl2];
      [celltxt_lbl2 release];
#pragma SMS Button
      self.smsButton =[UIButton buttonWithType:UIButtonTypeCustom];
      self.smsButton.frame=CGRectMake(24.75+10,157.5-20,67.5,64.5);
      [self.smsButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sms" ofType:@"png"]] forState:UIControlStateNormal];
      //[self.smsButton addTarget:self action:@selector(message_btn:) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:self.smsButton];
      UILabel *celltxt_lbl4=[[UILabel alloc] init];
      
      celltxt_lbl4.frame=CGRectMake(24.75+10,178+5,67.5,64.5);
      
      celltxt_lbl4.textAlignment=UITextAlignmentCenter;
      celltxt_lbl4.text=[NSString stringWithFormat:@"短信"];
      
      celltxt_lbl4.textColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
      celltxt_lbl4.backgroundColor=[UIColor clearColor];
      celltxt_lbl4.font=[UIFont fontWithName:@"ZhunYuan" size:13];
      
      [self addSubview:celltxt_lbl4];
      [celltxt_lbl4 release];
      
#pragma EMAIL Button
      self.emailButton =[UIButton buttonWithType:UIButtonTypeCustom];
      self.emailButton.frame=CGRectMake(109.25+17,157.5-20,67.5,64.5);
      [self.emailButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"email" ofType:@"png"]] forState:UIControlStateNormal];
     // [self.emailButton addTarget:self action:@selector(openMail:) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:self.emailButton];
      UILabel *celltxt_lbl5=[[UILabel alloc] init];
      
      celltxt_lbl5.frame=CGRectMake(109.25+17,178+5,67.5,64.5);
      
      celltxt_lbl5.textAlignment=UITextAlignmentCenter;
      celltxt_lbl5.text=[NSString stringWithFormat:@"邮件"];
      
      celltxt_lbl5.textColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
      celltxt_lbl5.backgroundColor=[UIColor clearColor];
      celltxt_lbl5.font=[UIFont fontWithName:@"ZhunYuan" size:13];
      
      [self addSubview:celltxt_lbl5];
      [celltxt_lbl5 release];
  }
  
  return self;
}

- (void)dealloc {
    
  [weChatButton release];
  [smsButton release];
  [tencentButton release];
  [super dealloc];
}

@end