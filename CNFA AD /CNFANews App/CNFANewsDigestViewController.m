//
//  CNFANewsDigestViewController.m
//  CNFANews App
//
//  Created by Dex on 21/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//
BOOL navbackbool;
#import "CNFANewsDigestViewController.h"
#import "CNFAContactUsViewController.h"
#import "CNFAAppDelegate.h"
#import "CNFACategoryNewsViewController.h"
#define IS_IPHONE ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface CNFANewsDigestViewController ()

@end

@implementation CNFANewsDigestViewController
@synthesize tabbarcontroller,tabbar,keystr,ClassType,NewsID,CityID,dropdownmsg,finalNewsID,CityName,fromTab;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // self.title = NSLocalizedString(@"Category", @"Category");
      //  self.tabBarItem.image = [UIImage imageNamed:@"147.png"];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Dheeraj %@",CityID);
  
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
    //Make Database connection
    database = [DBConnectionManager getDatabaseObject];
    
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    remoteHostStatus = [reachability currentReachabilityStatus];

    Newscategory_id=[[NSMutableArray alloc] init];
    Newscategory_name=[[NSMutableArray alloc] init];
    Newsupdate_time=[[NSMutableArray alloc] init];
    Newslogo_URL=[[NSMutableArray alloc] init];
    Newsimage_Name=[[NSMutableArray alloc] init];
    NewsNewsID=[[NSMutableArray alloc] init];
    NewsCatUpdateTime=[[NSMutableArray alloc] init];
    NewscityId=[[NSMutableArray alloc] init];
    NewscityName=[[NSMutableArray alloc] init];
    NewscityTimeStamp=[[NSMutableArray alloc] init];
    NewsCatNumArt=[[NSMutableArray alloc] init];
    
    fetNewscategory_id=[[NSMutableArray alloc] init];
    fetNewscategory_name=[[NSMutableArray alloc] init];
    fetNewsupdate_time=[[NSMutableArray alloc] init];
    fetNewslogo_URL=[[NSMutableArray alloc] init];
    fetNewsimage_Name=[[NSMutableArray alloc] init];
    fetNewsNewsID=[[NSMutableArray alloc] init];
    fetNewsnewspaper_name=[[NSMutableArray alloc] init];
    fetNewsnewspaperupdate_time=[[NSMutableArray alloc] init];
    fetNewscityId=[[NSMutableArray alloc] init];
    fetNewscityName=[[NSMutableArray alloc] init];
    fetNewscityTimeStamp=[[NSMutableArray alloc] init];
    
    
    
    
//   Citycategory_id=[[NSMutableArray alloc] init];
//   Citycategory_name=[[NSMutableArray alloc] init];
//   Cityupdate_time=[[NSMutableArray alloc] init];
//   Citylogo_URL=[[NSMutableArray alloc] init];
//   Cityimage_Name=[[NSMutableArray alloc] init];
//   CityNewsID=[[NSMutableArray alloc] init];
//   Citynewspaper_name=[[NSMutableArray alloc] init];
//   Citynewspaperupdate_time=[[NSMutableArray alloc] init];
//    
//    
//    
//   fetCitycategory_id=[[NSMutableArray alloc] init];
//   fetCitycategory_name=[[NSMutableArray alloc] init];
//   fetCityupdate_time=[[NSMutableArray alloc] init];
//   fetCitylogo_URL=[[NSMutableArray alloc] init];
//   fetCityimage_Name=[[NSMutableArray alloc] init];
//   fetCityNewsID=[[NSMutableArray alloc] init];
//   fetCitynewspaper_name=[[NSMutableArray alloc] init];
//   fetCitynewspaperupdate_time=[[NSMutableArray alloc] init];
//
    
    
    
    
#pragma Main BackGround ImageView
    mainbg_img = [[UIImageView alloc] init];
  
 if(IS_IPHONE){ mainbg_img.frame=CGRectMake(0,0, 320,520);}
   else{
        mainbg_img.frame=CGRectMake(0,0, 320,480);}
    [mainbg_img setImage:[UIImage imageNamed:@"Main-bg.png"]];
    mainbg_img.userInteractionEnabled=TRUE;
    mainbg_img.opaque = YES;
    [self.view addSubview:mainbg_img];
    [mainbg_img release];
     
#pragma Navigation Bar imageView
    navbarimage = [[UIImageView alloc] init];
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
//   UILabel *navbartitle=[[UILabel alloc] init];
//    navbartitle.frame=CGRectMake(0,2.5,320,34);
//    //navbartitle.text=[NSString stringWithFormat:@"China News Digest"];
//    navbartitle.text=[NSString stringWithFormat:@"凡事"];
//    navbartitle.textAlignment=1;
//    navbartitle.textColor= [UIColor whiteColor];
//    navbartitle.backgroundColor=[UIColor clearColor];
//    navbartitle.font=[UIFont fontWithName:@"ZhunYuan" size:18];
//    navbartitle.shadowColor = [UIColor grayColor];
//    navbartitle.shadowOffset = CGSizeMake(0,0);
//    [navbarimage addSubview:navbartitle];
//    [navbartitle release];
   

    
    searchback_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    searchback_btn.frame=CGRectMake(5,9,49.5,29);
    
   
    [searchback_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-button" ofType:@"png"]] forState:UIControlStateNormal];
//    searchback_btn.titleLabel.font=[UIFont systemFontOfSize:15.0f];
//    [searchback_btn setTitle:@"返回" forState:UIControlStateNormal];
//    [searchback_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchback_btn.hidden=TRUE;
    [searchback_btn addTarget:self action:@selector(FetchRecord_NewsTitle_DB) forControlEvents:UIControlEventTouchUpInside];
    [navbarimage addSubview:searchback_btn];
    

    
    
    
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
    searchbar_Txt.font = [UIFont fontWithName:@"ZhunYuan" size:13.0f];
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
    searchbar_Txt1.font = [UIFont fontWithName:@"ZhunYuan" size:13.0f];
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
    city_lbl.frame=CGRectMake(25,0,210,20);
    //city_lbl.text=[NSString stringWithFormat:@"News: %@",dropdownmsg];
    if ([fromTab isEqualToString:@"Newspaper"]) {
        city_lbl.text=[NSString stringWithFormat:@"%@",dropdownmsg];
    } else  if ([fromTab isEqualToString:@"City"]){
        city_lbl.text=[NSString stringWithFormat:@"%@>>%@",CityName,dropdownmsg];
    }
    
    city_lbl.textAlignment=0;
    city_lbl.textColor= [UIColor whiteColor];
    city_lbl.backgroundColor=[UIColor clearColor];
    city_lbl.font=[UIFont fontWithName:@"ZhunYuan" size:13.0f];
    [category_img addSubview:city_lbl];
    [city_lbl release];
    
    
    
#pragma Buttom Bar ImageView
//    UIImageView *midbg_img = [[UIImageView alloc] init];
//    midbg_img.frame=CGRectMake(16,125.5,290,270);
//    [midbg_img setImage:[UIImage imageNamed:@"bg-midd.png"]];
//    midbg_img.userInteractionEnabled=TRUE;
//    midbg_img.opaque = YES;
//    midbg_img.layer.masksToBounds = YES;
//    midbg_img.layer.cornerRadius = 10;
//    [mainbg_img addSubview:midbg_img];
//    [midbg_img release];
    UIImageView *midbg_img = [[UIImageView alloc] init];
    
    if(IS_IPHONE)
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            midbg_img.frame=CGRectMake(10,125.5+20,300,388);
        } else {
            midbg_img.frame=CGRectMake(10,125.5,300,388);
        }
        
    }
    else
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            midbg_img.frame=CGRectMake(10,125+20,300,300);
        } else {
            midbg_img.frame=CGRectMake(10,125,300,300);
        }
        
    }
    
    [midbg_img setImage:[UIImage imageNamed:@"contact-bg.png"]];
    midbg_img.userInteractionEnabled=TRUE;
    midbg_img.opaque = YES;
    [mainbg_img addSubview:midbg_img];
    [midbg_img release];

    
    
    
#pragma ScrollView
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame=CGRectMake(0, 0, 300, 345);
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(300, 200);
    scrollView.showsHorizontalScrollIndicator = NO;
    [scrollView setCanCancelContentTouches:NO];
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    scrollView.clipsToBounds = YES;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled=YES;
    scrollView.layer.cornerRadius=5.0f;
    scrollView.delegate=self;
    scrollView.tag=1;
    [midbg_img addSubview:scrollView];
    [scrollView release];
    
    
    scrollDesableview=[[UIView alloc]init];
    scrollDesableview.frame=CGRectMake(0, 0, 292, 275);
    scrollDesableview.hidden=TRUE;
    scrollDesableview.backgroundColor=[UIColor clearColor];
    [midbg_img addSubview:scrollDesableview];
    
    
#pragma PageControl
    pageControl=[[UIPageControl alloc]init];
    if(IS_IPHONE){
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
             pageControl.frame=CGRectMake(15, 475+20, 290, 14);
        } else {
             pageControl.frame=CGRectMake(15, 475, 290, 14);
        }
   
    }else
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
             pageControl.frame=CGRectMake(15, 396+20, 290, 14);
        } else {
             pageControl.frame=CGRectMake(15, 396, 290, 14);
        }
    }
   
    pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    pageControl.tag=12;
    pageControl.backgroundColor=[UIColor clearColor];
    [mainbg_img addSubview:pageControl];
    [pageControl release];
       
    
   // [self createCategoryButtons];
    pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:68/255.0f green:192/255.0f blue:181/255.0f alpha:1];
    pageControl.numberOfPages = 1;
    
    
    
    
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
    
   //Sql query selected Timestamp
    if(remoteHostStatus == NotReachable) {
        UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"提醒!"
                                                                 message:@"当前没有可用网络，请检查后再试."
                                                                delegate:nil
                                                       cancelButtonTitle:@"确认"
                                                       otherButtonTitles:nil];
        [networkmessage show];
        [networkmessage release];
        
       [self FetchRecord_NewsTitle_DB];
        
    }
    else{
    [self fetch_previousTimeStamp_FromDB_For_selectAnyNewsPaper];
    }
  // Do any additional setup after loading the view.
}



//Key board search btn Action
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchbtnAction];
    return YES;
}

-(void)fetch_previousTimeStamp_FromDB_For_selectAnyNewsPaper{
   sqlite3_stmt * countstatement;
    if(fetNewscityTimeStamp){
    [fetNewscityTimeStamp removeAllObjects];}
//    if(fetCitynewspaperupdate_time){
//        [fetCitynewspaperupdate_time removeAllObjects];}
     if([ClassType isEqualToString:@"NewsClass"]){
   
            NSString *sqlString1 = [NSString stringWithFormat:@"select CatUpdateTime from New_AllCatList Where News_ID=%@",NewsID];
            const char *sql = [sqlString1 UTF8String];
            if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
                while(sqlite3_step(countstatement) == SQLITE_ROW){
                    NSString * CatUpdateTimeStamp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,0)];
                    [fetNewscityTimeStamp addObject:CatUpdateTimeStamp];
                }
                sqlite3_finalize(countstatement);
            }
      }
      
      tempindbg.hidden=FALSE;
      [spinner startAnimating];
      
      //When selecting News
      
      CNFAGetCityListandCat * gcl = [[CNFAGetCityListandCat alloc] init];
      gcl.delegate = self;
      [gcl callWebService:NewsID];

  }



//Service when click any newsTitle previously page
-(void)getCatCityTitleList:(NSMutableArray *)CatID  getcatTitle:(NSMutableArray *)CatTitle getcatImageName:(NSMutableArray *)catimageName  getcatImageUrl:(NSMutableArray *)Catimageurl getCatUpdateTimeStamp:(NSMutableArray *)catTimeStamp  getcatNumberArt:(NSMutableArray *)CatNumberArt  status:(BOOL)value{
   if(Newscategory_id){[Newscategory_id removeAllObjects];}
   if(Newscategory_name){[Newscategory_name removeAllObjects];}
   if(Newslogo_URL){[Newslogo_URL removeAllObjects];}
   if(Newsimage_Name){[Newsimage_Name removeAllObjects];}
   if(NewsNewsID){[NewsNewsID removeAllObjects];}
   if(NewsCatUpdateTime){[NewsCatUpdateTime removeAllObjects];}
  if(NewsCatNumArt){[NewsCatNumArt removeAllObjects];}
    
    if(NewscityId){[NewscityId removeAllObjects];}
   if(NewscityName){[NewscityName removeAllObjects];}
   if(NewscityTimeStamp){[NewscityTimeStamp removeAllObjects];}

    
    NewsCatNumArt=[CatNumberArt copy];
    Newscategory_id=[CatID mutableCopy];
    Newscategory_name=[CatTitle mutableCopy];
    Newslogo_URL=[Catimageurl mutableCopy];
    Newsimage_Name=[catimageName mutableCopy];
    // NewsNewsID=[newsId mutableCopy];
    NewsCatUpdateTime=[catTimeStamp mutableCopy];
   // NewscityId=[cityId mutableCopy];
  //  NewscityName=[cityName mutableCopy];
   // NewscityTimeStamp=[cityTimeStamp mutableCopy];
 
    if([fetNewscityTimeStamp isEqualToArray:NewsCatUpdateTime]){
         NSLog(@"Match array");
         [self FetchRecord_NewsTitle_DB];
    }
    else{
        NSLog(@"Did Not match array");
       [self SaveImageToDocumentDirectory];
     }
  }




#pragma Method to save downloaded image in to Document Directory
-(void)SaveImageToDocumentDirectory{
    for (int i=0; i<[Newslogo_URL count]; i++) {
        NSURL *imageurl = [NSURL URLWithString:[Newslogo_URL objectAtIndex:i]];
        NSData *  imagedata = [[[NSData alloc]initWithContentsOfURL:imageurl] autorelease];
        image = [UIImage imageWithData: imagedata];
        NSData *  imagedata1 = UIImagePNGRepresentation(image);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[Newsimage_Name objectAtIndex:i]]];
        NSLog(@"imagesavedpath==%@",fullPath);
        [fileManager createFileAtPath:fullPath contents:imagedata1 attributes:nil];
      //  [self createCategoryButtons];
    }
    
     [self Delete_NewsTitle_Table_DB];
    
}
-(void)Delete_NewsTitle_Table_DB{
 NSString *insertSQL;
    insertSQL = [NSString stringWithFormat: @"DELETE FROM New_AllCatList WHERE News_ID=%@",NewsID];
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
    sqlite3_step(InsertStatement);
    sqlite3_finalize(InsertStatement);
    [self InsertRecord_ToNewsTitle_DB];
}



-(void)InsertRecord_ToNewsTitle_DB{
    NSString *insertSQL;
  
     for(int i=0; i<[Newscategory_id count];i++){
        insertSQL = [NSString stringWithFormat: @"INSERT INTO New_AllCatList (CatID,CatName,CatImageName,CatUpdateTime,News_ID) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",[Newscategory_id objectAtIndex:i],[Newscategory_name objectAtIndex:i],[Newsimage_Name objectAtIndex:i],[NewsCatUpdateTime objectAtIndex:i],NewsID];
        
        NSLog(@"insertSQL-- %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
        sqlite3_step(InsertStatement);
    }
         sqlite3_finalize(InsertStatement);
         
    [self FetchRecord_NewsTitle_DB];
  }

-(void)FetchRecord_NewsTitle_DB{
    [searchbar_Txt resignFirstResponder];
    searchbar_Txt.text=@"";
    searchback_btn.hidden=TRUE;
    back_btn.hidden=FALSE;
    sqlite3_stmt * countstatement;
    
    if(fetNewscategory_id){[fetNewscategory_id removeAllObjects];}
    if(fetNewscategory_name){[fetNewscategory_name removeAllObjects];}
    if(fetNewslogo_URL){[fetNewslogo_URL removeAllObjects];}
    if(fetNewsimage_Name){[fetNewsimage_Name removeAllObjects];}
    if(fetNewsNewsID){[fetNewsNewsID removeAllObjects];}
    if(fetNewsupdate_time){[fetNewsupdate_time removeAllObjects];}

  NSString *sqlString1 = [NSString stringWithFormat:@"SELECT CatID,CatName,CatImageName,CatUpdateTime,News_ID from New_AllCatList Where News_ID=%@",NewsID];
    
    const char *sql = [sqlString1 UTF8String];
    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(countstatement) == SQLITE_ROW){
             NSString * Cat_ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,0)];
             NSString * Cat_Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,1)];
             NSString * Image_Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,2)];
             NSString * CatUpdate_Time = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,3)];
             NSString * NewsPaper_ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,4)];
               
            [fetNewscategory_id addObject:Cat_ID];
            [fetNewscategory_name addObject:Cat_Name];
            [fetNewsimage_Name addObject:Image_Name];
            [fetNewsNewsID addObject:NewsPaper_ID];
            
            [fetNewsupdate_time addObject:CatUpdate_Time];
         }
        
        sqlite3_finalize(countstatement);
    }

     [self createCategoryButtons];

 }







//-(void)searchCatListfromDB{
//    sqlite3_stmt * countstatement;
//    
//    if([searchbar_Txt.text length]>0){
//    
//    if(fetNewscategory_id){[fetNewscategory_id removeAllObjects];}
//    if(fetNewscategory_name){[fetNewscategory_name removeAllObjects];}
//    if(fetNewslogo_URL){[fetNewslogo_URL removeAllObjects];}
//    if(fetNewsimage_Name){[fetNewsimage_Name removeAllObjects];}
//    if(fetNewsNewsID){[fetNewsNewsID removeAllObjects];}
//    if(fetNewsupdate_time){[fetNewsupdate_time removeAllObjects];}
//   // SELECT * FROM tablea WHERE "roger" LIKE '%field2%'
//    NSString *sqlString1 = [NSString stringWithFormat:@"SELECT CatID,CatName,CatImageName,CatUpdateTime,News_ID from New_AllCatList Where CatName LIKE '%%%@%%' AND News_ID=%@",searchbar_Txt.text,NewsID];
//    
//    NSLog(@"query %@",sqlString1);
//    const char *sql = [sqlString1 UTF8String];
//    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
//        while(sqlite3_step(countstatement) == SQLITE_ROW){
//            NSString * Cat_ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,0)];
//            NSString * Cat_Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,1)];
//            NSString * Image_Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,2)];
//            NSString * CatUpdate_Time = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,3)];
//            NSString * NewsPaper_ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,4)];
//            
//            [fetNewscategory_id addObject:Cat_ID];
//            [fetNewscategory_name addObject:Cat_Name];
//            [fetNewsimage_Name addObject:Image_Name];
//            [fetNewsNewsID addObject:NewsPaper_ID];
//            [fetNewsupdate_time addObject:CatUpdate_Time];
//        }
//        
//        sqlite3_finalize(countstatement);
//    }
//
//     if([fetNewscategory_id count]>0){
//          searchback_btn.hidden=FALSE;
//          back_btn.hidden=TRUE;
//          [self createCategoryButtons];
//     }
//    else{
//        [searchbar_Txt resignFirstResponder];
//        UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"Alert: Message"
//                                                                 message:@"The search key was not found in any record "
//                                                                delegate:nil
//                                                       cancelButtonTitle:@"OK"
//                                                       otherButtonTitles:nil];
//        [networkmessage show];
//        [networkmessage release];
//        
//        
//        
//    }
// }
//    
//}
//
//









//For Pagging Thumb
- (void) createCategoryButtons {
   
        
    NSLog(@"createCategoryButtons");
	for (int xxx = 111; xxx<111+12; xxx++) {
		UIButton * myButton = (UIButton *)([self.view viewWithTag:xxx]);
		[myButton removeFromSuperview];
		myButton = nil;
       
	}
   for (UIImageView * tempview in [scrollView subviews]) {
         [tempview removeFromSuperview];
    }

    if ([fetNewscategory_id count] %9 > 0 ) {
       pageControl.numberOfPages=( [fetNewscategory_id count]/9)+1;
        
    }
    else if ([fetNewscategory_id count] %9 == 0)
    {
         pageControl.numberOfPages=( [fetNewscategory_id count]/9);
        
    }
     scrollView.contentSize = CGSizeMake(300*pageControl.numberOfPages, 200);
    
    
    
    for (int j=0; j<pageControl.numberOfPages; j++) {
        int row1 = 0;
        int pageNo1 = j;
        for (int i = 0; i<9; i++) {
            if (i != 0) {
                if (i%3 == 0) {
                    row1++;
                }
              
               
            }
            
            UIImageView *imageView = [[UIImageView alloc] init];
            if (IS_IPHONE) {
                imageView.frame=CGRectMake(300*pageNo1+(100*(i%3))-0, 0+(115*row1), 100,115);
            } else {
                imageView.frame=CGRectMake(300*pageNo1+(100*(i%3))-0, 0+(90*row1), 100,90);
            }
            
            imageView.backgroundColor=[UIColor clearColor];
            [imageView setImage:[UIImage imageNamed:@"category-box-bg.png"]];
            imageView.userInteractionEnabled=FALSE;
            imageView.opaque = YES;
            [scrollView addSubview:imageView];
            [imageView release];
            
        }

    }
    
    
    int row = 0;
    int pageNo = 0;
    for (int i = 0; i<[fetNewscategory_id count]; i++) {
        if (i != 0) {
            if (i%3 == 0) {
                row++;
            }
            if (i % 9 == 0) {
                pageNo++;
                row = 0;
            }
            // button.frame = CGRectMake(320*pageNo+(15+(100*(i%3))), 30+(100*row), 89, 73);
        }
        
        UIImageView *imageView = [[UIImageView alloc] init];
        if (IS_IPHONE) {
             imageView.frame=CGRectMake(300*pageNo+(100*(i%3))-0, 0+(115*row), 100,115);
        } else {
             imageView.frame=CGRectMake(300*pageNo+(100*(i%3))-0, 0+(90*row), 100,90);
        }
       
        imageView.backgroundColor=[UIColor clearColor];
       // [imageView setImage:[UIImage imageNamed:@"category-box-bg.png"]];
        imageView.userInteractionEnabled=TRUE;
        imageView.opaque = YES;
        [scrollView addSubview:imageView];
        [imageView release];
        
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
        NSString * documentsDirectory = [paths objectAtIndex:0];
        NSString *getImagePath=@"";
        
       getImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[fetNewsimage_Name objectAtIndex:i]]];
         
      //  [newsiconimg setImage:[UIImage imageWithContentsOfFile:getImagePath]];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (IS_IPHONE) {
             button.frame = CGRectMake(32,30, 38.5,34);
        } else {
             button.frame = CGRectMake(30,18, 38.5,34);
        }
       
        button.contentMode=UIViewContentModeScaleAspectFit;
        [button setBackgroundImage:[UIImage imageWithContentsOfFile:getImagePath] forState:UIControlStateNormal];
        button.tag = i+111;
        [button addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
        
        UILabel *numArticles=[[UILabel alloc] init];
        numArticles.frame=CGRectMake(76,3,20,20);
       
        
        numArticles.textAlignment=1;
        numArticles.textColor= [UIColor whiteColor];
        numArticles.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"circle.png"]];
        //numArticles.backgroundColor=[UIColor colorWithRed:75/255.0f green:98/255.0f blue:107/255.0f alpha:1];
        numArticles.font=[UIFont fontWithName:@"ZhunYuan" size:10];
//        numArticles.shadowColor = [UIColor grayColor];
//        numArticles.shadowOffset = CGSizeMake(0,0);
        if ([NewsCatNumArt count]!=0 && i<[NewsCatNumArt count]) {
            if ([[NewsCatNumArt objectAtIndex:i] integerValue] >99) {
                 numArticles.text=@"...";
            } else {
                 numArticles.text=[NSString stringWithFormat:@"%@",[NewsCatNumArt objectAtIndex:i]];
            }
           
            [imageView addSubview:numArticles];
        }
        
        [numArticles release];

#pragma Buttons Labels Title
        UILabel *btnname_lbl=[[UILabel alloc] init];
        if (IS_IPHONE) {
             btnname_lbl.frame=CGRectMake(0,91,100,15);
        } else {
             btnname_lbl.frame=CGRectMake(0,66,100,17);
        }
       
        
            btnname_lbl.text=[NSString stringWithFormat:@"%@",[fetNewscategory_name objectAtIndex:i]];
            btnname_lbl.textAlignment=UITextAlignmentCenter;
            btnname_lbl.textColor= [UIColor whiteColor];
            btnname_lbl.backgroundColor= [UIColor clearColor];
            btnname_lbl.font=[UIFont fontWithName:@"ZhunYuan" size:13.0f];
            btnname_lbl.shadowColor = [UIColor grayColor];
            btnname_lbl.shadowOffset = CGSizeMake(0,0);
            [imageView addSubview:btnname_lbl];
            [btnname_lbl release];

        
        
    }
    
    tempindbg.hidden=TRUE;
    [spinner stopAnimating];
    }





-(void)myAction:(UIButton *)sender{
    NSInteger tag = sender.tag;
    NSLog(@"Click %d",tag);
    
    
    NSLog(@"Please select City FirstfetNewscategory_id %@",fetNewscategory_id);
    NSLog(@"Please select City Selected_CityID %@",Selected_CityID);
    NSLog(@"Please select City NewsID %@",NewsID);
    NSLog(@"Please select City FirstfetNewscategory_id %@",fetNewsimage_Name);
    
    CNFACategoryNewsViewController * subcat=[[CNFACategoryNewsViewController alloc] init];
    [subcat setNews_catIDstr:[fetNewscategory_id objectAtIndex:tag-111]];
    [subcat setNews_cityIdstr:[fetNewscategory_id objectAtIndex:tag-111]];
    [subcat setNews_IDstr:NewsID];
    [subcat setCityIDstr:CityID];
    if ([fromTab isEqualToString:@"City"]) {
        
        [subcat setFromTab1:@"City"];
        [subcat setCityName:CityName];
    }
    else if ([fromTab isEqualToString:@"Newspaper"])
    {
        [subcat setFromTab1:@"Newspaper"];
    }
    
    [subcat setNewsID:finalNewsID];
    [subcat setNews_Namestr:dropdownmsg];
    NSLog(@"dropdownmsg:::::::------------>%@",subcat.news_Namestr);
    [subcat setNews_Catname:[fetNewscategory_name objectAtIndex:tag-111]];
    [self.navigationController pushViewController:subcat animated:YES];
    [subcat release];
    
    //
    //    if([Selected_City length]>0){
    //        CNFACategoryNewsViewController * subcat=[[CNFACategoryNewsViewController alloc] init];
    //      [subcat setNews_catIDstr:[fetNewscategory_id objectAtIndex:tag-111]];
    //      [subcat setNews_cityIdstr:Selected_CityID];
    //      [subcat setNews_IDstr:NewsID];
    //      [subcat setNews_CatImagenameStr:[fetNewsimage_Name objectAtIndex:tag-111]];
    //      [self.navigationController pushViewController:subcat animated:YES];
    //      [subcat release];
    //    }
    //    else{
    //        NSLog(@"Please select City First");
    //        if ([ClassType isEqualToString:@"CityClass"]) {
    //        UIAlertView *alerview=[[UIAlertView alloc]initWithTitle:@"Required" message:@"Please choose your News first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //        [alerview show];
    //        }
    //        else{
    //            UIAlertView *alerview=[[UIAlertView alloc]initWithTitle:@"Required" message:@"Please choose your City first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //            [alerview show];
    //
    //        
    //        }
    //    }
    
}


-(void)viewWillAppear:(BOOL)animated
{
    if([keystr isEqualToString:@"Back"]){
#pragma NaviGation Left(back button) bar Button
        back_btn =[UIButton buttonWithType:UIButtonTypeCustom];
        back_btn.frame=CGRectMake(5,9,49.5,29);
        [back_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-button" ofType:@"png"]] forState:UIControlStateNormal];
//        back_btn.titleLabel.font=[UIFont fontWithName:@"ZhunYuan" size:13.0f];
//        [back_btn setTitle:@"  返回" forState:UIControlStateNormal];
//        [back_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [back_btn addTarget:self action:@selector(back_btnAction) forControlEvents:UIControlEventTouchUpInside];
        [navbarimage addSubview:back_btn];

    }
        searchbar_Txt.text=@"";
        [searchbar_Txt resignFirstResponder];
  }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma HERE NSTimer Method Calling
- (void)scrollingTimer {
    UIScrollView *scrMain = (UIScrollView*) [self.view viewWithTag:1];
    UIPageControl *pgCtr = (UIPageControl*) [self.view viewWithTag:12];
    CGFloat contentOffset = scrMain.contentOffset.x;
    int nextPage = (int)(contentOffset/scrMain.frame.size.width) + 1 ;
    
    if( nextPage!=pgCtr.numberOfPages)  {
        [scrMain scrollRectToVisible:CGRectMake(nextPage*scrMain.frame.size.width, 0, scrMain.frame.size.width, scrMain.frame.size.height) animated:YES];
        pgCtr.currentPage=nextPage;
        
    } else {
        [scrMain scrollRectToVisible:CGRectMake(0, 0, scrMain.frame.size.width, scrMain.frame.size.height) animated:YES];
        pgCtr.currentPage=0;
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate stuff
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if (pageControlIsChangingPage) {
        return;
    }
    
    CGFloat pageWidth = _scrollView.frame.size.width;
    
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    pageControl.currentPage = page;
}

-(void)back_btnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


//Nav bar search btn action
-(void)searchbtnAction{
    NSLog(@"Category class Click");
    [searchbar_Txt resignFirstResponder];
    if([searchbar_Txt.text length]>0){
        
        
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
            tempindbg.hidden=TRUE;
            [spinner stopAnimating];
            
            
            CNFACategoryNewsViewController * gotosearch=[[CNFACategoryNewsViewController alloc] init];
            [gotosearch setIsallsearch:@"searchBynewsID"];
            [gotosearch setNewsID:NewsID];
            [gotosearch setFromTab1:@"CategorySearch"];
            [gotosearch setSearchtextvalstr:searchbar_Txt.text];
            [self.navigationController pushViewController:gotosearch animated:YES];
            [gotosearch release];
        }
    }
}






- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   // [self hideCityList_table];

}





@end
