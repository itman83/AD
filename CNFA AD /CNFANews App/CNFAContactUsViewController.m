//
//  CNFAContactUsViewController.m
//  CNFANews App
//
//  Created by Dex on 22/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAContactUsViewController.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface CNFAContactUsViewController ()

@end

@implementation CNFAContactUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"147.png"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    remoteHostStatus = [reachability currentReachabilityStatus];

    
#pragma Main BackGround ImageView
    UIImageView *mainbg_img = [[UIImageView alloc] init];
    if(IS_IPHONE_5){ mainbg_img.frame=CGRectMake(0,0, 320,520);}
    else{
        mainbg_img.frame=CGRectMake(0,0, 320,480);}
    [mainbg_img setImage:[UIImage imageNamed:@"Main-bg.png"]];
    mainbg_img.userInteractionEnabled=TRUE;
    mainbg_img.opaque = YES;
    [self.view addSubview:mainbg_img];
    [mainbg_img release];
    
#pragma Navigation Bar imageView
    UIImageView *navbarimage = [[UIImageView alloc] init];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
         navbarimage.frame=CGRectMake(0,20, 320,83);
    } else {
         navbarimage.frame=CGRectMake(0,0, 320,83);
    }
   
    [navbarimage setImage:[UIImage imageNamed:@"navbar1.png"]];
    navbarimage.userInteractionEnabled=TRUE;
    navbarimage.opaque = YES;
    [mainbg_img addSubview:navbarimage];
    [navbarimage release];
    
    
#pragma Navigation Bar Title
//    UILabel *navbartitle=[[UILabel alloc] init];
//    navbartitle.frame=CGRectMake(0,2.5,320,34);
//    //navbartitle.text=[NSString stringWithFormat:@"Feedback"];
//     navbartitle.text=[NSString stringWithFormat:@"意见反馈"];
//    navbartitle.textAlignment=1;
//    navbartitle.textColor= [UIColor whiteColor];
//    navbartitle.backgroundColor=[UIColor clearColor];
//    navbartitle.font=[UIFont fontWithName:@"ZhunYuan" size:18];
//    navbartitle.shadowColor = [UIColor grayColor];
//    navbartitle.shadowOffset = CGSizeMake(0,0);
//    [navbarimage addSubview:navbartitle];
//    [navbartitle release];
//    UILabel *navbartitle=[[UILabel alloc] init];
//    navbartitle.frame=CGRectMake(80,53,320,33);
//    navbartitle.text=[NSString stringWithFormat:@"杭州凡闻科技有限公司"];
//    navbartitle.textAlignment=1;
//    navbartitle.textColor= [UIColor whiteColor];
//    navbartitle.backgroundColor=[UIColor clearColor];
//    navbartitle.font=[UIFont fontWithName:@"ZhunYuan" size:13];
//    navbartitle.shadowColor = [UIColor grayColor];
//    navbartitle.shadowOffset = CGSizeMake(0,0);
//    [navbarimage addSubview:navbartitle];
//    [navbartitle release];
#pragma NaviGation Left(back button) bar Button
    UIButton *back_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    back_btn.frame=CGRectMake(5,27,49.5,29);
    [back_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-button" ofType:@"png"]] forState:UIControlStateNormal];
//    back_btn.titleLabel.font=[UIFont fontWithName:@"ZhunYuan" size:13.0f];
//    [back_btn setTitle:@"  返回" forState:UIControlStateNormal];
//    [back_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back_btn addTarget:self action:@selector(back_btnAction) forControlEvents:UIControlEventTouchUpInside];
    [navbarimage addSubview:back_btn];
    

#pragma Buttom Bar ImageView
    UIImageView *midbg_img = [[UIImageView alloc] init];
   
    if(IS_IPHONE_5)
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            midbg_img.frame=CGRectMake(14,93+20,292,388);
        } else {
            midbg_img.frame=CGRectMake(14,93,292,388);
        }
        
    }
    else
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            midbg_img.frame=CGRectMake(14,93+20,292,348);
        } else {
            midbg_img.frame=CGRectMake(14,93,292,348);
        }
        
    }

    [midbg_img setImage:[UIImage imageNamed:@"contact-bg.png"]];
    midbg_img.userInteractionEnabled=TRUE;
    midbg_img.opaque = YES;
    [mainbg_img addSubview:midbg_img];
    [midbg_img release];
    
    
#pragma ScrollView
    maingScrollView = [[UIScrollView alloc] init];
    if (IS_IPHONE_5) {
         maingScrollView.frame=CGRectMake(0, 0, 292, 348);
         maingScrollView.contentSize = CGSizeMake(292,348);
    } else {
         maingScrollView.frame=CGRectMake(0, -10, 292, 300);
         maingScrollView.contentSize = CGSizeMake(292,500);
    }
   
    maingScrollView.backgroundColor = [UIColor clearColor];
   
    [maingScrollView setCanCancelContentTouches:NO];
    maingScrollView.clipsToBounds = YES;
    maingScrollView.scrollEnabled = YES;
    maingScrollView.tag=111;
    [midbg_img addSubview:maingScrollView];
    [maingScrollView release];
      
    
#pragma Name Text imageView
    UIImageView *name_txtimg = [[UIImageView alloc] init];
    name_txtimg.frame=CGRectMake(8.5,20, 275,36);
    [name_txtimg setImage:[UIImage imageNamed:@"txt-field.png"]];
    name_txtimg.userInteractionEnabled=TRUE;
    name_txtimg.opaque = YES;
    [maingScrollView addSubview:name_txtimg];
    [name_txtimg release];

    
#pragma Name Label
//    UILabel *name_lbl=[[UILabel alloc] init];
//    name_lbl.frame=CGRectMake(5,2,50,30);
////    name_lbl.text=[NSString stringWithFormat:@"Name*:"];
//    name_lbl.text=[NSString stringWithFormat:@"姓名*:"];
//    name_lbl.textAlignment=1;
//    name_lbl.textColor= [UIColor colorWithRed:59/255.0f green:93/255.0f blue:102/255.0f alpha:1];
//    name_lbl.backgroundColor=[UIColor clearColor];
//    name_lbl.font=[UIFont fontWithName:@"ZhunYuan" size:13];
//    name_lbl.shadowColor = [UIColor grayColor];
//    name_lbl.shadowOffset = CGSizeMake(0,0);
//    [name_txtimg addSubview:name_lbl];
//    [name_lbl release];

#pragma User Name TextField
    userName_Txt = [[UITextField  alloc] init];
    userName_Txt.frame=CGRectMake(10,2,210,30);
    userName_Txt.borderStyle = UITextBorderStyleNone;
    userName_Txt.font = [UIFont fontWithName:@"ZhunYuan" size:16];
    userName_Txt.textColor=[UIColor blackColor];
    userName_Txt.placeholder=@"姓名* ";
    userName_Txt.backgroundColor=[UIColor clearColor];
    userName_Txt.delegate = self;
    userName_Txt.returnKeyType = UIReturnKeyDefault;
    userName_Txt.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    userName_Txt.tag=100;
    userName_Txt.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [name_txtimg addSubview:userName_Txt];
    
    [userName_Txt release];
    
   
    
    
    
   
#pragma Email Text imageView
    UIImageView *email_txtimg = [[UIImageView alloc] init];
    email_txtimg.frame=CGRectMake(8.5,66, 275,36);
    [email_txtimg setImage:[UIImage imageNamed:@"txt-field.png"]];
    email_txtimg.userInteractionEnabled=TRUE;
    email_txtimg.opaque = YES;
    [maingScrollView addSubview:email_txtimg];
    [email_txtimg release];
   
#pragma Email Label
//    UILabel *email_lbl=[[UILabel alloc] init];
//    email_lbl.frame=CGRectMake(5,2,50,30);
////    email_lbl.text=[NSString stringWithFormat:@"Email*:"];
//    email_lbl.text=[NSString stringWithFormat:@"邮箱*:"]; 
//    email_lbl.textAlignment=1;
//    email_lbl.textColor= [UIColor colorWithRed:59/255.0f green:93/255.0f blue:102/255.0f alpha:1];
//    email_lbl.backgroundColor=[UIColor clearColor];
//    email_lbl.font=[UIFont fontWithName:@"ZhunYuan" size:13];
//    email_lbl.shadowColor = [UIColor grayColor];
//    email_lbl.shadowOffset = CGSizeMake(0,0);
//    [email_txtimg addSubview:email_lbl];
//    [email_lbl release];
    
#pragma Email TextField
    email_Txt = [[UITextField  alloc] init];
    email_Txt.frame=CGRectMake(10,2,210,30);
    email_Txt.borderStyle = UITextBorderStyleNone;
    email_Txt.font = [UIFont fontWithName:@"ZhunYuan" size:16];
    email_Txt.textColor=[UIColor blackColor];
    email_Txt.placeholder=@"邮箱* ";
    email_Txt.backgroundColor=[UIColor clearColor];
    email_Txt.delegate = self;
    email_Txt.returnKeyType = UIReturnKeyDefault;
    email_Txt.textAlignment=0;
    email_Txt.tag=200;
    email_Txt.keyboardType=UIKeyboardTypeEmailAddress;
    email_Txt.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [email_txtimg addSubview:email_Txt];
    
    [email_Txt release];
    
 

    
#pragma Phone Text imageView
    UIImageView *phone_txtimg = [[UIImageView alloc] init];
    phone_txtimg.frame=CGRectMake(8.5,112, 275,36);
    [phone_txtimg setImage:[UIImage imageNamed:@"txt-field.png"]];
    phone_txtimg.userInteractionEnabled=TRUE;
    phone_txtimg.opaque = YES;
    [maingScrollView addSubview:phone_txtimg];
    [phone_txtimg release];
   
    
    
#pragma Phone Label
//    UILabel *phone_lbl=[[UILabel alloc] init];
//    phone_lbl.frame=CGRectMake(5,2,50,30);
//    //phone_lbl.text=[NSString stringWithFormat:@"Phone:"];
//    phone_lbl.text=[NSString stringWithFormat:@"电话:"];
//    phone_lbl.textAlignment=1;
//    phone_lbl.textColor= [UIColor colorWithRed:59/255.0f green:93/255.0f blue:102/255.0f alpha:1];
//    phone_lbl.backgroundColor=[UIColor clearColor];
//    phone_lbl.font=[UIFont fontWithName:@"ZhunYuan" size:13];
//    phone_lbl.shadowColor = [UIColor grayColor];
//    phone_lbl.shadowOffset = CGSizeMake(0,0);
//    [phone_txtimg addSubview:phone_lbl];
//    [phone_lbl release];
    
#pragma Phone  TextField
    phone_Txt = [[UITextField  alloc] init];
    phone_Txt.frame=CGRectMake(10,2,210,30);
    phone_Txt.borderStyle = UITextBorderStyleNone;
    phone_Txt.font =[UIFont fontWithName:@"ZhunYuan" size:16];
    phone_Txt.textColor=[UIColor blackColor];
    phone_Txt.placeholder=@"电话";
    phone_Txt.keyboardType=UIKeyboardTypeNumberPad;
    phone_Txt.backgroundColor=[UIColor clearColor];
    phone_Txt.delegate = self;
    phone_Txt.returnKeyType = UIReturnKeyDefault;
    phone_Txt.textAlignment=0;
    phone_Txt.tag=300;
    phone_Txt.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [phone_txtimg addSubview:phone_Txt];
    
    [phone_Txt release];
    
    
    
#pragma City Text imageView
    UIImageView *city_txtimg = [[UIImageView alloc] init];
    city_txtimg.frame=CGRectMake(8.5,158, 275,36);
    [city_txtimg setImage:[UIImage imageNamed:@"txt-field.png"]];
    city_txtimg.userInteractionEnabled=TRUE;
    city_txtimg.opaque = YES;
    [maingScrollView addSubview:city_txtimg];
    [city_txtimg release];

#pragma City Label
//    UILabel *city_lbl=[[UILabel alloc] init];
//    city_lbl.frame=CGRectMake(5,2,45,30);
//    //city_lbl.text=[NSString stringWithFormat:@"City:"];
//    city_lbl.text=[NSString stringWithFormat:@"城市:"];
//    city_lbl.textAlignment=1;
//    city_lbl.textColor= [UIColor colorWithRed:59/255.0f green:93/255.0f blue:102/255.0f alpha:1];
//    city_lbl.backgroundColor=[UIColor clearColor];
//    city_lbl.font=[UIFont fontWithName:@"ZhunYuan" size:13];
//    city_lbl.shadowColor = [UIColor grayColor];
//    city_lbl.shadowOffset = CGSizeMake(0,0);
//    [city_txtimg addSubview:city_lbl];
//    [city_lbl release];
  
    
#pragma City  TextField
    city_Txt = [[UITextField  alloc] init];
    city_Txt.frame=CGRectMake(10,2,210,30);
    city_Txt.borderStyle = UITextBorderStyleNone;
    city_Txt.font =[UIFont fontWithName:@"ZhunYuan" size:16];
    city_Txt.textColor=[UIColor blackColor];
    city_Txt.placeholder=@"城市";
    city_Txt.backgroundColor=[UIColor clearColor];
    city_Txt.delegate = self;
    city_Txt.returnKeyType = UIReturnKeyDefault;
    city_Txt.textAlignment=0;
    city_Txt.tag=400;
    city_Txt.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [city_txtimg addSubview:city_Txt];
    
    [city_Txt release];

#pragma Message Text imageView
    UIImageView *msg_txtimg = [[UIImageView alloc] init];
    msg_txtimg.frame=CGRectMake(8.5,204, 275,81);
    [msg_txtimg setImage:[UIImage imageNamed:@"message-field.png"]];
    msg_txtimg.userInteractionEnabled=TRUE;
    msg_txtimg.opaque = YES;
    [maingScrollView addSubview:msg_txtimg];
    [msg_txtimg release];
    
    
#pragma Message Label
   msg_lbl=[[UILabel alloc] init];
    msg_lbl.frame=CGRectMake(8,2,75,30);
    //msg_lbl.text=[NSString stringWithFormat:@"Message:"];
    msg_lbl.text=[NSString stringWithFormat:@" 意见"];
    msg_lbl.textAlignment=0;
   // msg_lbl.textColor= [UIColor colorWithRed:59/255.0f green:93/255.0f blue:102/255.0f alpha:1];
    msg_lbl.textColor=[UIColor lightGrayColor];
    msg_lbl.backgroundColor=[UIColor clearColor];
    msg_lbl.font=[UIFont fontWithName:@"ZhunYuan" size:16];
   
    [msg_txtimg addSubview:msg_lbl];
    [msg_lbl release];
    
    
    text_view=[[UITextView alloc]init];
    text_view.frame=CGRectMake(10, 2, 260, 48);
    text_view.backgroundColor=[UIColor clearColor];
    text_view.text=@"";
    text_view.font=[UIFont fontWithName:@"ZhunYuan" size:18];
    text_view.tag=500;
    text_view.delegate=self;
    [msg_txtimg addSubview:text_view];

#pragma Keyboard Done Button
    UIToolbar *toolbar = [[[UIToolbar alloc] init] autorelease];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:flexButton, doneButton, nil];
    
    [flexButton release];
    [doneButton release];
    [toolbar setItems:itemsArray];
    
       
    [userName_Txt setInputAccessoryView:toolbar];
    [email_Txt setInputAccessoryView:toolbar];
    [phone_Txt setInputAccessoryView:toolbar];
    [city_Txt setInputAccessoryView:toolbar];
    [text_view setInputAccessoryView:toolbar];
     
    
    
#pragma Submit Button
    UIButton *submit_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    submit_btn.frame=CGRectMake(7.75,295,276.5,39.5);
    [submit_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"feedback" ofType:@"png"]] forState:UIControlStateNormal];
    
    [submit_btn.titleLabel setFont:[UIFont fontWithName:@"ZhunYuan" size:15.0f]];
    [submit_btn setTitle:@"提交" forState:UIControlStateNormal];
    [submit_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit_btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 9.0f, 0.0f, 0.0f)];
    [submit_btn addTarget:self action:@selector(submit_btnAction) forControlEvents:UIControlEventTouchUpInside];
    [maingScrollView addSubview:submit_btn];
    

    tempindbg=[[UIView alloc]init];
    tempindbg.frame=CGRectMake(0,0,320,568);
    tempindbg.backgroundColor=[UIColor blackColor];
    tempindbg.alpha=0.5;
    tempindbg.hidden=TRUE;
    [mainbg_img addSubview:tempindbg];
    
    
    spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.center = CGPointMake(160, 260);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner stopAnimating];
    [spinner release];
    
  
    
	// Do any additional setup after loading the view.
}
#pragma TextField Delegate Method
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    UIScrollView *scrollview=(UIScrollView *)[self.view viewWithTag:111];
    scrollview.scrollEnabled=YES;
    if (textField.tag==100) {
        [scrollview setContentOffset:CGPointMake(0, 10)animated:YES];}
    else if (textField.tag==200){
        [scrollview setContentOffset:CGPointMake(0, 30) animated:YES];}
    else if (textField.tag==300){
        [scrollview setContentOffset:CGPointMake(0, 80) animated:YES];}
    
    else if (textField.tag==400){
        [scrollview setContentOffset:CGPointMake(0, 150) animated:YES];
    }
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [msg_lbl setHidden:YES];
    UIScrollView *scrollview=(UIScrollView *)[self.view viewWithTag:111];
    scrollview.scrollEnabled=YES;
    if (textView.tag==500) {
        if (IS_IPHONE_5) {
            [scrollview setContentOffset:CGPointMake(0, 160)animated:YES];
        
        }
        else {
            
           
            [scrollview setContentOffset:CGPointMake(0, 170)animated:YES];
        }
        }
    
    
        
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self resignKeyboard];
       return YES;
    
}

-(void)resignKeyboard{
    
    [userName_Txt resignFirstResponder];
    [email_Txt resignFirstResponder];
    [phone_Txt resignFirstResponder];
    [city_Txt resignFirstResponder];
    [text_view resignFirstResponder];
    if ([text_view.text length]==0) {
        [msg_lbl setHidden:NO];
    }
    UIScrollView *scrollview=(UIScrollView *)[self.view viewWithTag:111];
    scrollview.scrollEnabled=YES;
   
        [scrollview setContentOffset:CGPointMake(0, 0)animated:YES];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back_btnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submit_btnAction{
    if(remoteHostStatus == NotReachable) {
        UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"提醒!"
                                                                 message:@"当前没有可用网络，请检查后再试."
                                                                delegate:nil
                                                       cancelButtonTitle:@"确认"
                                                       otherButtonTitles:nil];

        [networkmessage show];
        [networkmessage release];
 }
 else{
               
        if ([userName_Txt.text length]<1 || [email_Txt.text length]<1  ) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒!" message:@"请输入所需的字段" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alert show];
        }
        else{
            NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
            //Valid email address
            if ([emailTest evaluateWithObject:email_Txt.text] == YES)
            {
                tempindbg.hidden=FALSE;
                [spinner startAnimating];

                
                CNFAGetContactUS * Contus=[[CNFAGetContactUS alloc]init];
                Contus.delegate=self;
                [Contus callWebService:userName_Txt.text getemaiID:email_Txt.text getphone:phone_Txt.text getsubject:city_Txt.text getmessage:text_view.text];
                
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒!" message:@"请输入有效的电子邮件地址。" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
                [alert show];
             }
         }
   }
}

-(void)getmsgLists:(NSMutableArray *)successmsg  status:(BOOL)value{

    NSLog(@"SuccessMSG: %@",successmsg);
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒!" message:@"谢谢您的宝贵意见。" delegate:self cancelButtonTitle:@"成功" otherButtonTitles:nil];
    [alert show];
    [alert release];

    tempindbg.hidden=TRUE;
    [spinner stopAnimating];

    [self.navigationController popViewControllerAnimated:YES];
}



@end
