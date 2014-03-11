//
//  CNFAFavoritesViewController.m
//  CNFANews App
//
//  Created by Dex on 06/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAFavoritesViewController.h"
#import "CNFATableViewCell.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface CNFAFavoritesViewController ()

@end

@implementation CNFAFavoritesViewController
@synthesize b1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      //  self.title = NSLocalizedString(@"特别喜爱", @"特别喜爱");
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //Make Database connection
    database = [DBConnectionManager getDatabaseObject];
  
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    remoteHostStatus = [reachability currentReachabilityStatus];
    

    
    AddIDarr=[[NSMutableArray alloc]init];
    AddTitlearr=[[NSMutableArray alloc]init];
    AddDetailTextarr=[[NSMutableArray alloc]init];
    AddCreatedTimearr=[[NSMutableArray alloc]init];
    AddNewsNamearr=[[NSMutableArray alloc]init];
    AddCityNamearr=[[NSMutableArray alloc]init];
    UpdateTimearr=[[NSMutableArray alloc]init];    
    
    
#pragma Main BackGround ImageView
    mainbg_img = [[UIImageView alloc] init];
    
    if(IS_IPHONE_5){ mainbg_img.frame=CGRectMake(0,0, 320,520);}
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
         navbarimage.frame=CGRectMake(0,20, 320,41.5);
    } else {
         navbarimage.frame=CGRectMake(0,0, 320,41.5);
    }
   
    [navbarimage setImage:[UIImage imageNamed:@"navbar.png"]];
    navbarimage.userInteractionEnabled=TRUE;
    navbarimage.opaque = YES;
    [mainbg_img addSubview:navbarimage];
    [navbarimage release];
    
    
    
    back_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    back_btn.frame=CGRectMake(5,5.5,49.5,29);
    [back_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-button" ofType:@"png"]] forState:UIControlStateNormal];

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
    
    
 
    
    UIImageView *midbg_img = [[UIImageView alloc] init];
    
    if(IS_IPHONE_5)
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            midbg_img.frame=CGRectMake(14,93+20,292,388-20);
        } else {
            midbg_img.frame=CGRectMake(14,93,292,388);
        }
   
    }
    else
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
             midbg_img.frame=CGRectMake(14,93+20,292,348-20);
        } else {
             midbg_img.frame=CGRectMake(14,93,292,348);
        }
       
    }
    
    [midbg_img setImage:[UIImage imageNamed:@"contact-bg.png"]];
    midbg_img.userInteractionEnabled=TRUE;
    midbg_img.opaque = YES;
    [mainbg_img addSubview:midbg_img];
    [midbg_img release];

    
    tableview=[[UITableView alloc]init];
    if(IS_IPHONE_5){tableview.frame=CGRectMake(0, 0,292,395);}
    else{
        tableview.frame=CGRectMake(0, 0,292,310);}
    tableview.layer.cornerRadius=10.0f;
    tableview.dataSource=self;
    tableview.delegate=self;
    tableview.clipsToBounds=YES;
    tableview.separatorColor=[UIColor clearColor];
    tableview.backgroundColor=[UIColor clearColor];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [super setEditing:YES animated:YES];
        [tableview setEditing:NO animated:YES];
        
    }
   
    [tableview reloadData];
    [midbg_img addSubview:tableview];
        
    [tableview registerClass:[CNFATableViewCell class] forCellReuseIdentifier:@"HI"];
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


    [self FetchRecord_NewsTitle_DB];
	// Do any additional setup after loading the view.
}




-(void)FetchRecord_NewsTitle_DB{
    sqlite3_stmt * countstatement;
    if(AddIDarr){[AddIDarr removeAllObjects];}
    if(AddTitlearr){[AddTitlearr removeAllObjects];}
    if(AddDetailTextarr){[AddDetailTextarr removeAllObjects];}
    if(AddCreatedTimearr){[AddCreatedTimearr removeAllObjects];}
    if(AddNewsNamearr){[AddNewsNamearr removeAllObjects];}
    if(AddCityNamearr){[AddCityNamearr removeAllObjects];}
    if(UpdateTimearr){[UpdateTimearr removeAllObjects];}

   
    NSString *sqlString1 = [NSString stringWithFormat:@"SELECT * from FavouriteTabbar"];
    const char *sql = [sqlString1 UTF8String];
    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(countstatement) == SQLITE_ROW){
            NSString * addIdstr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,1)];
            NSString * Addtitlestr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,2)];
            NSString * addDetailstr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,3)];
            NSString * addTimestr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,4)];
            NSString * addnewsnamestr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,5)];
            NSString * addcitystr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,6)];
            NSString * addupdatetime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,7)];
            
            [AddIDarr addObject:addIdstr];
            [AddTitlearr addObject:Addtitlestr];
            [AddDetailTextarr addObject:addDetailstr];
            [AddCreatedTimearr addObject:addTimestr];
            [AddNewsNamearr addObject:addnewsnamestr];
            [AddCityNamearr addObject:addcitystr];
            [UpdateTimearr addObject:addupdatetime];
            
        }
      sqlite3_finalize(countstatement);
    }
    
    [tableview reloadData];
}





-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
///// Table VIew Delegate Mehthos
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return [AddTitlearr count];
  }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   return 73.0f;
}
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identif =@"HI";
    
   
    
    CNFATableViewCell *cell=Nil;
     cell=(CNFATableViewCell *)[tableView dequeueReusableCellWithIdentifier:Nil];
    if (cell==nil)
    {   cell=[[[CNFATableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identif]autorelease];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *v=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midd-row.png"]] autorelease];
        [v setUserInteractionEnabled:YES];
        cell.backgroundView = v;
        [cell setTag:indexPath.row];
        
        if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
            UIButton *_crossLabel = [UIButton buttonWithType:UIButtonTypeCustom];
            [_crossLabel setFrame:CGRectMake(250 , 0,70.0f, 70)];
            [ _crossLabel.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [ _crossLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [ _crossLabel setTitle:@"删除" forState:UIControlStateNormal];
            [_crossLabel setHidden:YES];
            [_crossLabel setTag:indexPath.row];
            [_crossLabel setBackgroundColor:[UIColor redColor]];
            [ _crossLabel addTarget:self action:@selector(customDelete_btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:_crossLabel];
        }
     
        
        
        
#pragma Cell Image View
    UILabel* cell_lbl1=[[UILabel alloc] init];
    cell_lbl1.frame=CGRectMake(15,7,200,18);
    cell_lbl1.text=[NSString stringWithFormat:@"%@",[AddTitlearr objectAtIndex:indexPath.row]];
    cell_lbl1.textAlignment=0;
        cell_lbl1.userInteractionEnabled=YES;
    cell_lbl1.textColor= [UIColor colorWithRed:68/255.0f green:192/255.0f blue:181/255.0f alpha:1];
    cell_lbl1.backgroundColor=[UIColor clearColor];
    cell_lbl1.font=[UIFont fontWithName:@"ZhunYuan" size:16];
    cell_lbl1.shadowColor = [UIColor grayColor];
    cell_lbl1.shadowOffset = CGSizeMake(0,0);
    [cell.backgroundView  addSubview:cell_lbl1];
    [cell_lbl1 release];
    
#pragma Cell Image View
    celltxt_lbl=[[UILabel alloc] init];
    celltxt_lbl.frame=CGRectMake(38,25,225,27);
    celltxt_lbl.numberOfLines=2;
    celltxt_lbl.text=[NSString stringWithFormat:@"%@",[AddDetailTextarr objectAtIndex:indexPath.row]];
    celltxt_lbl.textAlignment=0;
        celltxt_lbl.userInteractionEnabled=YES;
    celltxt_lbl.textColor= [UIColor whiteColor];
    celltxt_lbl.backgroundColor=[UIColor clearColor];
    celltxt_lbl.font=[UIFont fontWithName:@"ZhunYuan" size:15];
    celltxt_lbl.shadowColor = [UIColor grayColor];
    celltxt_lbl.shadowOffset = CGSizeMake(0,0);
    [cell.backgroundView  addSubview:celltxt_lbl];
    [celltxt_lbl release];
    
    
    
#pragma Cell Image View
    celltxt_lbl3=[[UILabel alloc] init];
    celltxt_lbl3.frame=CGRectMake(75,50,205,15);
    celltxt_lbl3.numberOfLines=2;
    celltxt_lbl3.userInteractionEnabled=YES;
    celltxt_lbl3.text=[NSString stringWithFormat:@"%@ | %@ | %@",[AddNewsNamearr objectAtIndex:indexPath.row],[AddCityNamearr objectAtIndex:indexPath.row],[AddCreatedTimearr objectAtIndex:indexPath.row]];
    celltxt_lbl3.textAlignment=2;
    celltxt_lbl3.textColor= [UIColor colorWithRed:68/255.0f green:192/255.0f blue:181/255.0f alpha:1];
    celltxt_lbl3.backgroundColor=[UIColor clearColor];
    celltxt_lbl3.font=[UIFont fontWithName:@"ZhunYuan" size:12];
    celltxt_lbl3.shadowColor = [UIColor grayColor];
    celltxt_lbl3.shadowOffset = CGSizeMake(0,0);
    [cell.backgroundView addSubview:celltxt_lbl3];
    [celltxt_lbl3 release];
    cell.selectionStyle=UITableViewStylePlain;
    
        
}
    
     return cell;

}
-(void)customDelete_btnAction:(id)sender
{
//    UIButton *senderButton = (UIButton *)sender;
//    UITableViewCell *buttonCell = (UITableViewCell *)[[senderButton superview]superview];
//    UITableView* table = (UITableView *)[buttonCell superview];
//    NSIndexPath* pathOfTheCell = [table indexPathForCell:buttonCell];
//    NSInteger sectionOfTheCell = [pathOfTheCell section];
   
    [AddIDarr removeObjectAtIndex:[sender tag]];
    [AddTitlearr removeObjectAtIndex:[sender tag]];
    [AddDetailTextarr removeObjectAtIndex:[sender tag]];
    [AddCreatedTimearr removeObjectAtIndex:[sender tag]];
    [AddNewsNamearr removeObjectAtIndex:[sender tag]];
    [AddCityNamearr removeObjectAtIndex:[sender tag]];
    [UpdateTimearr removeObjectAtIndex:[sender tag]];
    
    [self Delete_FevRecord_DB];

}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
       NSLog(@"Dheeraj");
    int x;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        x=1;
    }
    else
    {
        x=0;
    }
    return x;
}





- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (self.editing == NO || !indexPath){
            return UITableViewCellEditingStyleNone;
    }
     else{
          
            return UITableViewCellEditingStyleDelete;
      }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
           
            [AddIDarr removeObjectAtIndex:indexPath.row];
            [AddTitlearr removeObjectAtIndex:indexPath.row];
            [AddDetailTextarr removeObjectAtIndex:indexPath.row];
            [AddCreatedTimearr removeObjectAtIndex:indexPath.row];
            [AddNewsNamearr removeObjectAtIndex:indexPath.row];
            [AddCityNamearr removeObjectAtIndex:indexPath.row];
            [UpdateTimearr removeObjectAtIndex:indexPath.row];

            [self Delete_FevRecord_DB];
            
        }
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CNFASubCategoryDetailViewController *gotocatogery_Cls=[[CNFASubCategoryDetailViewController alloc]init];
    
    [gotocatogery_Cls setAddCityNamestr:[AddCityNamearr objectAtIndex:indexPath.row]];
    [gotocatogery_Cls setAdddetailtextstr:[AddDetailTextarr objectAtIndex:indexPath.row]];
    [gotocatogery_Cls setAddNewsNamestr:[AddNewsNamearr objectAtIndex:indexPath.row]];
    [gotocatogery_Cls setAddTimestr:[AddCreatedTimearr objectAtIndex:indexPath.row]];
    [gotocatogery_Cls setAddtitlestr:[AddTitlearr objectAtIndex:indexPath.row]];
    [gotocatogery_Cls setAddIDstr:[AddIDarr objectAtIndex:indexPath.row]];
    [gotocatogery_Cls setAddUpdateTime:[UpdateTimearr objectAtIndex:indexPath.row]];
    gotocatogery_Cls.subCategory_UpdateTimearr=[[NSMutableArray alloc]init];
    gotocatogery_Cls.subCategory_AddTitlearr=[[NSMutableArray alloc]init];
    gotocatogery_Cls.subCategory_AddNewsNamearr=[[NSMutableArray alloc]init];
    gotocatogery_Cls.subCategory_AddIDarr=[[NSMutableArray alloc]init];
    gotocatogery_Cls.subCategory_AddDetailTextarr=[[NSMutableArray alloc]init];
    gotocatogery_Cls.subCategory_AddCreatedTimearr=[[NSMutableArray alloc]init];
    gotocatogery_Cls.subCategory_AddCityNamearr=[[NSMutableArray alloc]init];
    [gotocatogery_Cls setPageCurr:[NSString stringWithFormat:@"%d",indexPath.row]];
    gotocatogery_Cls.subCategory_AddCityNamearr=AddCityNamearr;
    gotocatogery_Cls.subCategory_UpdateTimearr=UpdateTimearr;
    gotocatogery_Cls.subCategory_AddTitlearr=AddTitlearr;
    gotocatogery_Cls.subCategory_AddNewsNamearr=AddNewsNamearr;
    gotocatogery_Cls.subCategory_AddIDarr=AddIDarr;
    gotocatogery_Cls.subCategory_AddDetailTextarr=AddDetailTextarr;
    gotocatogery_Cls.subCategory_AddCreatedTimearr=AddCreatedTimearr;
    [gotocatogery_Cls setFromTab:@"favourites"];
    NSLog(@" gotocatogery_Cls.subCategory_AddCreatedTimearr::::%@", gotocatogery_Cls.subCategory_AddCreatedTimearr);
    
    [self.navigationController pushViewController:gotocatogery_Cls animated:YES];
    [gotocatogery_Cls release];
    
}


-(void)Reddy:(UIButton *)sender
{
    
   
    NSInteger tagval=sender.tag;
    if (tagval==1111)
    {
        navrightbtn.tag=2222;
        [super setEditing:YES animated:YES];
        [tableview setEditing:NO animated:YES];
        [tableview reloadData];
        
 
     }
    else
    {
        navrightbtn.tag=1111;
        [super setEditing:NO animated:NO];
        [tableview setEditing:NO animated:NO];
        [tableview reloadData];
        
        [navrightbtn setTitle:@"编辑" forState:UIControlStateNormal];
        
        
    }
 }


-(void)Delete_FevRecord_DB{
    NSString *insertSQL;
    insertSQL = [NSString stringWithFormat: @"DELETE FROM FavouriteTabbar"];
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
    sqlite3_step(InsertStatement);
    sqlite3_finalize(InsertStatement);
    [self Insert_FavRecordtoDB];
}

-(void)Insert_FavRecordtoDB{
    NSString *insertSQL;
    for (int i=0; i<[AddIDarr count]; i++) {
   
    insertSQL = [NSString stringWithFormat: @"INSERT INTO FavouriteTabbar (AddID,AddTitle,AddDetailText,AddCreatedTime,AddNewsName,AddCityName,UpdateTime) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",[AddIDarr objectAtIndex:i],[AddTitlearr objectAtIndex:i],[AddDetailTextarr objectAtIndex:i],[AddCreatedTimearr objectAtIndex:i],[AddNewsNamearr objectAtIndex:i],[AddCityNamearr objectAtIndex:i],[UpdateTimearr objectAtIndex:i]];
     NSLog(@"insertSQL-- %@",insertSQL);
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
        sqlite3_step(InsertStatement);}
    sqlite3_finalize(InsertStatement);
    
    [self FetchRecord_NewsTitle_DB];
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
            
            if([ searchbar_Txt.text length]>0){
                
                [self search_FetchRecord_NewsTitle_DB];
            }
            
        }
    }
}




-(void)search_FetchRecord_NewsTitle_DB{
     back_btn.hidden=FALSE;
    ISSearchEnable=TRUE;
    sqlite3_stmt * countstatement;
    if(AddIDarr){[AddIDarr removeAllObjects];}
    if(AddTitlearr){[AddTitlearr removeAllObjects];}
    if(AddDetailTextarr){[AddDetailTextarr removeAllObjects];}
    if(AddCreatedTimearr){[AddCreatedTimearr removeAllObjects];}
    if(AddNewsNamearr){[AddNewsNamearr removeAllObjects];}
    if(AddCityNamearr){[AddCityNamearr removeAllObjects];}
    if(UpdateTimearr){[UpdateTimearr removeAllObjects];}
    //CREATE TABLE "FavouriteTabbar" ("SNo." INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , "AddID" VARCHAR, "AddTitle" VARCHAR, "AddDetailText" VARCHAR, "AddCreatedTime" VARCHAR, "AddNewsName" VARCHAR, "AddCityName" VARCHAR, "UpdateTime" VARCHAR)
    NSString *sqlString1 = [NSString stringWithFormat:@"SELECT * FROM FavouriteTabbar WHERE AddTitle LIKE '%%%@%%' or AddDetailText  LIKE '%%%@%%'  or AddCityName LIKE '%%%@%%' ",searchbar_Txt.text,searchbar_Txt.text,searchbar_Txt.text];

   // NSString *sqlString1 = [NSString stringWithFormat:@"SELECT * from FavouriteTabbar"];
    const char *sql = [sqlString1 UTF8String];
    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(countstatement) == SQLITE_ROW){
            NSString * addIdstr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,1)];
            NSString * Addtitlestr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,2)];
            NSString * addDetailstr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,3)];
            NSString * addTimestr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,4)];
            NSString * addnewsnamestr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,5)];
            NSString * addcitystr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,6)];
            NSString * addupdatetime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,7)];
            
            [AddIDarr addObject:addIdstr];
            [AddTitlearr addObject:Addtitlestr];
            [AddDetailTextarr addObject:addDetailstr];
            [AddCreatedTimearr addObject:addTimestr];
            [AddNewsNamearr addObject:addnewsnamestr];
            [AddCityNamearr addObject:addcitystr];
            [UpdateTimearr addObject:addupdatetime];
            
        }
        sqlite3_finalize(countstatement);
    }
    if([AddIDarr count]>0){
        
        
        [noresult_lbl setHidden:YES];
        [tableview reloadData];
        
    }else{
        
        [tableview reloadData];
        [noresult_lbl setHidden:NO];
        
    }

    [tableview reloadData];
}







//Key board search btn Action
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchbtnAction];
    return YES;
}




-(void)viewWillAppear:(BOOL)animated{
    [searchbar_Txt resignFirstResponder];
     [noresult_lbl setHidden:YES];
     back_btn.hidden=TRUE;
     searchbar_Txt.text=@"";
     [self FetchRecord_NewsTitle_DB];
 }



-(void)back_btnActionmainNews{
    ISSearchEnable=FALSE;
    back_btn.hidden=TRUE;
    searchbar_Txt.text=@"";
    [noresult_lbl setHidden:YES];
   [self FetchRecord_NewsTitle_DB];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
