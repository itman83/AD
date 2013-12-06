//
//  CNFACategoryNewsViewController.m
//  CNFANews App
//
//  Created by Dex on 26/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFACategoryNewsViewController.h"
#import "CNFAShareAppViewController.h"
#import "CNFAGlobalDataClass.h"
#import "CNFACategoryCell.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds].size.height - ( double )568 ) < DBL_EPSILON )
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define WiressSDKDemoAppKey     @"801434831"
#define WiressSDKDemoAppSecret  @"6e550f71bb105271cf4738299d79c199"
#define REDIRECTURI             @"http://www.hzfanwen.com/products_ad.html"
#define TCWBAlertViewLogOutTag          100
#define TCWBAlertViewLogInTag           101
@interface CNFACategoryNewsViewController ()

@end


@implementation CNFACategoryNewsViewController


@synthesize eMailaddCitystr,eMailaddNewsstr,eMailaddTimestr,eMaildetailmsgstr,eMailSubjectstr;
@synthesize news_catIDstr,news_cityIdstr,news_Catname,searchtextstr,Isallsearch,news_Namestr,searchtextvalstr,NewsID,cityIDstr;
@synthesize cityName,news_IDstr,fromTab1,uiasView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
//    CNFAGlobalDataClass *obj=[CNFAGlobalDataClass getInstance];
//    if ([obj.lognDone isEqualToString:@"LoginDone"]) {
//        [obj setLognDone:@""];
//        NSLog(@"share ...............");
//       // [ self onLogInOAuthButtonPressed ];
//    }
}
- (void)viewDidLoad
{
   
    [super viewDidLoad];
    
    
    //Make Database connection
    database = [DBConnectionManager getDatabaseObject];
   
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    remoteHostStatus = [reachability currentReachabilityStatus];
    

    
     adddescID=[[NSMutableArray alloc] init];
     adddescTitle=[[NSMutableArray alloc] init];
     adddescDetaiText=[[NSMutableArray alloc] init];
     adddescCreatedDate=[[NSMutableArray alloc] init];
     adddescUpdateTime=[[NSMutableArray alloc] init];
     adddescNewsName=[[NSMutableArray alloc] init];
     adddesCityName=[[NSMutableArray alloc] init];
    
    
    
    fetchadddescID=[[NSMutableArray alloc] init];
    fetchadddescTitle=[[NSMutableArray alloc] init];
    fetchadddescDetaiText=[[NSMutableArray alloc] init];
    fetchadddescCreatedDate=[[NSMutableArray alloc] init];
    fetchadddescUpdateTime=[[NSMutableArray alloc] init];
    fetchadddescNewsName=[[NSMutableArray alloc] init];
    fetchadddesCityName=[[NSMutableArray alloc] init];
    
      
#pragma Main BackGround ImageView
    mainbg_img = [[UIImageView alloc] init];
    if(IS_IPHONE_5){ mainbg_img.frame=CGRectMake(0,0, 320,530);}
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
         navbarimage.frame=CGRectMake(0,0+20, 320,41.5);
    } else {
         navbarimage.frame=CGRectMake(0,0, 320,41.5);
    }
   
    [navbarimage setImage:[UIImage imageNamed:@"navbar.png"]];
    navbarimage.userInteractionEnabled=TRUE;
    navbarimage.opaque = YES;
    [mainbg_img addSubview:navbarimage];
    [navbarimage release];
    
#pragma Navigation Bar Title
//    UILabel *navbartitle=[[UILabel alloc] init];
//    navbartitle.frame=CGRectMake(0,2.5,320,34);
//    //navbartitle.text=[NSString stringWithFormat:@" China News Digest"];
//    navbartitle.text=[NSString stringWithFormat:@"凡事"];
//    navbartitle.textAlignment=1;
//    navbartitle.textColor= [UIColor whiteColor];
//    navbartitle.backgroundColor=[UIColor clearColor];
//    navbartitle.font=[UIFont fontWithName:@"ZhunYuan" size:18];
//    navbartitle.shadowColor = [UIColor grayColor];
//    navbartitle.shadowOffset = CGSizeMake(0,0);
//    [navbarimage addSubview:navbartitle];
//    [navbartitle release];
    
    
#pragma NaviGation Left(back button) bar Button
    UIButton * nav_back_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    nav_back_btn.frame=CGRectMake(5,9,49.5,29);
    [nav_back_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-button" ofType:@"png"]] forState:UIControlStateNormal];
//    nav_back_btn.titleLabel.font=[UIFont fontWithName:@"ZhunYuan" size:13.0f];
//    [nav_back_btn setTitle:@"  返回" forState:UIControlStateNormal];
//    [nav_back_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nav_back_btn addTarget:self action:@selector(back_btnAction) forControlEvents:UIControlEventTouchUpInside];
    [navbarimage addSubview:nav_back_btn];
    
    
    back_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    back_btn.frame=CGRectMake(5,9,49.5,29);
    [back_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-button" ofType:@"png"]] forState:UIControlStateNormal];
//    back_btn.titleLabel.font=[UIFont fontWithName:@"ZhunYuan" size:13.0f];
//    [back_btn setTitle:@"  返回" forState:UIControlStateNormal];
//    [back_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    back_btn.hidden=TRUE;
    [back_btn addTarget:self action:@selector(back_btnActionmainNews) forControlEvents:UIControlEventTouchUpInside];
    [navbarimage addSubview:back_btn];

    
    
    
    
    
    
#pragma Search Bar BackGround ImageView
    UIImageView *searchbg_image = [[UIImageView alloc] init];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        searchbg_image.frame=CGRectMake(0,41.5+20, 320,40.75);
    } else {
        searchbg_image.frame=CGRectMake(0,41.5, 320,40.75);
    }
    
    [searchbg_image setImage:[UIImage imageNamed:@"search-bg.png"]];
    searchbg_image.userInteractionEnabled=TRUE;
    searchbg_image.opaque = YES;
    [mainbg_img addSubview:searchbg_image];
    [searchbg_image release];
    
    
    
//    //#pragma Search Bar BackGround ImageView
//    UIImageView *companylogo = [[UIImageView alloc] init];
//    companylogo.frame=CGRectMake(5,16,52,9);
//    [companylogo setImage:[UIImage imageNamed:@"companyName.png"]];
//    companylogo.userInteractionEnabled=TRUE;
//    companylogo.opaque = YES;
//    companylogo.layer.cornerRadius=18.0f;
//    [searchbg_image addSubview:companylogo];
//    [companylogo release];

#pragma Navigation Bar Title
//    UILabel * companynamelbl=[[UILabel alloc] init];
//    companynamelbl.frame=CGRectMake(2.2,11,80,18);
//    //companynamelbl=[NSString stringWithFormat:@"China News Digest"];
//    companynamelbl.text=[NSString stringWithFormat:@"报纸分类广告"];
//    companynamelbl.textAlignment=0;
//    companynamelbl.textColor= [UIColor whiteColor];
//    companynamelbl.backgroundColor=[UIColor clearColor];
//    companynamelbl.font=[UIFont fontWithName:@"ZhunYuan" size:9];
//    companynamelbl.shadowColor = [UIColor grayColor];
//    companynamelbl.shadowOffset = CGSizeMake(0,0);
//    [searchbg_image addSubview:companynamelbl];
//    [companynamelbl release];
   
    
    UIImageView *search_img = [[UIImageView alloc] init];
    search_img.frame=CGRectMake(35,8.5/2, 188,28);
    [search_img setImage:[UIImage imageNamed:@"search-box.png"]];
    search_img.userInteractionEnabled=TRUE;
    search_img.opaque = YES;
    [searchbg_image addSubview:search_img];
    [search_img release];
    
#pragma User Name TextField
    searchbar_Txt = [[UITextField  alloc] init];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        searchbar_Txt.frame=CGRectMake(25,0, 259.5,28);
    }
    else
    {
        searchbar_Txt.frame=CGRectMake(25,5, 259.5,35);
    }
    searchbar_Txt.borderStyle = UITextBorderStyleNone;
    searchbar_Txt.font = [UIFont fontWithName:@"ZhunYuan" size:13];
    searchbar_Txt.textColor=[UIColor grayColor];
    searchbar_Txt.placeholder=@"这里总有你需要的";
    searchbar_Txt.backgroundColor=[UIColor clearColor];
    searchbar_Txt.delegate = self;
    searchbar_Txt.returnKeyType = UIReturnKeySearch;
    searchbar_Txt.textAlignment=0;
    searchbar_Txt.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [search_img addSubview:searchbar_Txt];
    [searchbar_Txt release];
    
#pragma Search Bar Right ImageView
    UIImageView *searchright_img = [[UIImageView alloc] init];
    searchright_img.frame=CGRectMake(223,8.5/2, 61.5,28);
    [searchright_img setImage:[UIImage imageNamed:@"searchbar-right.png"]];
    searchright_img.userInteractionEnabled=TRUE;
    searchright_img.opaque = YES;
    [searchbg_image addSubview:searchright_img];
    [searchright_img release];
    
    UITextField *searchbar_Txt1 = [[UITextField  alloc] init];
    searchbar_Txt1.frame=CGRectMake(15,0, 61,28);
    searchbar_Txt1.borderStyle = UITextBorderStyleNone;
    searchbar_Txt1.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    searchbar_Txt1.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    searchbar_Txt1.font = [UIFont fontWithName:@"ZhunYuan" size:13];
    searchbar_Txt1.textColor=[UIColor whiteColor];
    searchbar_Txt1.text=@"搜索";
    [searchbar_Txt1 setEnabled:NO];
    searchbar_Txt1.backgroundColor=[UIColor clearColor];
    searchbar_Txt1.delegate = self;
    searchbar_Txt1.returnKeyType = UIReturnKeySearch;
    searchbar_Txt1.textAlignment=0;
    searchbar_Txt1.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [searchright_img addSubview:searchbar_Txt1];
    [searchbar_Txt1 release];
    
    
    UIButton *   searchbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchbtn.frame=CGRectMake(248,8.5/2, 61.5,28);
    [searchbtn addTarget:self action:@selector(searchbtnAction) forControlEvents:UIControlEventTouchUpInside];
    [searchbg_image addSubview:searchbtn];
    
    UIImageView *categorybg_image = [[UIImageView alloc] init];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
         categorybg_image.frame=CGRectMake(0,82.75+20, 320,38.5);
    } else {
         categorybg_image.frame=CGRectMake(0,82.75, 320,38.5);
    }
   
    [categorybg_image setImage:[UIImage imageNamed:@"search-bg.png"]];
    categorybg_image.userInteractionEnabled=TRUE;
    categorybg_image.opaque = YES;
    [mainbg_img addSubview:categorybg_image];
    [categorybg_image release];
#pragma Category ImageView
    UIImageView *category_img = [[UIImageView alloc] init];
    category_img.frame=CGRectMake(8.25,8.5, 303.5,21.5);
    [category_img setImage:[UIImage imageNamed:@"category-select.png"]];
    category_img.userInteractionEnabled=TRUE;
    category_img.opaque = YES;
    [categorybg_image addSubview:category_img];
    [category_img release];
    
#pragma CITY Label
      
    city_lbl=[[UILabel alloc] init];
    city_lbl.frame=CGRectMake(18,0,303,21);
    city_lbl.textAlignment=0;
    if ([fromTab1 isEqualToString:@"Newspaper"]) {
        city_lbl.text=[NSString stringWithFormat:@" %@>>%@",news_Namestr,news_Catname];
    }
    else if ([fromTab1 isEqualToString:@"City"])
    {
        city_lbl.text=[NSString stringWithFormat:@" %@>>%@>>%@",cityName,news_Namestr,news_Catname];
    }
    
    city_lbl.textColor= [UIColor whiteColor];
    city_lbl.backgroundColor=[UIColor clearColor];
    city_lbl.font=[UIFont fontWithName:@"ZhunYuan" size:13];
    [category_img addSubview:city_lbl];
    [city_lbl release];
    
    
#pragma Buttom Bar ImageView
    UIImageView *midbg_img = [[UIImageView alloc] init];
    if(IS_IPHONE_5)
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            midbg_img.frame=CGRectMake(14,125.5+20,292,383);
        } else {
            midbg_img.frame=CGRectMake(14,125.5,292,383);
        }
        
    }
    else
    {
         if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
         {
             midbg_img.frame=CGRectMake(14,125.5+20,292,275);
         }
        else
        {
            midbg_img.frame=CGRectMake(14,125.5,292,275);
        }
        
    }
    [midbg_img setImage:[UIImage imageNamed:@"contact-bg.png"]];
    midbg_img.userInteractionEnabled=TRUE;
    midbg_img.opaque = YES;
    midbg_img.layer.masksToBounds = YES;
    midbg_img.layer.cornerRadius = 10;
    [mainbg_img addSubview:midbg_img];
    [midbg_img release];
  
    NSLog(@"news_catIDstr %@",news_catIDstr);
    NSLog(@"news_catIDstr %@",news_cityIdstr);
    NSLog(@"news_catIDstr %@",news_IDstr);
    NSLog(@"news_catIDstr %@",news_Catname);
 
     
    if(IS_IPHONE_5)
    {
        tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,3, 292, 383-20) style:UITableViewStylePlain];
    }
    else
    {
        tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,0, 292, 275) style:UITableViewStylePlain];
    }
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.backgroundView = nil;
    tableview.separatorColor=[UIColor clearColor];
    tableview.backgroundColor = [UIColor clearColor];
    [tableview setShowsVerticalScrollIndicator:NO];
    [midbg_img addSubview:tableview];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    [tableview registerClass:[CNFACategoryCell class] forCellReuseIdentifier:@"identifier"];

    
    
    noresult_lbl=[[UILabel alloc] init];
    noresult_lbl.frame=CGRectMake(18,0,303,21);
    noresult_lbl.textAlignment=0;
    noresult_lbl.text=@" 对不起！没有找到你需要的信息.";
    noresult_lbl.textColor= [UIColor whiteColor];
    noresult_lbl.backgroundColor=[UIColor clearColor];
    noresult_lbl.font=[UIFont fontWithName:@"ZhunYuan" size:13];
    [tableview addSubview:noresult_lbl];
    [noresult_lbl setHidden:YES];
    [noresult_lbl release];
    
    tempindbg=[[[UIView alloc]init] autorelease];
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
    
    tempindbg.hidden=FALSE;
    [spinner startAnimating];
    
       NSLog(@"Isallsearch %@ searchtextstr %@",Isallsearch,searchtextstr);
 
//Default When Search NewsPaper all and City All 
if([Isallsearch isEqualToString:@"DefaultAllSearch"]){
//     city_lbl.text=[NSString stringWithFormat:@"  Search Keyword: %@",searchtextvalstr];
    city_lbl.text=[NSString stringWithFormat:@"  搜索关键词: %@",searchtextvalstr];
    searchbar_Txt.text=searchtextstr;
     CNFAGetAllAddSearch * gls=[[CNFAGetAllAddSearch alloc]init];
     gls.delegate=self;
     [gls callWebService:searchtextvalstr];
    }
 //Search working on Category class with newd id 
else if([Isallsearch isEqualToString:@"searchBynewsID"]){
      city_lbl.text=[NSString stringWithFormat:@"  搜索关键词: %@",searchtextvalstr];
      searchbar_Txt.text=searchtextstr;
      CNFAGetCatListByNewsandCity * gls=[[CNFAGetCatListByNewsandCity alloc]init];
      gls.delegate=self;
      [gls callWebService:NewsID getsearchtextID:searchtextvalstr];
 }
    //Search it on if select city have nau news list than news list class
 else if([Isallsearch isEqualToString:@"searchByCTID"]){
      city_lbl.text=[NSString stringWithFormat:@"  搜索关键词: %@",searchtextvalstr];
      searchbar_Txt.text=searchtextstr;
      CNFAGetSerchNewsByCtID * gls=[[CNFAGetSerchNewsByCtID alloc]init];
      gls.delegate=self;
      //NewsID=CityID below
      [gls callWebService:NewsID getsearchtextID:searchtextvalstr];
 }
  
else {
        if(remoteHostStatus == NotReachable) {
            UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"提醒!"
                                                        message:@"当前没有可用网络，请检查后再试."
                                                        delegate:nil
                                                        cancelButtonTitle:@"确认"
                                                        otherButtonTitles:nil];
            [networkmessage show];
            [networkmessage release];
            [self FetchRecord_All_CityList_DB];
        }
        else{
            [self fetch_previousTimeStamp_FromDB];
        }
        
    }
	// Do any additional setup after loading the view.
    transview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    [transview setBackgroundColor:[UIColor clearColor]];
    [transview setHidden:YES];
    [mainbg_img addSubview:transview];

    self.uiasView = [[CustomUIASView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height + 230), 320, 300)];
    
    [self.uiasView.tencentButton addTarget:self action:@selector(TencentWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [self.uiasView.weChatButton addTarget:self action:@selector(sendTextContent_WeChat) forControlEvents:UIControlEventTouchUpInside];
    [self.uiasView.emailButton addTarget:self action:@selector(openMail:) forControlEvents:UIControlEventTouchUpInside];
    [self.uiasView.sinaweiboButton addTarget:self action:@selector(SinaWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [self.uiasView.smsButton addTarget:self action:@selector(message_btn:) forControlEvents:UIControlEventTouchUpInside];
    [self.uiasView.cancleBtn addTarget:self action:@selector(dismiss_btn:) forControlEvents:UIControlEventTouchUpInside];
    [mainbg_img addSubview:self.uiasView];
}


-(void)fetch_previousTimeStamp_FromDB{
    sqlite3_stmt * countstatement;
    if(fetchadddescUpdateTime){
        [fetchadddescUpdateTime removeAllObjects];}
    
    NSString *sqlString1 = [NSString stringWithFormat:@"select UpdateTime from  AddsDescription WHERE CatID=%@",news_catIDstr];
    
    const char *sql = [sqlString1 UTF8String];
    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(countstatement) == SQLITE_ROW){
            NSString * UpdateTimeStamp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,0)];
            [fetchadddescUpdateTime addObject:UpdateTimeStamp];
        }
        sqlite3_finalize(countstatement);
    }
    
    //Call service for News List
    
    CNFAGetSubCatDetail * addservice=[[CNFAGetSubCatDetail alloc]init];
    addservice.delegate=self;
    [addservice callWebService:news_cityIdstr];
    
    
}


-(void)Delete_All_CityList_Table_DB{
    NSString *insertSQL;
    insertSQL = [NSString stringWithFormat: @"DELETE FROM AddsDescription WHERE CatID=%@",news_catIDstr];
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
    sqlite3_step(InsertStatement);
    sqlite3_finalize(InsertStatement);
    [self InsertRecord_ToAll_CityList_DB];
}



-(void)InsertRecord_ToAll_CityList_DB{
    NSString *insertSQL;
    for(int i=0; i<[adddescID count];i++){
        insertSQL = [NSString stringWithFormat: @"INSERT INTO AddsDescription (NewsID,CityID,CatID,AddTitle,AddTextdsc,CityName,NewsName,NewsDate,UpdateTime,AddID) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",news_IDstr,news_cityIdstr,news_catIDstr,[adddescTitle objectAtIndex:i],[adddescDetaiText objectAtIndex:i],[adddesCityName objectAtIndex:i],news_Namestr,[adddescCreatedDate objectAtIndex:i],[adddescUpdateTime objectAtIndex:i],[adddescID objectAtIndex:i]];
        
        NSLog(@"insertSQL-- %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
        sqlite3_step(InsertStatement);
    }
    sqlite3_finalize(InsertStatement);
    
    [self FetchRecord_All_CityList_DB];
}





//come from Newsclass  view by search
-(void)getAddnewsSubtitleByCTIDsearch:(NSMutableArray *)addcategID  getaddcatTitleName:(NSMutableArray *)addcatName getaddCatText:(NSMutableArray *)cattext getaddcatCityname:(NSMutableArray *)addCityName getadddescNews:(NSMutableArray *)addNewsName  getaddCatadddTimeName:(NSMutableArray *)Timeadded getaddCatUpdateTimeStamp:(NSMutableArray *)addupdateTimeStamp   status:(BOOL)value{
     if(fetchadddescID){[fetchadddescID removeAllObjects];}
    if(fetchadddescTitle){[fetchadddescTitle removeAllObjects];}
    if(fetchadddescDetaiText){[fetchadddescDetaiText removeAllObjects];}
    if(fetchadddescCreatedDate){[fetchadddescCreatedDate removeAllObjects];}
    if(fetchadddescUpdateTime){[fetchadddescUpdateTime removeAllObjects];}
    if(fetchadddescNewsName){[fetchadddescNewsName removeAllObjects];}
    if(fetchadddesCityName){[fetchadddesCityName removeAllObjects];}
    
    fetchadddescID =[addcategID mutableCopy];
    fetchadddescTitle =[addcatName mutableCopy];
    fetchadddescDetaiText =[cattext mutableCopy];
    fetchadddescCreatedDate =[Timeadded mutableCopy];
    fetchadddescUpdateTime =[addupdateTimeStamp mutableCopy];
    fetchadddescNewsName =[addNewsName mutableCopy];
    fetchadddesCityName =[addCityName mutableCopy];
    
   
    
    if([fetchadddescID count]>0){
        ISTempStorSearch=TRUE;
        [self Delete_TempStoreDescSearch_CityList_Table_DB];
        [noresult_lbl setHidden:YES];
        [tableview reloadData];
        
    }else{
        tempindbg.hidden=TRUE;
        [spinner stopAnimating];
        [tableview reloadData];
        [noresult_lbl setHidden:NO];
        
    }
    
}




//come from cat view by search
 -(void)getAddnewsSubtitleByNewsIDsearch:(NSMutableArray *)addcategID  getaddcatTitleName:(NSMutableArray *)addcatName getaddCatText:(NSMutableArray *)cattext getaddcatCityname:(NSMutableArray *)addCityName getadddescNews:(NSMutableArray *)addNewsName  getaddCatadddTimeName:(NSMutableArray *)Timeadded getaddCatUpdateTimeStamp:(NSMutableArray *)addupdateTimeStamp   status:(BOOL)value
{ 
    if(fetchadddescID){[fetchadddescID removeAllObjects];}
    if(fetchadddescTitle){[fetchadddescTitle removeAllObjects];}
    if(fetchadddescDetaiText){[fetchadddescDetaiText removeAllObjects];}
    if(fetchadddescCreatedDate){[fetchadddescCreatedDate removeAllObjects];}
    if(fetchadddescUpdateTime){[fetchadddescUpdateTime removeAllObjects];}
    if(fetchadddescNewsName){[fetchadddescNewsName removeAllObjects];}
    if(fetchadddesCityName){[fetchadddesCityName removeAllObjects];}
    
    fetchadddescID =[addcategID mutableCopy];
    fetchadddescTitle =[addcatName mutableCopy];
    fetchadddescDetaiText =[cattext mutableCopy];
    fetchadddescCreatedDate =[Timeadded mutableCopy];
    fetchadddescUpdateTime =[addupdateTimeStamp mutableCopy];
    fetchadddescNewsName =[addNewsName mutableCopy];
    fetchadddesCityName =[addCityName mutableCopy];
    
     NSLog(@"addNewsName %@",addNewsName);
    
    if([fetchadddescID count]>0){
        ISTempStorSearch=TRUE;
          [self Delete_TempStoreDescSearch_CityList_Table_DB];
        [noresult_lbl setHidden:YES];
        [tableview reloadData];
        
    }else{
        tempindbg.hidden=TRUE;
        [spinner stopAnimating];
        [tableview reloadData];
        [noresult_lbl setHidden:NO];
    }
    
}




//Delegate method when search any news
-(void)getAddnewsSubtitleByAllSearch:(NSMutableArray *)addcategID  getaddcatTitleName:(NSMutableArray *)addcatName getaddCatText:(NSMutableArray *)cattext getaddcatCityname:(NSMutableArray *)addCityName getadddescNews:(NSMutableArray *)addNewsName  getaddCatadddTimeName:(NSMutableArray *)Timeadded getaddCatUpdateTimeStamp:(NSMutableArray *)addupdateTimeStamp   status:(BOOL)value{
    
    
    
    if(fetchadddescID){[fetchadddescID removeAllObjects];}
    if(fetchadddescTitle){[fetchadddescTitle removeAllObjects];}
    if(fetchadddescDetaiText){[fetchadddescDetaiText removeAllObjects];}
    if(fetchadddescCreatedDate){[fetchadddescCreatedDate removeAllObjects];}
    if(fetchadddescUpdateTime){[fetchadddescUpdateTime removeAllObjects];}
    if(fetchadddescNewsName){[fetchadddescNewsName removeAllObjects];}
    if(fetchadddesCityName){[fetchadddesCityName removeAllObjects];}
    
    fetchadddescID =[addcategID mutableCopy];
    fetchadddescTitle =[addcatName mutableCopy];
    fetchadddescDetaiText =[cattext mutableCopy];
    fetchadddescCreatedDate =[Timeadded mutableCopy];
    fetchadddescUpdateTime =[addupdateTimeStamp mutableCopy];
    fetchadddescNewsName =[addNewsName mutableCopy];
    fetchadddesCityName =[addCityName mutableCopy];
    
    
    if([fetchadddescID count]>0){
     ISTempStorSearch=TRUE;
     [self Delete_TempStoreDescSearch_CityList_Table_DB];
        [noresult_lbl setHidden:YES];
     [tableview reloadData];
    
    }else{
        tempindbg.hidden=TRUE;
        [spinner stopAnimating];
        [tableview reloadData];
        [noresult_lbl setHidden:NO];
    }
    
}


-(void)getSearchListonSubcatView:(NSMutableArray *)addcategID  getaddcatTitleName:(NSMutableArray *)addcatName getaddCatText:(NSMutableArray *)cattext getaddcatCityname:(NSMutableArray *)addCityName getadddescNews:(NSMutableArray *)addNewsName  getaddCatadddTimeName:(NSMutableArray *)Timeadded getaddCatUpdateTimeStamp:(NSMutableArray *)addupdateTimeStamp   status:(BOOL)value{
    
    
    
    if(fetchadddescID){[fetchadddescID removeAllObjects];}
    if(fetchadddescTitle){[fetchadddescTitle removeAllObjects];}
    if(fetchadddescDetaiText){[fetchadddescDetaiText removeAllObjects];}
    if(fetchadddescCreatedDate){[fetchadddescCreatedDate removeAllObjects];}
    if(fetchadddescUpdateTime){[fetchadddescUpdateTime removeAllObjects];}
    if(fetchadddescNewsName){[fetchadddescNewsName removeAllObjects];}
    if(fetchadddesCityName){[fetchadddesCityName removeAllObjects];}
    
    fetchadddescID =[addcategID mutableCopy];
    fetchadddescTitle =[addcatName mutableCopy];
    fetchadddescDetaiText =[cattext mutableCopy];
    fetchadddescCreatedDate =[Timeadded mutableCopy];
    fetchadddescUpdateTime =[addupdateTimeStamp mutableCopy];
    fetchadddescNewsName =[addNewsName mutableCopy];
    fetchadddesCityName =[addCityName mutableCopy];
    
    
    if([fetchadddescID count]>0){
        ISTempStorSearch=TRUE;
        [self Delete_TempStoreDescSearch_CityList_Table_DB];
        [noresult_lbl setHidden:YES];
        [tableview reloadData];
        
    }else{
        tempindbg.hidden=TRUE;
        [spinner stopAnimating];
        [tableview reloadData];
        [noresult_lbl setHidden:NO];
    }
    
}




-(void)FetchRecord_All_CityList_DB{
    sqlite3_stmt * countstatement;
    if(fetchadddescID){[fetchadddescID removeAllObjects];}
    if(fetchadddescTitle){[fetchadddescTitle removeAllObjects];}
    if(fetchadddescDetaiText){[fetchadddescDetaiText removeAllObjects];}
    if(fetchadddescCreatedDate){[fetchadddescCreatedDate removeAllObjects];}
    if(fetchadddescUpdateTime){[fetchadddescUpdateTime removeAllObjects];}
    if(fetchadddescNewsName){[fetchadddescNewsName removeAllObjects];}
    if(fetchadddesCityName){[fetchadddesCityName removeAllObjects];}
    
  
    NSString *sqlString1 = [NSString stringWithFormat:@"SELECT  NewsID,CityID,CatID,AddTitle,AddTextdsc,CityName,NewsName,NewsDate,UpdateTime,AddID  FROM AddsDescription Where NewsID=%@ and CityID=%@ and CatID=%@",news_IDstr,news_cityIdstr,news_catIDstr];
    
    NSLog(@"sqlString1--%@",sqlString1);
     
    const char *sql = [sqlString1 UTF8String];
    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(countstatement) == SQLITE_ROW){
            NSString * addID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,9)];
            NSString * AddTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,3)];
            NSString * addTitleDsc = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,4)];
            NSString * AddCreatedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,7)];
            NSString * addNewsName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,6)];
            NSString * addNewsCity = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,5)];
            NSString * Newsupdatetime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,8)];
            
            [fetchadddescID addObject:addID];
            [fetchadddescTitle addObject:AddTitle];
            [fetchadddescDetaiText addObject:addTitleDsc];
            [fetchadddescCreatedDate addObject:AddCreatedDate];
            [fetchadddescUpdateTime addObject:Newsupdatetime];
            [fetchadddescNewsName addObject:addNewsName];
            [fetchadddesCityName addObject:addNewsCity];
        }
        
        sqlite3_finalize(countstatement);
    }
    
    
    if([fetchadddescID count]>0){
        
//        city_lbl.text=[NSString stringWithFormat:@"News: %@",[fetchadddescNewsName objectAtIndex:0]];
//        City_lbl2.text=[NSString stringWithFormat:@" City: %@",[fetchadddesCityName objectAtIndex:0]];
        [noresult_lbl setHidden:YES];
    [tableview reloadData];
    }
    else{
        [tableview reloadData];
        tempindbg.hidden=TRUE;
        [spinner stopAnimating];
         [noresult_lbl setHidden:NO];
    }
}


-(void)getAddnewsSubtitle:(NSMutableArray *)addcategID  getaddcatTitleName:(NSMutableArray *)addcatName getaddCatText:(NSMutableArray *)addcatlogotext getaddcatCityname:(NSMutableArray *)addCityName getadddescNews:(NSMutableArray *)addNewsName  getaddCatadddTimeName:(NSMutableArray *)Timeadded getaddCatUpdateTimeStamp:(NSMutableArray *)addupdateTimeStamp  status:(BOOL)value{
    if(adddescID){[adddescID removeAllObjects];}
    if(adddescTitle){[adddescTitle removeAllObjects];}
    if(adddescDetaiText){[adddescDetaiText removeAllObjects];}
    if(adddescCreatedDate){[adddescCreatedDate removeAllObjects];}
    if(adddescUpdateTime){[adddescUpdateTime removeAllObjects];}
   //  if(adddescNewsName){[adddescNewsName removeAllObjects];}
     if(adddesCityName){[adddesCityName removeAllObjects];}
   
    adddescID=[addcategID mutableCopy];
    adddescTitle=[addcatName mutableCopy];
    adddescDetaiText=[addcatlogotext mutableCopy];
    adddescCreatedDate=[Timeadded mutableCopy];
    adddescUpdateTime=[addupdateTimeStamp mutableCopy];
   // adddescNewsName=[addNewsName mutableCopy];
    adddesCityName=[addCityName mutableCopy];
   
    if([fetchadddescUpdateTime isEqualToArray:adddescUpdateTime]){
    
        NSLog(@"Match");
        [self FetchRecord_All_CityList_DB];
    
    }
    else{
        [self Delete_All_CityList_Table_DB];
    NSLog(@"Did Not Match");
    }
    
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"didSelectRowAtIndexPath===%d",indexPath.row);
    
    
    CNFASubCategoryDetailViewController *gotocatogery_Cls=[[CNFASubCategoryDetailViewController alloc]init];
    [gotocatogery_Cls setAddCityNamestr:[fetchadddesCityName objectAtIndex:indexPath.row]];
    [gotocatogery_Cls setAdddetailtextstr:[fetchadddescDetaiText objectAtIndex:indexPath.row]];
    [gotocatogery_Cls setAddNewsNamestr:[fetchadddescNewsName objectAtIndex:indexPath.row]];
    [gotocatogery_Cls setAddTimestr:[fetchadddescCreatedDate objectAtIndex:indexPath.row]];
    [gotocatogery_Cls setAddtitlestr:[fetchadddescTitle objectAtIndex:indexPath.row]];
    [gotocatogery_Cls setAddIDstr:[fetchadddescID objectAtIndex:indexPath.row]];
    [gotocatogery_Cls setAddUpdateTime:[fetchadddescUpdateTime objectAtIndex:indexPath.row]];
    
    
  
    gotocatogery_Cls.subCategory_UpdateTimearr=[[NSMutableArray alloc]init];
    gotocatogery_Cls.subCategory_AddTitlearr=[[NSMutableArray alloc]init];
    gotocatogery_Cls.subCategory_AddNewsNamearr=[[NSMutableArray alloc]init];
    gotocatogery_Cls.subCategory_AddIDarr=[[NSMutableArray alloc]init];
    gotocatogery_Cls.subCategory_AddDetailTextarr=[[NSMutableArray alloc]init];
    gotocatogery_Cls.subCategory_AddCreatedTimearr=[[NSMutableArray alloc]init];
    gotocatogery_Cls.subCategory_AddCityNamearr=[[NSMutableArray alloc]init];
    [gotocatogery_Cls setPageCurr:[NSString stringWithFormat:@"%d",indexPath.row]];
    gotocatogery_Cls.subCategory_AddCityNamearr=fetchadddesCityName;
    gotocatogery_Cls.subCategory_UpdateTimearr=fetchadddescUpdateTime;
    gotocatogery_Cls.subCategory_AddTitlearr=fetchadddescTitle;
    gotocatogery_Cls.subCategory_AddNewsNamearr=fetchadddescNewsName;
    gotocatogery_Cls.subCategory_AddIDarr=fetchadddescID;
    gotocatogery_Cls.subCategory_AddDetailTextarr=fetchadddescDetaiText;
    gotocatogery_Cls.subCategory_AddCreatedTimearr=fetchadddescCreatedDate;
    
    
    if ([fromTab1 isEqualToString:@"Newspaper"]) {
        
        [gotocatogery_Cls setFromTab:@"Newspaper"];
        [gotocatogery_Cls setNews_Namestr:news_Namestr];
        [gotocatogery_Cls  setNews_Catname:news_Catname];
        //city_lbl.text=[NSString stringWithFormat:@" %@>>%@",news_Namestr,news_Catname];
    }
    else if ([fromTab1 isEqualToString:@"City"])
    {
        [gotocatogery_Cls setFromTab:@"City"];
        [gotocatogery_Cls setCityName:cityName];
        [gotocatogery_Cls setNews_Namestr:news_Namestr];
        [gotocatogery_Cls  setNews_Catname:news_Catname];
        //city_lbl.text=[NSString stringWithFormat:@" %@>>%@>>%@",cityName,news_Namestr,news_Catname];
    }
    else if ([fromTab1 isEqualToString:@"NewspaperSearch"])
    {
        [gotocatogery_Cls setFromTab:@"NewspaperSearch"];
        [gotocatogery_Cls setNews_Namestr:city_lbl.text];
        
    }else if ([fromTab1 isEqualToString:@"CitySearch"])
    {
        [gotocatogery_Cls setFromTab:@"CitySearch"];
        [gotocatogery_Cls setNews_Namestr:city_lbl.text];
        
    }else if ([fromTab1 isEqualToString:@"NewspaperByCitySearch"])
    {
        [gotocatogery_Cls setFromTab:@"NewspaperByCitySearch"];
        [gotocatogery_Cls setNews_Namestr:city_lbl.text];
        
    }
    else if ([fromTab1 isEqualToString:@"CategorySearch"])
    {
        [gotocatogery_Cls setFromTab:@"CategorySearch"];
        [gotocatogery_Cls setNews_Namestr:city_lbl.text];
        
    }
    
    
    [self.navigationController pushViewController:gotocatogery_Cls animated:YES];
    [gotocatogery_Cls release];
     
}


#pragma Tableview Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [fetchadddescTitle count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return   73.0f;
}
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell1
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell1 setBackgroundColor:[UIColor clearColor]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
     static NSString *identifier=@"identifier";
    CNFACategoryCell * cell1=Nil;
    if (cell1==nil) {
        cell1=(CNFACategoryCell *)[tableview dequeueReusableCellWithIdentifier:identifier];
        cell1=[[[CNFACategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell1.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midd-row.png"]] autorelease];
        cell1.selectionStyle=UITableViewCellSelectionStyleNone;
        //cell1.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
      //  NSLog(@"fetchadddescDetaiText %@",fetchadddescDetaiText);
        
        
        
#pragma Cell Image View
        UILabel* cell_lbl1=[[UILabel alloc] init];
        cell_lbl1.frame=CGRectMake(15,2,200,20);
        cell_lbl1.text=[NSString stringWithFormat:@"%@",[fetchadddescTitle objectAtIndex:indexPath.row]];
        cell_lbl1.textAlignment=0;
        cell_lbl1.textColor= [UIColor colorWithRed:68/255.0f green:192/255.0f blue:181/255.0f alpha:1];
        cell_lbl1.backgroundColor=[UIColor clearColor];
        cell_lbl1.font=[UIFont fontWithName:@"ZhunYuan" size:14];
        cell_lbl1.shadowColor = [UIColor grayColor];
        cell_lbl1.shadowOffset = CGSizeMake(0,0);
        [cell1 addSubview:cell_lbl1];
        [cell_lbl1 release];
        
#pragma Cell Image View
        UIWebView* celltxt_lbl=[[UIWebView alloc] init];
        celltxt_lbl.frame=CGRectMake(25,20,245,24);
        celltxt_lbl.backgroundColor=[UIColor clearColor];
        [celltxt_lbl setOpaque:NO];
        celltxt_lbl.delegate=self;
        celltxt_lbl.scrollView.scrollEnabled=NO;
        
        [celltxt_lbl setDataDetectorTypes:UIDataDetectorTypePhoneNumber];
        [celltxt_lbl loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:2; } p { color:white; font-family:ZhunYuan; font-size:13px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",[fetchadddescDetaiText objectAtIndex:indexPath.row]] baseURL:nil];

//        celltxt_lbl.numberOfLines=2;
//        celltxt_lbl.text=[NSString stringWithFormat:@"%@",[fetchadddescDetaiText objectAtIndex:indexPath.row]];
//        celltxt_lbl.textAlignment=0;
//        celltxt_lbl.textColor= [UIColor whiteColor];
//        celltxt_lbl.backgroundColor=[UIColor clearColor];
//        celltxt_lbl.font=[UIFont fontWithName:@"ZhunYuan" size:12];
//        celltxt_lbl.shadowColor = [UIColor grayColor];
//        celltxt_lbl.shadowOffset = CGSizeMake(0,0);
        [cell1 addSubview:celltxt_lbl];
        [celltxt_lbl release];
        
            
//68, g:192, b:181
#pragma Cell Image View
        UILabel* celltxt_lbl3=[[UILabel alloc] init];
        celltxt_lbl3.frame=CGRectMake(50,42,230,22);
        celltxt_lbl3.numberOfLines=2;
        celltxt_lbl3.text=[NSString stringWithFormat:@"%@ | %@ | %@",[fetchadddescNewsName objectAtIndex:indexPath.row],[fetchadddesCityName objectAtIndex:indexPath.row],[fetchadddescCreatedDate objectAtIndex:indexPath.row]];
        celltxt_lbl3.textAlignment=2;
        celltxt_lbl3.textColor= [UIColor colorWithRed:68/255.0f green:192/255.0f blue:181/255.0f alpha:1];
        celltxt_lbl3.backgroundColor=[UIColor clearColor];
        celltxt_lbl3.font=[UIFont fontWithName:@"ZhunYuan" size:12];
        celltxt_lbl3.shadowColor = [UIColor grayColor];
        celltxt_lbl3.shadowOffset = CGSizeMake(0,0);
        [cell1 addSubview:celltxt_lbl3];
        [celltxt_lbl3 release];
        cell1.selectionStyle=UITableViewStylePlain;
        
            
#pragma Share Button
        UIButton *share_btn =[UIButton buttonWithType:UIButtonTypeCustom];
        share_btn.frame=CGRectMake(260,11,22+7,21.5+7);
        [share_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"share-button" ofType:@"png"]] forState:UIControlStateNormal];
        share_btn.tag=indexPath.row;
        [share_btn addTarget:self action:@selector(share_btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell1 addSubview:share_btn];
       
    }
    tempindbg.hidden=TRUE;
    [spinner stopAnimating];
    return cell1;
}


-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType
{
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        NSLog(@"TELEPHONE URL %@",inRequest.URL);
        //[[UIApplication sharedApplication] openURL:inRequest.URL];
        if ([[inRequest.URL scheme] isEqual:@"mailto"]) {
            NSLog(@"mail to");
            if ([MFMailComposeViewController canSendMail]){
                MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
                mailer.mailComposeDelegate = self;
                
                NSArray *toRecipients = [NSArray arrayWithObjects:[[NSString stringWithFormat:@"%@",inRequest.URL]stringByReplacingOccurrencesOfString:@"mailto:" withString:@""], nil];
                [mailer setToRecipients:toRecipients];
                
                
                [self presentModalViewController:mailer animated:YES];
                [mailer release];
            }
            else{
                
                UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"警告"
                                                                 message:@"您的设备不支持的作曲家表"
                                                                delegate:nil
                                                       cancelButtonTitle:@"确认"
                                                       otherButtonTitles: nil];
                [alert1 show];
                [alert1 release];
            }

            return NO;
        }
        else if ([[inRequest.URL scheme] isEqual:@"tel"])
        {
            NSLog(@"tel");
        
        
        
        NSString *ph=[[NSString stringWithFormat:@"%@",inRequest.URL] stringByReplacingOccurrencesOfString:@"%20" withString:@""];
        self.ph1=[ph stringByReplacingOccurrencesOfString:@"tel" withString:@""];
       // ph=[ph stringByReplacingOccurrencesOfString:@"tel" withString:@"致电"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.ph1]]];
        }
        else
        {
            [[UIApplication sharedApplication] openURL:inRequest.URL];
        }
//        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"提醒:"
//                                                         message:[NSString stringWithFormat:@"%@",ph]
//                                                        delegate:self
//                                               cancelButtonTitle:@"确认"
//                                               otherButtonTitles:@"取消",Nil];
//        [alert1 setTag:1111];
//        [alert1 show];
//        [alert1 release];
        
        //[[UIApplication sharedApplication] openURL:inRequest.URL];
        
        return NO;
    }
    
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && alertView.tag==1111)
    {
        UIDevice *device = [UIDevice currentDevice];
        if ([[device model] isEqualToString:@"iPhone"] ) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.ph1]]];
        } else {
            UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"提醒:" message:@"您的设备不支持此功能." delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [Notpermitted show];
            [Notpermitted release];
        }
        
    }
    if (buttonIndex == 1)
    {
        //Code for download button
    }
}

//Nav bar search btn action
-(void)searchbtnAction{
 NSLog(@"Btn Click");
 [searchbar_Txt resignFirstResponder];
 if([searchbar_Txt.text length]>0){
   if(remoteHostStatus == NotReachable) {
       UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"提醒!"
                                                    message:@"当前没有可用网络，请检查后再试. "
                                                    delegate:nil
                                                    cancelButtonTitle:@"确认"
                                                    otherButtonTitles:nil];
       [networkmessage show];
       [networkmessage release];
    }
     else{
        if([ searchbar_Txt.text length]>0){
             if(ISTempStorSearch){
                  [self search_record_from_tempstoredTable];}
               else{
                    [self Search_record_fromLocalDB_AddsDescriptiontable];
                
               }
            }
         }
    }
}


-(void)Search_record_fromLocalDB_AddsDescriptiontable{
    back_btn.hidden=FALSE;
    tempindbg.hidden=FALSE;
    [spinner startAnimating];
    city_lbl.text=[NSString stringWithFormat:@"  搜索关键词: %@",searchbar_Txt.text];
    
    
    sqlite3_stmt * countstatement;
    if(fetchadddescID){[fetchadddescID removeAllObjects];}
    if(fetchadddescTitle){[fetchadddescTitle removeAllObjects];}
    if(fetchadddescDetaiText){[fetchadddescDetaiText removeAllObjects];}
    if(fetchadddescCreatedDate){[fetchadddescCreatedDate removeAllObjects];}
    if(fetchadddescUpdateTime){[fetchadddescUpdateTime removeAllObjects];}
    if(fetchadddescNewsName){[fetchadddescNewsName removeAllObjects];}
    if(fetchadddesCityName){[fetchadddesCityName removeAllObjects];}
    
    
    NSString *sqlString1 = [NSString stringWithFormat:@"SELECT * FROM AddsDescription WHERE (AddTitle LIKE '%%%@%%' or AddTextdsc  LIKE '%%%@%%'  or CityName LIKE '%%%@%%') AND CatID=%@",searchbar_Txt.text,searchbar_Txt.text,searchbar_Txt.text,news_catIDstr];
    
    NSLog(@"sqlString1--%@",sqlString1);
    
    const char *sql = [sqlString1 UTF8String];
    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(countstatement) == SQLITE_ROW){
            NSString * addID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,10)];
            NSString * AddTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,4)];
            NSString * addTitleDsc = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,5)];
            NSString * AddCreatedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,8)];
            NSString * addNewsName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,7)];
            NSString * addNewsCity = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,6)];
            NSString * Newsupdatetime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,9)];
            
            [fetchadddescID addObject:addID];
            [fetchadddescTitle addObject:AddTitle];
            [fetchadddescDetaiText addObject:addTitleDsc];
            [fetchadddescCreatedDate addObject:AddCreatedDate];
            [fetchadddescUpdateTime addObject:Newsupdatetime];
            [fetchadddescNewsName addObject:addNewsName];
            [fetchadddesCityName addObject:addNewsCity];
        }
        
        sqlite3_finalize(countstatement);
    }
    
    if([fetchadddescID count]>0){
        searchbar_Txt.text=@"";
        [noresult_lbl setHidden:YES];
        [tableview reloadData];
    }
    else{
        searchbar_Txt.text=@"";
        [tableview reloadData];
        tempindbg.hidden=TRUE;
        [spinner stopAnimating];
        [noresult_lbl setHidden:NO];
    }
}


-(void)Delete_TempStoreDescSearch_CityList_Table_DB{
    NSString *insertSQL;
    insertSQL = [NSString stringWithFormat: @"DELETE FROM TempStoreDescSearch"];
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
    sqlite3_step(InsertStatement);
    sqlite3_finalize(InsertStatement);
    [self InsertRecord_TempStoreDescSearch_CityList_DB];
}


-(void)InsertRecord_TempStoreDescSearch_CityList_DB{
    NSString *insertSQL;
    for(int i=0; i<[fetchadddescDetaiText count];i++){
        insertSQL = [NSString stringWithFormat: @"INSERT INTO TempStoreDescSearch (AddTitle,AddTextdsc,CityName,NewsName,NewsDate,UpdateTime,AddID) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",[fetchadddescTitle objectAtIndex:i],[fetchadddescDetaiText objectAtIndex:i],[fetchadddesCityName objectAtIndex:i],[fetchadddescNewsName objectAtIndex:i],[fetchadddescCreatedDate objectAtIndex:i],[fetchadddescUpdateTime objectAtIndex:i],[fetchadddescID objectAtIndex:i]];
        
        NSLog(@"insertSQLeeeeee-- %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
        sqlite3_step(InsertStatement);
    }
    sqlite3_finalize(InsertStatement);
}

-(void)search_record_from_tempstoredTable{
    back_btn.hidden=FALSE;
    tempindbg.hidden=FALSE;
    [spinner startAnimating];
    city_lbl.text=[NSString stringWithFormat:@"  搜索关键词: %@",searchbar_Txt.text];
    
    
    sqlite3_stmt * countstatement;
    if(fetchadddescID){[fetchadddescID removeAllObjects];}
    if(fetchadddescTitle){[fetchadddescTitle removeAllObjects];}
    if(fetchadddescDetaiText){[fetchadddescDetaiText removeAllObjects];}
    if(fetchadddescCreatedDate){[fetchadddescCreatedDate removeAllObjects];}
    if(fetchadddescUpdateTime){[fetchadddescUpdateTime removeAllObjects];}
    if(fetchadddescNewsName){[fetchadddescNewsName removeAllObjects];}
    if(fetchadddesCityName){[fetchadddesCityName removeAllObjects];}
    
    
    NSString *sqlString1 = [NSString stringWithFormat:@"SELECT * FROM TempStoreDescSearch WHERE AddTitle LIKE '%%%@%%' or AddTextdsc  LIKE '%%%@%%'  or CityName LIKE '%%%@%%' ",searchbar_Txt.text,searchbar_Txt.text,searchbar_Txt.text];
    
    NSLog(@"sqlString1--%@",sqlString1);
    
    const char *sql = [sqlString1 UTF8String];
    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(countstatement) == SQLITE_ROW){
            NSString * addID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,10)];
            NSString * AddTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,4)];
            NSString * addTitleDsc = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,5)];
            NSString * AddCreatedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,8)];
            NSString * addNewsName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,7)];
            NSString * addNewsCity = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,6)];
            NSString * Newsupdatetime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,9)];
             
            [fetchadddescID addObject:addID];
            [fetchadddescTitle addObject:AddTitle];
            [fetchadddescDetaiText addObject:addTitleDsc];
            [fetchadddescCreatedDate addObject:AddCreatedDate];
            [fetchadddescUpdateTime addObject:Newsupdatetime];
            [fetchadddescNewsName addObject:addNewsName];
            [fetchadddesCityName addObject:addNewsCity];
        }
        
        sqlite3_finalize(countstatement);
    }
    
      if([fetchadddescID count]>0){
      searchbar_Txt.text=@"";
          [noresult_lbl setHidden:YES];
      [tableview reloadData];
    }
    else{
        searchbar_Txt.text=@"";
        [tableview reloadData];
        tempindbg.hidden=TRUE;
        [spinner stopAnimating];
        [noresult_lbl setHidden:NO];
    }
}


//When get search result than search bar back btn action
-(void)back_btnActionmainNews{
   
    if(ISTempStorSearch){
        [self default_filltable_tempdb];
    }
    else{
        if (news_Catname !=NULL) {
            city_lbl.text=[NSString stringWithFormat:@"  类别 : %@",news_Catname];
        }
        else
        {
             news_Catname=@"";
             city_lbl.text=[NSString stringWithFormat:@"  类别 : %@",news_Catname];
        }
       
      [self FetchRecord_All_CityList_DB];
        
    }
    
    back_btn.hidden=TRUE;
   }


//Set here default list
-(void)default_filltable_tempdb{
    city_lbl.text=[NSString stringWithFormat:@"  搜索 : %@",searchtextvalstr];
  
    sqlite3_stmt * countstatement;
    if(fetchadddescID){[fetchadddescID removeAllObjects];}
    if(fetchadddescTitle){[fetchadddescTitle removeAllObjects];}
    if(fetchadddescDetaiText){[fetchadddescDetaiText removeAllObjects];}
    if(fetchadddescCreatedDate){[fetchadddescCreatedDate removeAllObjects];}
    if(fetchadddescUpdateTime){[fetchadddescUpdateTime removeAllObjects];}
    if(fetchadddescNewsName){[fetchadddescNewsName removeAllObjects];}
    if(fetchadddesCityName){[fetchadddesCityName removeAllObjects];}
    
    
    NSString *sqlString1 = [NSString stringWithFormat:@"SELECT * FROM TempStoreDescSearch"];
    
    NSLog(@"sqlString1--%@",sqlString1);
    
    const char *sql = [sqlString1 UTF8String];
    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(countstatement) == SQLITE_ROW){
            NSString * addID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,10)];
            NSString * AddTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,4)];
            NSString * addTitleDsc = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,5)];
            NSString * AddCreatedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,8)];
            NSString * addNewsName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,7)];
            NSString * addNewsCity = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,6)];
            NSString * Newsupdatetime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,9)];
            
            [fetchadddescID addObject:addID];
            [fetchadddescTitle addObject:AddTitle];
            [fetchadddescDetaiText addObject:addTitleDsc];
            [fetchadddescCreatedDate addObject:AddCreatedDate];
            [fetchadddescUpdateTime addObject:Newsupdatetime];
            [fetchadddescNewsName addObject:addNewsName];
            [fetchadddesCityName addObject:addNewsCity];
        }
        
        sqlite3_finalize(countstatement);
    }
    
    if([fetchadddescID count]>0){
        searchbar_Txt.text=@"";
        [noresult_lbl setHidden:YES];
        [tableview reloadData];
    }
    else{
        searchbar_Txt.text=@"";
        [tableview reloadData];
        tempindbg.hidden=TRUE;
        [spinner stopAnimating];
        [noresult_lbl setHidden:NO];
    }
}



-(void)viewWillAppear:(BOOL)animated{
    // force the tableview to load
    searchbar_Txt.text=@"";
    [searchbar_Txt resignFirstResponder];
    // [tableview reloadData];
}


//Key board search btn Action
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchbtnAction];
    return YES;
}


-(void)back_btnAction
{
    //[self Delete_TempStoreDescSearch_CityList_Table_DB];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)share_btnAction:(UIButton *)sender{
    NSInteger tag = sender.tag;
   
    
//    CNFAShareAppViewController *gotoshare_Cls=[[CNFAShareAppViewController alloc]init];
//    [gotoshare_Cls setEMailSubjectstr:[fetchadddescTitle objectAtIndex:tag]];
//    [gotoshare_Cls setEMaildetailmsgstr:[fetchadddescDetaiText objectAtIndex:tag]];
//    [gotoshare_Cls setEMailaddNewsstr:[fetchadddescNewsName objectAtIndex:tag]];
//    [gotoshare_Cls setEMailaddCitystr:[fetchadddesCityName objectAtIndex:tag]];
//    [gotoshare_Cls setEMailaddTimestr:[fetchadddescCreatedDate objectAtIndex:tag]];
//    [self.navigationController pushViewController:gotoshare_Cls animated:YES];
//    [gotoshare_Cls release];
    
    [transview setHidden:NO];
    

    self.eMailSubjectstr=[NSString stringWithFormat:@"%@",[fetchadddescTitle objectAtIndex:tag]];
    
    self.eMaildetailmsgstr=[NSString stringWithFormat:@"%@",[fetchadddescDetaiText objectAtIndex:tag]];
    self.eMailaddNewsstr=[NSString stringWithFormat:@"%@",[fetchadddescNewsName objectAtIndex:tag]];
    self.eMailaddCitystr=[NSString stringWithFormat:@"%@",[fetchadddesCityName objectAtIndex:tag]];
    self.eMailaddTimestr=[NSString stringWithFormat:@"%@",[fetchadddescCreatedDate objectAtIndex:tag]];
    
    if (shareClicked==0) {
        shareClicked=1;
        [UIView animateWithDuration:0.60f animations:^{
            
            CGRect uiasViewFrame   = self.uiasView.frame;
            uiasViewFrame.origin.y = (self.view.frame.size.height - 230);
            
            self.uiasView.frame = uiasViewFrame;
        }];
    } else {
        shareClicked=0;
        [UIView animateWithDuration:0.75f animations:^{
            
            CGRect uiasViewFrame   = self.uiasView.frame;
            uiasViewFrame.origin.y = (self.view.frame.size.height + 230);
            
            self.uiasView.frame = uiasViewFrame;
        }];
        
        //self.presentASButton.enabled = YES;
    }


    

 }
-(void)dismiss_btn:(id)sender
{
     [transview setHidden:YES];
    shareClicked=0;
    [UIView animateWithDuration:0.75f animations:^{
        
        CGRect uiasViewFrame   = self.uiasView.frame;
        uiasViewFrame.origin.y = (self.view.frame.size.height + 230);
        
        self.uiasView.frame = uiasViewFrame;
    }];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}

- (void) onResp:(BaseResp*)resp {
    if([resp isKindOfClass:[SendMessageToWXResp class]]) {
        NSString *strMsg = [NSString stringWithFormat:@"Result:%d", resp.errCode];
        NSLog(@"Response from Weixin was: %@",strMsg);
    }
}

- (void) onReq:(BaseReq*)req {
}



-(void)TencentWeibo:(id)sender{
    
    if(self.wbapi == nil)
    {
        self.wbapi = [[WeiboApi alloc]initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUri:REDIRECTURI] ;
        
        CNFAAppDelegate *dele=(CNFAAppDelegate*)[UIApplication sharedApplication].delegate;
        [dele setFromPage:@"Category"];
        dele.viewController1=self;
        
    }
    //first reflash the Auth,if Success Send Msg,Or Login
    [self.wbapi refreshAuthWithDelegate:self];
    
    
    
}
//By Ye
//Reflash Auth Failed,Start Login
- (void)DidAuthRefreshFail:(NSError *)error
{
    [self.wbapi loginWithDelegate:self andRootController:self];
    
}
//By Ye
//Reflash Auth Success ,Send WeiBo Msg
-(void)DidAuthRefreshed:(WeiboApi *)wbapi
{
    [self SendWeiBo];//Send Msg
}
//By Ye
//Login Success Continue,Send Msg
- (void)DidAuthFinished:(WeiboApi *)wbapi_
{
    [self SendWeiBo];//Send Msg
}
//By Ye
//If Click Cancel Button When at the Auth Page
-(void)DidAuthCanceled:(WeiboApi *)wbapi
{
    
}
//By Ye
//Auth Failed,Show Failure Msg
- (void)DidAuthFailWithError:(NSError *)error
{
    // NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    
    [self createFail:error];
    //[str release];
}
//By Ye
//After Sending Msg Successfully,We get the Callback,so Show Alert to tell user msg had sent
- (void)didReceiveRawData:(NSData *)data reqNo:(int)reqno
{
    
    
    [self showAlertMessage:@"分享成功"];
    
    
}
//By Ye
//Send Failed Log the Failed
- (void)didFailWithError:(NSError *)error reqNo:(int)reqno
{
    NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    
    NSLog(@"%@",str);
    [str release];
}

//By Ye
//Init Send Msg,and Init WBMsgViewController，this is uesd to show what we want to send.User can alse modify the text before send
-(void)SendWeiBo
{
    
   
    NSString* nsText;
    nsText =[NSString stringWithFormat:@"@凡人凡事 http://www.hzfanwen.com/products_ad.html | %@ | %@ \n\n%@ ",self.eMailaddNewsstr,self.eMailaddCitystr,self.eMaildetailmsgstr ];
    
    if (wbMsg==nil) {
        wbMsg=[[WBMsgViewController alloc]init];
        wbMsg.delegate=self;
    }
    
    
    [self presentViewController:wbMsg animated:YES completion:^{
        wbMsg.txtMsg.text=nsText;
    }];
    //[wbMsg release];//it cause crash on IOS6,I Confused
    
    
    
}
//By Ye
//the WBMsgViewController's call back when disappear the view, we discuess to send the message or not
-(void)WBMsgViewControllerFinishWith:(WBMsgViewController *)wbView Result:(BOOL)send
{
    if (send) {
        
        
        UIImage *pic = [UIImage imageNamed:@"icon.png"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"json",@"format",
                                       wbView.txtMsg.text, @"content",
                                       pic, @"pic",
                                       nil];
        [self.wbapi requestWithParams:params apiName:@"t/add_pic" httpMethod:@"POST" delegate:self];
        
        [params release];
    }
}

- (void)onSuccessLogin
{
    
}

//Login failed callback
- (void)onFailureLogin:(NSError *)error
{
    
//    NSString *message1 = [[NSString alloc] initWithFormat:@"%@",[NSNumber numberWithInteger:[error code]]];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error domain]
//                                                        message:message1
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//    [alertView show];
//    [alertView release];
//    [message1 release];
}


-(void)SinaWeibo:(id)sender{
    //working with english content
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo])
    {
        SLComposeViewController *swSheet = [SLComposeViewController
                                            composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        
        if ([self.eMaildetailmsgstr length] >= 110)
        {
            self.eMaildetailmsgstr = [ self.eMaildetailmsgstr substringToIndex:110];
        }
        else
        {
            self.eMaildetailmsgstr = [ self.eMaildetailmsgstr substringToIndex:[ self.eMaildetailmsgstr length]];
        }
        
        [swSheet setInitialText:[NSString stringWithFormat:@"@凡人凡事 | http://www.hzfanwen.com/products_ad.html | %@ | %@ \n\n %@ ",self.eMailaddNewsstr,self.eMailaddCitystr,self.eMaildetailmsgstr ]];
        
       
        [self presentViewController:swSheet animated:YES completion:nil];
    }
    else
    {
        //Error alert
    }  //    ACAccountStore *accountStore1 = [[ACAccountStore alloc] init];
    
}









#pragma We Chat
- (void)sendTextContent_WeChat{
    NSString* nsText;
    nsText =[NSString stringWithFormat:@"@凡人凡事 | http://www.hzfanwen.com/products_ad.html | %@ | %@  \n\n%@ ",self.eMailaddNewsstr,self.eMailaddCitystr,self.eMaildetailmsgstr ];
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = YES;
    req.text = nsText;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}




#pragma Message Button Action
-(IBAction)message_btn:(id)sender{
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    if([MFMessageComposeViewController canSendText]){
        controller.body = [NSString stringWithFormat:@"@凡人凡事 | http://www.hzfanwen.com/products_ad.html | %@ | %@ \n\n %@ ",self.eMailaddNewsstr,self.eMailaddCitystr, self.eMaildetailmsgstr];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
}


#pragma Message Composer Delegate Metthod
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
            alert=[[UIAlertView alloc]initWithTitle:@"Myapp" message:@"message" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [alert release];
		case MessageComposeResultSent:
            
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}



#pragma mark - Open the mail interface
- (IBAction)openMail:(id)sender
{
    if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:[NSString stringWithFormat:@"%@ (凡人凡事 - 报纸分类广告)",eMailSubjectstr]];
        //   NSArray *toRecipients = [NSArray arrayWithObjects:@"reddanna.k@search-value.com", nil];
        //   [mailer setToRecipients:toRecipients];
        //        UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
        //        NSData *imageData = UIImagePNGRepresentation(myImage);
        //        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        
        NSString *emailBody =[NSString stringWithFormat:@"@凡人凡事 http://www.hzfanwen.com/products_ad.html | %@ | %@ \n\n %@ ",self.eMailaddNewsstr,self.eMailaddCitystr, self.eMaildetailmsgstr];
        [mailer setMessageBody:emailBody isHTML:NO];
        
        // only for iPad
        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentModalViewController:mailer animated:YES];
        [mailer release];
    }
    else{
        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                         message:@"Your device doesn't support the composer sheet"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
        [alert1 show];
        [alert1 release];
    }
    
}

#pragma mark - MFMailComposeController delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//       // [sle setStatusBarStyle:UIStatusBarStyleLightContent];
//        [(CNFAAppDelegate *)[[UIApplication sharedApplication] delegate] window].clipsToBounds =YES;
//        [(CNFAAppDelegate *)[[UIApplication sharedApplication] delegate] window].frame =  CGRectMake(0,20,[(CNFAAppDelegate *)[[UIApplication sharedApplication] delegate] window].frame.size.width,[(CNFAAppDelegate *)[[UIApplication sharedApplication] delegate] window].frame.size.height-20);
//        
//        //Added on 19th Sep 2013
//        [(CNFAAppDelegate *)[[UIApplication sharedApplication] delegate] window].bounds = CGRectMake(0, 0, [(CNFAAppDelegate *)[[UIApplication sharedApplication] delegate] window].frame.size.width, [(CNFAAppDelegate *)[[UIApplication sharedApplication] delegate] window].frame.size.height);
//    }
    [self dismissModalViewControllerAnimated:YES];
}


- (void)onSuccessAuthorizeLogin
{
    // [indicatorView stopAnimating];
    //[self onLogInOAuthButtonPressed];
}

- (void)postStart {
    NSLog(@"%s", __FUNCTION__);
    //    [self showAlertMessage:@"开始发送"];
}

- (void)createSuccess:(NSDictionary *)dict {
    NSLog(@"%s %@", __FUNCTION__,dict);
    
    if (dict !=NULL) {
        if ([[dict objectForKey:@"ret"] intValue] == 0) {
            [self showAlertMessage:@"Message sent"];
        }else {
            [self showAlertMessage:@"Message not sent"];
        }
    }
    
}

- (void)createFail:(NSError *)error {
    NSLog(@"error is %@",error);
    
    //[self showAlertMessage:@"Message not sent"];
}

- (void)showAlertMessage:(NSString *)msg {
    
    
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:msg
                                                      delegate:self
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
}


//-(void)onLoginFailed:(WBErrCode)errCode msg:(NSString*)msg;
//{
//    
//    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Login failed" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
//    [av show];
//}
//
//-(void)onLoginSuccessed:(NSString*)name token:(WBToken*)token;
//{
//    NSString* msg = [NSString stringWithFormat:@"name=%@\n openid=%@\n token=%@\n expire=%u\n refreshToken=%@ \n omasToken=%@ omasKey = %@\n",name,token.openid,token.accessToken,token.expires,token.refreshToken, token.omasKey, token.omasToken];
//    
//    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Login successful" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
//    [av show];
//}
//- (void)onLogin {
//    
//}
//- (void)onLogInOAuthButtonPressed
//{
//    UIImage * image  = [UIImage imageNamed:@"icon.png"];
//    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"];
//    //    UIImage *image = [UIImage imageNamed:path];
//    // 分享(自带 m登录功能)
//    NSString* nsText;
//    nsText =[NSString stringWithFormat:@"%@\n\n%@\n\n%@ | %@ | %@\n@凡人凡事 http://www.hzfanwen.com/products_ad.html",eMailSubjectstr,eMaildetailmsgstr,eMailaddNewsstr,eMailaddCitystr,eMailaddTimestr ];
//    
//    [self.weiboEngine UIBroadCastMsgWithContent:nsText
//                                       andImage:image
//                                    parReserved:nil
//                                       delegate:self
//                                    onPostStart:@selector(postStart)
//                                  onPostSuccess:@selector(createSuccess:)
//                                  onPostFailure:@selector(createFail:)];
//    
//}
@end
