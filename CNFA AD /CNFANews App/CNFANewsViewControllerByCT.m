//
//  CNFANewsViewControllerByCT.m
//  CNFANews App
//
//  Created by iMac Apple on 20/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//
BOOL navbackbool;

#import "CNFANewsDigestViewController.h"
#import "CNFACategoryByCityCell.h"
#define REFRESH_HEADER_HEIGHT 52.0f

#import "CNFANewsViewControllerByCT.h"

#define IS_IPHONE ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface CNFANewsViewControllerByCT ()

@end

@implementation CNFANewsViewControllerByCT
@synthesize textPull, textRelease, textLoading, refreshHeaderView, refreshLabel, refreshArrow, refreshSpinner,tableview,todaydate,cityId,cityName;

//- (id)initWithStyle:(UITableViewStyle)style {
//    self = [super initWithStyle:style];
//    if (self != nil) {
//        [self setupStrings];
//    }
//    return self;
//}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
  //      [self setupStrings];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"News Paper", @"News Paper");
        self.tabBarItem.image = [UIImage imageNamed:@"147.png"];
      //  [self setupStrings];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"CityName %@ ID%@",cityName,cityId);
    
    
    //Make Database connection
    database = [DBConnectionManager getDatabaseObject];
    
    
    // navbackbool=TRUE;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    remoteHostStatus = [reachability currentReachabilityStatus];
    
    
    
    newsID=[[NSMutableArray alloc]init];
    newsTitle=[[NSMutableArray alloc]init];
    newsTitleimg=[[NSMutableArray alloc]init];
    newsTitleimgURL=[[NSMutableArray alloc]init];
    timeStamp=[[NSMutableArray alloc]init];
    
    fetchnewsID=[[NSMutableArray alloc]init];
    fetchnewsTitle=[[NSMutableArray alloc]init];
    fetchnewsTitleimg=[[NSMutableArray alloc]init];
    fetchtimeStamp=[[NSMutableArray alloc]init];
    fetchnewsTitleimgURL=[[NSMutableArray alloc]init];
    
    
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
    UIImageView *navbarimage = [[UIImageView alloc] init];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        navbarimage.frame=CGRectMake(0,20, 320,41.5);
    } else {
        navbarimage.frame=CGRectMake(0,0, 320,41.5);
    }
    
    [navbarimage setImage:[UIImage imageNamed:@"navbar.png"]];
    navbarimage.userInteractionEnabled=TRUE;
    navbarimage.opaque = YES;
    [mainbg_img addSubview:navbarimage];
    [navbarimage release];
    
    
#pragma NaviGation Left(back button) bar Button
    back_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    back_btn.frame=CGRectMake(5,9,49.5,29);
    [back_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-button" ofType:@"png"]] forState:UIControlStateNormal];
//    back_btn.titleLabel.font=[UIFont fontWithName:@"ZhunYuan" size:13.0f];
//    [back_btn setTitle:@"  返回" forState:UIControlStateNormal];
//    [back_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back_btn addTarget:self action:@selector(back_btnAction) forControlEvents:UIControlEventTouchUpInside];
    [navbarimage addSubview:back_btn];

    
    
#pragma Navigation Bar Title
//    UILabel *navbartitle=[[UILabel alloc] init];
//    navbartitle.frame=CGRectMake(0,2.5,320,34);
//    //navbartitle.text=[NSString stringWithFormat:@"China News Digest"];
//      navbartitle.text=[NSString stringWithFormat:@"凡事"];
//    navbartitle.textAlignment=1;
//    navbartitle.textColor= [UIColor whiteColor];
//    navbartitle.backgroundColor=[UIColor clearColor];
//    navbartitle.font=[UIFont fontWithName:@"ZhunYuan" size:18];
//    navbartitle.shadowColor = [UIColor grayColor];
//    navbartitle.shadowOffset = CGSizeMake(0,0);
//    [navbarimage addSubview:navbartitle];
//    [navbartitle release];
    
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
    
    
    
    back_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    back_btn.frame=CGRectMake(5,9,49.5,29);
    [back_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-button" ofType:@"png"]] forState:UIControlStateNormal];
//    back_btn.titleLabel.font=[UIFont fontWithName:@"ZhunYuan" size:13.0f];
//    [back_btn setTitle:@"  返回" forState:UIControlStateNormal];
//    [back_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    back_btn.hidden=TRUE;
    [back_btn addTarget:self action:@selector(back_btnActionmainNews) forControlEvents:UIControlEventTouchUpInside];
    [navbarimage addSubview:back_btn];
    
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
  UILabel *  city_lbl=[[UILabel alloc] init];
    city_lbl.frame=CGRectMake(25,0,210,20);
    //city_lbl.text=[NSString stringWithFormat:@"City: %@",cityName];
    city_lbl.text=[NSString stringWithFormat:@"%@",cityName];
    city_lbl.textAlignment=0;
    city_lbl.textColor= [UIColor whiteColor];
    city_lbl.backgroundColor=[UIColor clearColor];
    city_lbl.font=[UIFont fontWithName:@"ZhunYuan" size:13];
    [category_img addSubview:city_lbl];
    [city_lbl release];
    
    
    
    //tableView
    
    if(IS_IPHONE){
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
             tableview=[[UITableView alloc]initWithFrame:CGRectMake(19.25,106+20+20+20, 281.5, 370-40) style:UITableViewStyleGrouped];
        } else {
             tableview=[[UITableView alloc]initWithFrame:CGRectMake(19.25,106+20+20, 281.5, 370-40) style:UITableViewStyleGrouped];
        }
       }
    else{
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            tableview=[[UITableView alloc]initWithFrame:CGRectMake(19.25,126+20+20, 281.5, 316-80) style:UITableViewStyleGrouped];
        } else {
            tableview=[[UITableView alloc]initWithFrame:CGRectMake(19.25,126+20, 281.5, 316-80) style:UITableViewStyleGrouped];
        }
        
    }
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.backgroundView = nil;
    tableview.backgroundColor = [UIColor clearColor];
    [tableview setShowsVerticalScrollIndicator:NO];
    [mainbg_img addSubview:tableview];
    [tableview registerClass:[CNFACategoryByCityCell class] forCellReuseIdentifier:@"identifier"];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    
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
    
    tempindbg.hidden=FALSE;
    [spinner startAnimating];
    
    
    //Sql query selected Timestamp
    
    
//    if(remoteHostStatus == NotReachable) {
//        UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"Alert: Network Error"
//                                                                 message:@"Make sure the signal strength for Wi-Fi or data network is good and that the Device is connected to the network. "
//                                                                delegate:nil
//                                                       cancelButtonTitle:@"OK"
//                                                       otherButtonTitles:nil];
//        [networkmessage show];
//        [networkmessage release];
//        
//        [self FetchRecord_NewsTitle_DB];
//        
//    }
//    else{
//        [self fetch_previousTimeStamp_FromDB];
//    }
//    
    
   // [self addPullToRefreshHeader];
    
    // Do any additional setup after loading the view.
    
}



-(void)fetch_previousTimeStamp_FromDB{
    sqlite3_stmt * countstatement;
    
    if(fetchtimeStamp){
        [fetchtimeStamp removeAllObjects];}
    
    NSString *sqlString1 = [NSString stringWithFormat:@"select  * from News_TitleByCT WHERE CityID=%@",cityId];
    
    const char *sql = [sqlString1 UTF8String];
    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(countstatement) == SQLITE_ROW){
            NSString * UpdateTimeStamp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,5)];
            [fetchtimeStamp addObject:UpdateTimeStamp];
        }
        sqlite3_finalize(countstatement);
    }
    
    //Call service for News List
    CNFAGetNewsListByCtID * gcl = [[CNFAGetNewsListByCtID alloc] init];
    gcl.delegate = self;
    [gcl callWebService:cityId];
    
}


//Nav bar search btn action
-(void)searchbtnAction{
    NSLog(@"dheeraj");
    [searchbar_Txt resignFirstResponder];
    if([searchbar_Txt.text length]>0){
        if(remoteHostStatus == NotReachable) {
            UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"提醒!"
                                                                     message:@"当前没有可用网络，请检查后再试."
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确认"
                                                           otherButtonTitles:nil];            [networkmessage show];
            [networkmessage release];
            
        }
        else{
            tempindbg.hidden=TRUE;
            [spinner stopAnimating];
            
            
            CNFACategoryNewsViewController * gotosearch=[[CNFACategoryNewsViewController alloc] init];
            [gotosearch setIsallsearch:@"searchByCTID"];
            [gotosearch setFromTab1:@"NewspaperByCitySearch"];
            [gotosearch setNewsID:cityId];
            
            [gotosearch setSearchtextvalstr:searchbar_Txt.text];
            [self.navigationController pushViewController:gotosearch animated:YES];
            [gotosearch release];
        }
    }
}


//Service to get news title and thumb
-(void)getNewsTitleListByCity:(NSMutableArray *)newsid  getNewsTitle:(NSMutableArray *)newstitle getImageName:(NSMutableArray *)imagename  getImageUrl:(NSMutableArray *)imageurl getTimeStamp:(NSMutableArray *)timestamp  status:(BOOL)value{
    
    tempindbg.hidden=FALSE;
    [spinner startAnimating];
    
    if(newsID){
        [newsID removeAllObjects];}
    if(newsTitle){
        [newsTitle removeAllObjects];}
    if(newsTitleimg){
        [newsTitleimg removeAllObjects];}
    if(newsTitleimgURL){
        [newsTitleimgURL removeAllObjects];}
    if(timeStamp){
        [timeStamp removeAllObjects];}
    
    newsID=[newsid mutableCopy];
    newsTitle=[newstitle mutableCopy];
    newsTitleimg=[imagename mutableCopy];
    newsTitleimgURL=[imageurl mutableCopy];
    timeStamp=[timestamp mutableCopy];
    
    if([fetchtimeStamp isEqualToArray:timeStamp]){
        //Direct fetch
        NSLog(@"match");
        [self FetchRecord_NewsTitle_DB];
    }
    else{
        //Delete insert than fetch
        NSLog(@"Did not match");
        [self SaveImageToDocumentDirectory];
    }
    
    
}



#pragma Method to save downloaded image in to Document Directory
-(void)SaveImageToDocumentDirectory{
    for (int i=0; i<[newsTitleimgURL count]; i++) {
        NSURL *imageurl = [NSURL URLWithString:[newsTitleimgURL objectAtIndex:i]];
        NSData *  imagedata = [[[NSData alloc]initWithContentsOfURL:imageurl] autorelease];
        image = [UIImage imageWithData: imagedata];
        NSData *  imagedata1 = UIImagePNGRepresentation(image);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[newsTitleimg objectAtIndex:i]]];
        NSLog(@"imagesavedpatwwh==%@",fullPath);
        [fileManager createFileAtPath:fullPath contents:imagedata1 attributes:nil];
        
    }
    
    [self Delete_NewsTitle_Table_DB];
    
}




-(void)Delete_NewsTitle_Table_DB{
    NSString *insertSQL;
    insertSQL = [NSString stringWithFormat: @"DELETE FROM News_TitleByCT WHERE CityID=%@",cityId];
    NSLog(@"insertDelete-%@",insertSQL);
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
    sqlite3_step(InsertStatement);
    sqlite3_finalize(InsertStatement);
    [self InsertRecord_ToNewsTitle_DB];
}



-(void)InsertRecord_ToNewsTitle_DB{
    NSString *insertSQL;
    for(int i=0; i<[newsID count];i++){
        insertSQL = [NSString stringWithFormat: @"INSERT INTO News_TitleByCT (NewsTitleID,NewsTitleName,NewsTitleLogo,UpdateTimeStamp,CityID) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",[newsID objectAtIndex:i],[newsTitle objectAtIndex:i],[newsTitleimg objectAtIndex:i],[timeStamp objectAtIndex:i],cityId];
        
        NSLog(@"insertSQL-- %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
        sqlite3_step(InsertStatement);
    }
    sqlite3_finalize(InsertStatement);
    
    [self FetchRecord_NewsTitle_DB];
}


-(void)FetchRecord_NewsTitle_DB{
    sqlite3_stmt * countstatement;
    
    if(fetchnewsID){
        [fetchnewsID removeAllObjects];}
    if(fetchnewsTitle){
        [fetchnewsTitle removeAllObjects];}
    if(fetchnewsTitleimg){
        [fetchnewsTitleimg removeAllObjects];}
    
    NSString *sqlString1 = [NSString stringWithFormat:@"SELECT * from News_TitleByCT WHERE CityID=%@",cityId];
    NSLog(@"sqlString1sqlString1 %@",sqlString1);
    const char *sql = [sqlString1 UTF8String];
    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(countstatement) == SQLITE_ROW){
            NSString * IDStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,1)];
            NSString * TitleStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,2)];
            NSString * Titleimage = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,3)];
            // NSString * Updatestatus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,2)];
            
            [fetchnewsID addObject:IDStr];
            [fetchnewsTitle addObject:TitleStr];
            [fetchnewsTitleimg addObject:Titleimage];
        }
        
        
        NSLog(@"fetchnewsTitleimgfetchnewsTitleimgfetchnewsTitleimg%@",fetchnewsTitleimg);
        
        
        sqlite3_finalize(countstatement);
    }
    
    if([fetchnewsID count]<1){
        tempindbg.hidden=TRUE;
        [spinner stopAnimating];
    }
    else{
        [tableview reloadData];
        tempindbg.hidden=TRUE;
        [spinner stopAnimating];}
    
    
}



//-(void)getAddnewsSubtitleBySearch:(NSMutableArray *)newsid  getNewsTitle:(NSMutableArray *)newstitle getImageName:(NSMutableArray *)imagename  getImageUrl:(NSMutableArray *)imageurl getTimeStamp:(NSMutableArray *)timestamp  status:(BOOL)value{
//    if(fetchnewsID){
//        [fetchnewsID removeAllObjects];}
//    if(fetchnewsTitle){
//        [fetchnewsTitle removeAllObjects];}
//    if(fetchnewsTitleimg){
//        [fetchnewsTitleimg removeAllObjects];}
//    if(fetchtimeStamp){
//        [fetchtimeStamp removeAllObjects];}
//
//    fetchnewsTitleimgURL=[imageurl mutableCopy];
//    fetchnewsID=[newsid mutableCopy];
//    fetchnewsTitle=[newstitle mutableCopy];
//    fetchnewsTitleimg=[imagename mutableCopy];
//    fetchtimeStamp=[timestamp mutableCopy];
//
//    if([fetchnewsID count]<1){
//        tempindbg.hidden=TRUE;
//        [spinner stopAnimating];
//    }
//    [tableview reloadData];
//}
//



//Key board search btn Action
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchbtnAction];
    NSLog(@"Dheeraj");
    return YES;
}


//When get search result than search bar back btn action
-(void)back_btnActionmainNews{
    back_btn.hidden=TRUE;
    searchbar_Txt.text=@"";
    tempindbg.hidden=FALSE;
    [spinner startAnimating];
    [self FetchRecord_NewsTitle_DB];
}



#pragma Tableview Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return   40.0f;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [fetchnewsID count];
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell1
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell1 setBackgroundColor:[UIColor clearColor]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier=@"identifier";
    CNFACategoryByCityCell *cell1=Nil;
    cell1=(CNFACategoryByCityCell*)[tableview dequeueReusableCellWithIdentifier:Nil];
    if (cell1==nil) {
        
        cell1=[[[CNFACategoryByCityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier]autorelease];}
    cell1.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"row-bg.png"]] autorelease];
    cell1.selectionStyle=UITableViewCellSeparatorStyleNone;
    
#pragma Retrive image from DocumentDirectory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[fetchnewsTitleimg objectAtIndex:indexPath.section]]];
    
    NSLog(@"IMAGE PATH %@",getImagePath);
    
    UIImageView *    newsiconimg = [[UIImageView alloc] init];
    newsiconimg.frame=CGRectMake(13,3,45,35);
    newsiconimg.backgroundColor=[UIColor clearColor];
    newsiconimg.layer.cornerRadius=8.0f;
    newsiconimg.layer.masksToBounds=YES;
    newsiconimg.contentMode=UIViewContentModeScaleAspectFit;
    [newsiconimg setImage:[UIImage imageWithContentsOfFile:getImagePath]];
    newsiconimg.userInteractionEnabled=TRUE;
    newsiconimg.opaque = YES;
    [cell1 addSubview:newsiconimg];
    [newsiconimg release];
    
    
    
#pragma Cell Image View Divder
    UIImageView *cellline_img = [[UIImageView alloc] init];
    cellline_img.frame=CGRectMake(65,2, 1,37);
    [cellline_img setImage:[UIImage imageNamed:@"divider.png"]];
    cellline_img.userInteractionEnabled=TRUE;
    cellline_img.opaque = YES;
    [cell1 addSubview:cellline_img];
    [cellline_img release];
    
#pragma Cell Image View
    UILabel* cell_lbl2=[[UILabel alloc] init];
    cell_lbl2.frame=CGRectMake(80,5,170,30);
    cell_lbl2.text=[NSString stringWithFormat:@"%@",[fetchnewsTitle objectAtIndex:indexPath.section]];
    cell_lbl2.textAlignment=0;
    cell_lbl2.textColor= [UIColor whiteColor];
    cell_lbl2.backgroundColor=[UIColor clearColor];
    cell_lbl2.font=[UIFont fontWithName:@"ZhunYuan" size:13];
    cell_lbl2.shadowColor = [UIColor grayColor];
    cell_lbl2.shadowOffset = CGSizeMake(0,0);
    [cell1 addSubview:cell_lbl2];
    [cell_lbl2 release];
    
#pragma Cell Image  next arrow View Divder
    UIImageView *cellnextarrow_img = [[UIImageView alloc] init];
    cellnextarrow_img.frame=CGRectMake(233,3.5,33.5,33);
    [cellnextarrow_img setImage:[UIImage imageNamed:@"next-arrow.png"]];
    cellnextarrow_img.userInteractionEnabled=TRUE;
    cellnextarrow_img.opaque = YES;
    [cell1 addSubview:cellnextarrow_img];
    [cellnextarrow_img release];
    
    tempindbg.hidden=TRUE;
    [spinner stopAnimating];
    return cell1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CNFANewsDigestViewController *gotocatogery_Cls=[[CNFANewsDigestViewController alloc]init];
    [gotocatogery_Cls setKeystr:@"Back"];
    [gotocatogery_Cls setClassType:@"NewsClass"];
    [gotocatogery_Cls setDropdownmsg:[fetchnewsTitle objectAtIndex:indexPath.section]];
    [gotocatogery_Cls setCityID:cityId];
    [gotocatogery_Cls setCityName:cityName];
    [gotocatogery_Cls setFromTab:@"City"];
    NSLog(@"CITY NAME:::%@",gotocatogery_Cls.CityName);
    [gotocatogery_Cls setFinalNewsID:[fetchnewsID objectAtIndex:indexPath.section]];
    
    [gotocatogery_Cls setNewsID:[fetchnewsID objectAtIndex:indexPath.section]];
    [self.navigationController pushViewController:gotocatogery_Cls animated:YES];
    [gotocatogery_Cls release];
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    
    if(remoteHostStatus == NotReachable) {
        UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"提醒!"
                                                                 message:@"当前没有可用网络，请检查后再试. "
                                                                delegate:nil
                                                       cancelButtonTitle:@"确认"
                                                       otherButtonTitles:nil];
        [networkmessage show];
        [networkmessage release];
        
        [self FetchRecord_NewsTitle_DB];
        
    }
    else{
        [self fetch_previousTimeStamp_FromDB];
    }
    

    
    // force the tableview to load
    navbackbool=TRUE;
    searchbar_Txt.text=@"";
    [searchbar_Txt resignFirstResponder];
    // [tableview reloadData];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [searchbar_Txt resignFirstResponder];
}
///// Reddyyyyy



//- (void)addPullToRefreshHeader {
//    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
//    refreshHeaderView.backgroundColor = [UIColor clearColor];
//    
//    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
//    refreshLabel.backgroundColor = [UIColor clearColor];
//    refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
//    refreshLabel.textAlignment = NSTextAlignmentCenter;
//    
//    today_lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 280, 30)];
//    today_lbl.backgroundColor = [UIColor clearColor];
//    today_lbl.font=[UIFont fontWithName:@"ArialMT" size:11];
//    //today_lbl.font = [UIFont boldSystemFontOfSize:12.0];
//    today_lbl.textAlignment = NSTextAlignmentCenter;
//    
//    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
//    refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
//                                    (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
//                                    27, 44);
//    
//    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
//    refreshSpinner.hidesWhenStopped = YES;
//    
//    
//    //todaydate=[[N]];
//    
//    [refreshHeaderView addSubview:refreshLabel];
//    [refreshHeaderView addSubview:refreshArrow];
//    [refreshHeaderView addSubview:refreshSpinner];
//    [refreshHeaderView addSubview:today_lbl];
//    
//    [tableview addSubview:refreshHeaderView];
//    
//    
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    if (isLoading) return;
//    isDragging = YES;
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (isLoading) {
//        // Update the content inset, good for section headers
//        if (scrollView.contentOffset.y > 0)
//            tableview.contentInset = UIEdgeInsetsZero;
//        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
//            tableview.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (isDragging && scrollView.contentOffset.y < 0) {
//        // Update the arrow direction and label
//        [UIView animateWithDuration:0.25 animations:^{
//            if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
//                // User is scrolling above the header
//                refreshLabel.text = self.textRelease;
//                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
//            } else {
//                // User is scrolling somewhere within the header
//                refreshLabel.text = self.textPull;
//                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
//            }
//        }];
//    }
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (isLoading) return;
//    isDragging = NO;
//    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
//        // Released above the header
//        [self startLoading];
//    }
//}
//
//- (void)startLoading {
//    isLoading = YES;
//    
//    // Show the header
//    [UIView animateWithDuration:0.3 animations:^{
//        tableview.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
//        refreshLabel.text = self.textLoading;
//        today_lbl.text=todaydate;
//        refreshArrow.hidden = YES;
//        [refreshSpinner startAnimating];
//    }];
//    
//    // Refresh action!
//    [self refresh];
//}
//
//- (void)stopLoading {
//    isLoading = NO;
//    
//    // Hide the header
//    [UIView animateWithDuration:0.3 animations:^{
//        tableview.contentInset = UIEdgeInsetsZero;
//        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
//    }
//                     completion:^(BOOL finished) {
//                         [self performSelector:@selector(stopLoadingComplete)];
//                     }];
//}
//
//- (void)stopLoadingComplete {
//    // Reset the header
//    
//    if(remoteHostStatus == NotReachable) {
//        UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"Alert: Network Error"
//                                                                 message:@"Make sure the signal strength for Wi-Fi or data network is good and that the Device is connected to the network. "
//                                                                delegate:nil
//                                                       cancelButtonTitle:@"OK"
//                                                       otherButtonTitles:nil];
//        [networkmessage show];
//        [networkmessage release];
//        
//        
//        
//        [self FetchRecord_NewsTitle_DB];
//        
//    }
//    else{
//        
//        
//        NSDateFormatter *formattedDate = [[[NSDateFormatter alloc]init] autorelease];
//        [formattedDate setDateFormat:@"MMM d, h:mm a"];
//        NSString *lastupdated = [NSString stringWithFormat:@"Last Updated on %@",[formattedDate stringFromDate:[NSDate date]]];
//        todaydate=[[NSString alloc]initWithString:lastupdated];
//        [self fetch_previousTimeStamp_FromDB];
//    }
//    
//    
//    refreshLabel.text = self.textPull;
//    refreshArrow.hidden = NO;
//    [refreshSpinner stopAnimating];
//}
//
//- (void)refresh {
//    // This is just a demo. Override this method with your custom reload action.
//    // Don't forget to call stopLoading at the end.
//    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
//}
//
//- (void)addItem {
//    // Add a new time
//    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
//    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
//    NSString *now = [dateFormatter stringFromDate:[NSDate date]];
//    [items insertObject:[NSString stringWithFormat:@"%@", now] atIndex:0];
//    
//    [tableview reloadData];
//    
//    [self stopLoading];
//}
//
//- (void)setupStrings{
//    
//    
//    
//    NSDateFormatter *formattedDate = [[[NSDateFormatter alloc]init] autorelease];
//    [formattedDate setDateFormat:@"MMM d, h:mm a"];
//    NSString *lastupdated = [NSString stringWithFormat:@"Last Updated on %@",[formattedDate stringFromDate:[NSDate date]]];
//    
//    textPull = [[NSString alloc] initWithString:@"Pull down to refresh..."];
//    textRelease = [[NSString alloc] initWithString:@"Release to refresh..."];
//    textLoading = [[NSString alloc] initWithString:@"Loading..."];
//    
//    
//    
//    todaydate=[[NSString alloc]initWithString:lastupdated];
//    
//}

-(void)back_btnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}



///
@end
