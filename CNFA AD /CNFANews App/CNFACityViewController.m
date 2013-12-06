//
//  CNFACityViewController.m
//  CNFANews App
//
//  Created by Dex on 24/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFACityViewController.h"
#import "CNFACategoryCell.h"
#define REFRESH_HEADER_HEIGHT 52.0f
#define IS_IPHONE ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface CNFACityViewController ()

@end

@implementation CNFACityViewController

@synthesize textPull, textRelease, textLoading, refreshHeaderView, refreshLabel, refreshArrow, refreshSpinner,tableview,todaydate;
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
       // [self setupStrings];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = NSLocalizedString(@"城市", @"城市");
        self.tabBarItem.image = [UIImage imageNamed:@"147.png"];
     //    [self setupStrings];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Make Database connection
    database = [DBConnectionManager getDatabaseObject];

    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    remoteHostStatus = [reachability currentReachabilityStatus];
    

    
    // navbackbool=TRUE;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
     CityIDarr=[[NSMutableArray alloc]init];
     CityName=[[NSMutableArray alloc]init];
     UpdateTime=[[NSMutableArray alloc]init];
    provinceArr=[[NSMutableArray alloc]init];
    
    
     fetchnCityIDarr=[[NSMutableArray alloc]init];
     fetchCityName=[[NSMutableArray alloc]init];
     fetchUpdateTime=[[NSMutableArray alloc]init];
    fetchProvinceArr=[[NSMutableArray alloc]init];
    
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
    
#pragma Navigation Bar Title
//    UILabel *navbartitle=[[UILabel alloc] init];
//    navbartitle.frame=CGRectMake(0,2.5,320,34);
//    //navbartitle.text=[NSString stringWithFormat:@"City"];
//    navbartitle.text=[NSString stringWithFormat:@"凡事"];
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
    back_btn.frame=CGRectMake(5,5.5,49.5,29);
   
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

    
    
      
    if(IS_IPHONE)
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            tableview=[[UITableView alloc]initWithFrame:CGRectMake(19.25,106+20, 281.5, 370) style:UITableViewStyleGrouped];
        } else {
            tableview=[[UITableView alloc]initWithFrame:CGRectMake(19.25,106, 281.5, 370) style:UITableViewStyleGrouped];
        }
    }
    else
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            tableview=[[UITableView alloc]initWithFrame:CGRectMake(19.25,106+20, 281.5, 316-30) style:UITableViewStyleGrouped];
        } else {
            tableview=[[UITableView alloc]initWithFrame:CGRectMake(19.25,106, 281.5, 316-30) style:UITableViewStyleGrouped];
        }
    
    }
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundView = nil;
    tableview.backgroundColor = [UIColor clearColor];
    [tableview setShowsVerticalScrollIndicator:NO];
    [mainbg_img addSubview:tableview];
    [tableview registerClass:[CNFACategoryCell class] forCellReuseIdentifier:@"identifier"];
    
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
    
    
//    if(remoteHostStatus == NotReachable) {
//        UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"Alert: Network Error"
//                                                                 message:@"Make sure the signal strength for Wi-Fi or data network is good and that the Device is connected to the network. "
//                                                                delegate:nil
//                                                       cancelButtonTitle:@"OK"
//                                                       otherButtonTitles:nil];
//        [networkmessage show];
//        [networkmessage release];
//       [self FetchRecord_All_CityList_DB];
//    }
//    else{
//        [self fetch_previousTimeStamp_FromDB];
//    }
    
    ///////Reddy
    
     //  [self addPullToRefreshHeader];
    
    
//// Reddy
    
    
    
	// Do any additional setup after loading the view.
}
-(void)fetch_previousTimeStamp_FromDB{
    sqlite3_stmt * countstatement;
    
    if(fetchUpdateTime){
        [fetchUpdateTime removeAllObjects];}
    
    NSString *sqlString1 = [NSString stringWithFormat:@"select  * from All_CityList"];
    
    const char *sql = [sqlString1 UTF8String];
    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(countstatement) == SQLITE_ROW){
            NSString * UpdateTimeStamp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,3)];
            [fetchUpdateTime addObject:UpdateTimeStamp];
        }
        sqlite3_finalize(countstatement);
    }
      
    //Call service for News List
    CNFAGetCityList* CNF=[[CNFAGetCityList alloc] init];
    CNF.delegate=self;
    [CNF callWebService:@"city"];
    
}



-(void)getCityLists:(NSMutableArray *)CityID  getCityTitleName :(NSMutableArray *)CityTitleName  getupdateTime:(NSMutableArray *)updatetimestamp getProvince:(NSMutableArray *)province  status:(BOOL)value{

    if(UpdateTime){[UpdateTime removeAllObjects];}
    if(CityName){[CityName removeAllObjects];}
    if(CityIDarr){[CityIDarr removeAllObjects];}
    if(provinceArr){[provinceArr removeAllObjects];}
   
    CityIDarr=[CityID mutableCopy];
    CityName=[CityTitleName mutableCopy];
    UpdateTime=[updatetimestamp mutableCopy];
    provinceArr=[province mutableCopy];
    
    if([fetchUpdateTime isEqualToArray:UpdateTime]){
         [self FetchRecord_All_CityList_DB];
    
    }else{
       [self Delete_All_CityList_Table_DB];
   }
 
}



-(void)Delete_All_CityList_Table_DB{
    NSString *insertSQL;
    insertSQL = [NSString stringWithFormat: @"DELETE FROM All_CityList"];
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
    sqlite3_step(InsertStatement);
    sqlite3_finalize(InsertStatement);
    [self InsertRecord_ToAll_CityList_DB];
}


-(void)InsertRecord_ToAll_CityList_DB{
    NSString *insertSQL;
    for(int i=0; i<[CityIDarr count];i++){
        insertSQL = [NSString stringWithFormat: @"INSERT INTO All_CityList (CityID,CityName,UpdateTime) VALUES (\"%@\",\"%@\",\"%@\")",[CityIDarr objectAtIndex:i],[CityName objectAtIndex:i],[UpdateTime objectAtIndex:i]];
        
        NSLog(@"insertSQL-- %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
        sqlite3_step(InsertStatement);
    }
    sqlite3_finalize(InsertStatement);
    
    [self FetchRecord_All_CityList_DB];
}


-(void)FetchRecord_All_CityList_DB{
    sqlite3_stmt * countstatement;
    
    if(fetchnCityIDarr){
        [fetchnCityIDarr removeAllObjects];}
    if(fetchCityName){
        [fetchCityName removeAllObjects];}
    if(fetchUpdateTime){
        [fetchUpdateTime removeAllObjects];}
//    if(fetchProvinceArr){
//        [fetchProvinceArr removeAllObjects];}
    
    NSString *sqlString1 = [NSString stringWithFormat:@"SELECT * from All_CityList "];
    
    const char *sql = [sqlString1 UTF8String];
    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(countstatement) == SQLITE_ROW){
            NSString * cityidstr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,1)];
            NSString * citynamestr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,2)];
            NSString * cityupdatetimestr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,3)];
         
            [fetchnCityIDarr addObject:cityidstr];
            [fetchCityName addObject:citynamestr];
            [fetchUpdateTime addObject:cityupdatetimestr];
            //fetchProvinceArr addObject:<#(id)#>
        }
        
        sqlite3_finalize(countstatement);
    }
    
    if([fetchnCityIDarr count]<1){
        tempindbg.hidden=TRUE;
        [spinner stopAnimating];
    }
    else{
        [tableview reloadData];
        tempindbg.hidden=TRUE;
        [spinner stopAnimating];}

}



-(void)getCityTitleListBySearch:(NSMutableArray *)Cityids  getCityName:(NSMutableArray *)citynames getTimsstamp:(NSMutableArray *)timestamp   status:(BOOL)value
{

    if(fetchnCityIDarr){
        [fetchnCityIDarr removeAllObjects];}
    if(fetchCityName){
        [fetchCityName removeAllObjects];}
    if(fetchUpdateTime){
        [fetchUpdateTime removeAllObjects];}
    
    
    fetchnCityIDarr=[Cityids mutableCopy];
    fetchCityName=[citynames mutableCopy];
    fetchUpdateTime=[timestamp mutableCopy];
   
    
    if([fetchnCityIDarr count]<1){
        tempindbg.hidden=TRUE;
        [spinner stopAnimating];
        [tableview reloadData];
    }
    else{
        [tableview reloadData];}
}




- (void)tableView:(UITableView *)tableView
willDisplayCell:(UITableViewCell *)cell1
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell1 setBackgroundColor:[UIColor clearColor]];
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




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CNFACategoryCell *cell1=Nil;
    static NSString *identifier=@"identifier";
    cell1=(CNFACategoryCell *)[tableview dequeueReusableCellWithIdentifier:Nil];
      if (cell1==nil) {
       cell1=[[[CNFACategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];}
    
        cell1.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"row-bg.png"]] autorelease];
        cell1.selectionStyle=UITableViewCellSeparatorStyleNone;
        
        
#pragma Cell Image View
        UILabel* cell_lbl1=[[UILabel alloc] init];
        cell_lbl1.frame=CGRectMake(15,5,50,30);
    if ([provinceArr count] !=0) {
        cell_lbl1.text=[NSString stringWithFormat:@"%@",[provinceArr objectAtIndex:indexPath.section]];
    }
    
        cell_lbl1.textAlignment=1;
        cell_lbl1.textColor= [UIColor whiteColor];
        cell_lbl1.backgroundColor=[UIColor clearColor];
        cell_lbl1.font=[UIFont fontWithName:@"ZhunYuan" size:13];
        cell_lbl1.shadowColor = [UIColor grayColor];
        cell_lbl1.shadowOffset = CGSizeMake(0,0);
        [cell1 addSubview:cell_lbl1];
        [cell_lbl1 release];
        
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
        cell_lbl2.text=[fetchCityName objectAtIndex:indexPath.section];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return [fetchCityName count];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     CNFANewsViewControllerByCT *gotocatogery_Cls=[[CNFANewsViewControllerByCT alloc]init];
    //[gotocatogery_Cls setKeystr:@"Back"];
    //[gotocatogery_Cls setCityId:[fetchnCityIDarr objectAtIndex:<#(NSUInteger)#>]];
    
    if ([fetchCityName count] !=0) {
        [gotocatogery_Cls setCityName:[fetchCityName objectAtIndex:indexPath.section]];
    }
    if ([fetchnCityIDarr count] !=0) {
        [gotocatogery_Cls setCityId:[fetchnCityIDarr objectAtIndex:indexPath.section]];
    }
    
      [self.navigationController pushViewController:gotocatogery_Cls animated:YES];
    [gotocatogery_Cls release];
    
}


//When get search result than search bar back btn action
-(void)back_btnActionmainNews{
    back_btn.hidden=TRUE;
    searchbar_Txt.text=@"";
    tempindbg.hidden=FALSE;
    [spinner startAnimating];
    
    [self FetchRecord_All_CityList_DB];
}


//Nav bar search btn action
-(void)searchbtnAction{
    NSLog(@"Btn Click");
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
            [gotosearch setIsallsearch:@"DefaultAllSearch"];
             [gotosearch setFromTab1:@"CitySearch"];
            [gotosearch setSearchtextvalstr:searchbar_Txt.text];
            [self.navigationController pushViewController:gotosearch animated:YES];
            [gotosearch release];
       }
    }
}



//Key board search btn Action
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
   [self searchbtnAction];
   return YES;
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

///// redddyyyy
//
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
//        [self FetchRecord_All_CityList_DB];
//        
//    }
//    else{
//        NSDateFormatter *formattedDate = [[[NSDateFormatter alloc]init] autorelease];
//        [formattedDate setDateFormat:@"MMM d, h:mm a"];
//        NSString *lastupdated = [NSString stringWithFormat:@"Last Updated on %@",[formattedDate stringFromDate:[NSDate date]]];
//        todaydate=[[NSString alloc]initWithString:lastupdated];
//        [self fetch_previousTimeStamp_FromDB];
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
//    
//    
//    
//    
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
//    NSDateFormatter *formattedDate = [[[NSDateFormatter alloc]init] autorelease];
//    [formattedDate setDateFormat:@"MMM d, h:mm a"];
//    NSString *lastupdated = [NSString stringWithFormat:@"Last Updated on %@",[formattedDate stringFromDate:[NSDate date]]];
//     textPull = [[NSString alloc] initWithString:@"Pull down to refresh..."];
//    textRelease = [[NSString alloc] initWithString:@"Release to refresh..."];
//    textLoading = [[NSString alloc] initWithString:@"Loading..."];
//    todaydate=[[NSString alloc]initWithString:lastupdated];
//    
//}





///// redddddyyy

-(void)viewWillAppear:(BOOL)animated{
    // force the tableview to load
    if(remoteHostStatus == NotReachable) {
        UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"提醒!"
                                                                 message:@"当前没有可用网络，请检查后再试. "
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

@end
