//
//  SBAddress4LevelView.m
//  Sunny
//
//  Created by Sunny on 2017/8/11.
//  Copyright © 2017年 Sunny. All rights reserved.
//

#import "SBAddress4LevelView.h"
#import "SBSegmentControlView.h"

#import "SBAddress4LevelDataManager.h"

#import "SBAddress4LevelTableViewCell.h"

#define GMK_Address4LevelTableViewTag   (4450)

#define GMK_Address4levelViewHeight     (screenH * 0.6)

#define GMK_Address4levelDefaultPage    (4)

#define GMK_Address4levelTitleNull      (@"")
#define GMK_Address4levelTitleFirst     (@"请选择")

@interface SBAddress4LevelView ()
<
UIScrollViewDelegate
,SBSegmentControlDelegate
,UITableViewDelegate
,UITableViewDataSource
>
/// 滚动条
@property (nonatomic , strong) UIScrollView * scrollView;
/// 标题栏
@property (nonatomic , strong) SBSegmentControlView * segControl;
/// 弹出层
@property (nonatomic , strong) UIView * contentView;

@property (nonatomic , strong) SBAddress4LevelModel * addressModel;


@property (nonatomic , strong) NSMutableArray <NSString *>* mArrSegTitles;

@property (nonatomic , strong) NSMutableArray <NSArray <SBAddress4LevelModel *> *>* mArrAddress;

@end

@implementation SBAddress4LevelView

#pragma  mark - loadviews
- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, screenW, screenH)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
//        [self initViews];
    }
    return self;
}

- (void)initViews
{
    UIView * vMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    vMask.backgroundColor = [UIColor blackColor];
    vMask.alpha = 0.4f;
    [self addSubview:vMask];
    [self addSubview:self.contentView];
    /// 移动scroll到当前index
    self.scrollView.contentOffset = CGPointMake(([self.segControl indexSelect]) * screenW, 0);
    
}

- (void)showAddressWithModel:(SBAddress4LevelModel *)model
{
    _addressModel = model;
    [self initViews];
    [self show];
}

#pragma  mark - lazy load
- (NSMutableArray <NSString *>*)mArrSegTitles
{
    if (!_mArrSegTitles)
    {
        _mArrSegTitles = [NSMutableArray arrayWithObjects:GMK_Address4levelTitleFirst, GMK_Address4levelTitleNull, GMK_Address4levelTitleNull , GMK_Address4levelTitleNull, nil];
        /// 根据传入的addressModel 刷新segment 标题
        if (GMK_Str_Is_Valid(_addressModel.modelProvince.aName))
        {
            [_mArrSegTitles replaceObjectAtIndex:0 withObject:GMK_Str_Protect(_addressModel.modelProvince.aName)];
        }
        [_mArrSegTitles replaceObjectAtIndex:1 withObject:GMK_Str_Protect(_addressModel.modelCity.aName)];
        [_mArrSegTitles replaceObjectAtIndex:2 withObject:GMK_Str_Protect(_addressModel.modelCounty.aName)];
        [_mArrSegTitles replaceObjectAtIndex:3 withObject:GMK_Str_Protect(_addressModel.modelStreet.aName)];
    }
    return _mArrSegTitles;
}

- (NSMutableArray *)mArrAddress
{
    if (!_mArrAddress)
    {
        _mArrAddress = [[NSMutableArray alloc] initWithCapacity:GMK_Address4levelDefaultPage];
        /// 严格按照顺序来
        [_mArrAddress addObject:[[SBAddress4LevelDataManager sharedInstance] queryProvinceList]];
        if (!_addressModel)
        {
            [_mArrAddress addObject:[NSArray array]];
            [_mArrAddress addObject:[NSArray array]];
            [_mArrAddress addObject:[NSArray array]];
        }
        else
        {
            /// 根据传入的addressModel 刷新数据源
            for (SBAddress4LevelModel * model in _mArrAddress[0])
            {
                if (model.aId == _addressModel.modelProvince.aId)
                {
                    model.isSelected = YES;
                    break;
                }
            }
            
            NSMutableArray * mArrCitys = [NSMutableArray arrayWithArray:[[SBAddress4LevelDataManager sharedInstance] queryAddressListWithFromId:_addressModel.modelProvince.aId level:0]];
            for (SBAddress4LevelModel * model in mArrCitys)
            {
                if (model.aId == _addressModel.modelCity.aId)
                {
                    model.isSelected = YES;
                    break;
                }
            }
            [_mArrAddress addObject:[NSArray arrayWithArray:mArrCitys]];
            
            
            NSMutableArray * mArrCountys = [NSMutableArray arrayWithArray:[[SBAddress4LevelDataManager sharedInstance] queryAddressListWithFromId:_addressModel.modelCity.aId level:1]];
            for (SBAddress4LevelModel * model in mArrCountys)
            {
                if (model.aId == _addressModel.modelCounty.aId)
                {
                    model.isSelected = YES;
                    break;
                }
            }
            [_mArrAddress addObject:[NSArray arrayWithArray:mArrCountys]];
            
            
            NSMutableArray * mArrStreets = [NSMutableArray arrayWithArray:[[SBAddress4LevelDataManager sharedInstance] queryAddressListWithFromId:_addressModel.modelCounty.aId level:2]];
            for (SBAddress4LevelModel * model in mArrStreets)
            {
                if (model.aId == _addressModel.modelStreet.aId)
                {
                    model.isSelected = YES;
                    break;
                }
            }
            [_mArrAddress addObject:[NSArray arrayWithArray:mArrStreets]];
        }
    }
    return _mArrAddress;
}

- (SBSegmentControlView *)segControl
{
    if (!_segControl)
    {
        _segControl = [[SBSegmentControlView alloc] initWithFrame:CGRectMake(0, 0, (screenW - 50), 44)];
        _segControl.HasAnimation = YES;
        _segControl.font = FONT_QuanJiao(16);
        _segControl.arrTitles = self.mArrSegTitles;
        /// 根据标题 选择初始化index
        NSInteger index = 0;
        if (GMK_Str_Is_Valid(self.mArrSegTitles[1])) index = 1;
        if (GMK_Str_Is_Valid(self.mArrSegTitles[2])) index = 2;
        if (GMK_Str_Is_Valid(self.mArrSegTitles[3])) index = 3;
        
        [_segControl selectBtnAtIndex:index];
        _segControl.delegate = self;
    }
    return _segControl;
}

- (UIView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, screenH * 0.4, screenW, GMK_Address4levelViewHeight)];
        _contentView.backgroundColor = GMK_Color_Main_BG_White;
        
        UIButton * btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        btnRight.frame = CGRectMake(_contentView.width - 44, 0, 44, 44);
        [btnRight addTarget:self action:@selector(actionClose) forControlEvents:UIControlEventTouchUpInside];
        [btnRight setImage:IMG_Name(@"icon_cha") forState:UIControlStateNormal];
        [_contentView addSubview:btnRight];
        
        [_contentView addSubview:self.segControl];
        [_contentView addSubview:self.scrollView];
        
        UIView * vLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.segControl.height - kScreenOneScale, screenW, kScreenOneScale)];
        vLine.backgroundColor = RGBAllColor(0xe6e6e6);
        [_contentView addSubview:vLine];
    }
    return _contentView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, screenW, GMK_Address4levelViewHeight-50)];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = GMK_Color_Main_BG_White;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(screenW * GMK_Address4levelDefaultPage, _scrollView.height);
        _scrollView.scrollEnabled = NO;
        
        for (int i = 0; i < GMK_Address4levelDefaultPage; i ++)
        {
            UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * screenW, 0, screenW, _scrollView.height) style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            //[GMBTableView getWithFrame:CGRectMake(i * screenW, 0, screenW, _scrollView.height) target:self style:UITableViewStylePlain];
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.tag = i + GMK_Address4LevelTableViewTag;
            [_scrollView addSubview:tableView];
        }
    }
    return _scrollView;
}

- (SBAddress4LevelModel *)addressModel
{
    GMK_Instance_GetObj(_addressModel, SBAddress4LevelModel);
}

- (void)setCloseBlock:(GMK_Address4LevelBlock)blockT
{
    _closeBlock = nil ; _closeBlock = blockT;
}


#pragma  mark - tableview Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger indexTable = tableView.tag - GMK_Address4LevelTableViewTag;
    return [self.mArrAddress[indexTable] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_DEFAULT_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    CGFloat h = CELL_DEFAULT_HEIGHT;
    
    NSString * identifier = GMK_StringFromClass(SBAddress4LevelTableViewCell);
    
    
    SBAddress4LevelTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        Class cls = NSClassFromString(identifier);
        cell = GMK_Instance_Cell(cls, identifier);
    }
    
    NSInteger selectSeg = [self.segControl indexSelect];
    
    if (tableView.tag == (selectSeg + GMK_Address4LevelTableViewTag))
    {
        SBAddress4LevelModel * model = self.mArrAddress[selectSeg][row];
        
        [cell setupCellModel:model hei:h];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSInteger segIndex = [self.segControl indexSelect];
    
    NSInteger row = indexPath.row;
    
    SBAddress4LevelModel * model = self.mArrAddress[segIndex][row];
    
    if (segIndex < (self.mArrSegTitles.count - 1) )
    {
        /// 判断当前选中标题 为0时，重置mArrSegTitles
        if (segIndex == 0 && GMK_Str_Is_Valid(self.mArrSegTitles[1]))
        {
            [self.mArrSegTitles replaceObjectsInRange:NSMakeRange(1, (self.mArrSegTitles.count - 1)) withObjectsFromArray:@[GMK_Address4levelTitleNull,GMK_Address4levelTitleNull,GMK_Address4levelTitleNull]];
        }
        
        /// 刷新 当前标题头
        [self.mArrSegTitles replaceObjectAtIndex:segIndex withObject:model.aName];
        /// 刷新 下一个 segment 标题头
        [self.mArrSegTitles replaceObjectAtIndex:(segIndex + 1) withObject:GMK_Address4levelTitleFirst];
        
        
        
        /// 刷新 清除所有 model 选中状态
        NSMutableArray * mArrModel = [NSMutableArray arrayWithArray:self.mArrAddress[segIndex]];
        for (SBAddress4LevelModel * model in mArrModel)
        {
            model.isSelected = NO;
        }
        //// 设置新选中model 并刷新当前列数据
        model.isSelected = YES;
        [mArrModel replaceObjectAtIndex:row withObject:model];
        [self.mArrAddress replaceObjectAtIndex:segIndex withObject:[NSArray arrayWithArray:mArrModel]];
        
        ///  刷新self.addressModel
        [self refreshAddressModel:model atSegmentIndex:segIndex];
        
        
        /// 刷新下一列数据
        NSArray * arrNextModel = [[SBAddress4LevelDataManager sharedInstance] queryAddressListWithFromId:model.aId level:segIndex];
        /// 下一个数据源无数据，直接消失
        if (GMK_Ary_Not_Valid(arrNextModel))
        {
            [self dismiss];
        }
        
        [self.mArrAddress replaceObjectAtIndex:(segIndex + 1) withObject:arrNextModel];
        
        /// 刷新 segment 标题 和 选中位置
        self.segControl.arrTitles = self.mArrSegTitles;
        [self.segControl selectBtnAtIndex:(segIndex + 1)];
        
        /// 移动scrollview
        self.scrollView.contentOffset = CGPointMake((segIndex + 1) * screenW, 0);
        
//        [tableView reloadData];
        /// 刷新 当前和下一个tableview
        UITableView * sbTableView = [self.scrollView viewWithTag:(GMK_Address4LevelTableViewTag + (segIndex + 1))];
        [sbTableView reloadData];
    }
    else if (segIndex >= (self.mArrSegTitles.count - 1))
    {
        ///  刷新self.addressModel
        [self refreshAddressModel:model atSegmentIndex:segIndex];
        /// 超出范围 消失
        [self dismiss];
    }
    NSLog(@"");
}

#pragma  mark - scrollview delegate
/// 开始跟踪
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGFloat offsetIndex = scrollView.contentOffset.x/screenW;
//    NSLog(@"offsetbegin:%f , index:%f",scrollView.contentOffset.x , offsetIndex);
}

/// 停止滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetIndex = scrollView.contentOffset.x/screenW;
//    NSLog(@"offsetend:%f , index:%f",scrollView.contentOffset.x , offsetIndex);
}

/// 滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetIndex = scrollView.contentOffset.x/screenW;
//    NSLog(@"offsetscroll:%f , index:%f",scrollView.contentOffset.x , offsetIndex);
    
//    if (offsetIndex <= 0 || offsetIndex >= (self.mArrAddress.count - 1))
//    {
//        scrollView.scrollEnabled = YES;
//        return;
//    }
//    
//    if (++offsetIndex < (self.mArrAddress.count - 1)) {
//        NSString * strTitle = self.mArrSegTitles[(int)++offsetIndex];
//        
//        scrollView.scrollEnabled = GMK_Str_Is_Valid(strTitle);
//    }
}

#pragma  mark - segmentControl delegate
- (void)segmentControl:(SBSegmentControlView *)seg didSelectAtIndex:(NSInteger)index
{
    if (GMK_Str_Not_Valid(self.mArrSegTitles[index]))   return;
    NSInteger offset = self.scrollView.contentOffset.x/screenW;
    if (index == offset)  return;
    
    self.scrollView.contentOffset = CGPointMake(index * screenW, 0);
    
    UITableView * sbTableView = [self.scrollView viewWithTag:(GMK_Address4LevelTableViewTag + index)];
    [sbTableView reloadData];
}

#pragma  mark -  Touch
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    point = [self convertPoint:point fromView:self];
    
    if (!CGRectContainsPoint(self.contentView.frame, point))
    {
        [self actionClose];
    }
}

#pragma  mark -  UIRespond
- (void)actionClose
{
    _addressModel = nil;
    [self dismiss];
}

- (void)dismiss
{
    /// 此处传_addressModel，避免传入get方法生成的obj
    if (self.closeBlock) self.closeBlock(_addressModel);
}

- (void)show
{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    self.contentView.originY = screenH;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.contentView.originY = screenH * 0.4;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma  mark - parseInfo  数据处理
///  刷新self.addressModel
- (void)refreshAddressModel:(SBAddress4LevelModel *)model atSegmentIndex:(NSInteger)segIndex
{
    if (segIndex == 0)
    {
        self.addressModel.modelProvince = (SBAddress4LevelModelProvince *)model;
        self.addressModel.modelCity = nil;
        self.addressModel.modelCounty = nil;
        self.addressModel.modelStreet = nil;
    }
    else if (segIndex == 1)
    {
        self.addressModel.modelCity = (SBAddress4LevelModelCity *)model;
        self.addressModel.modelCounty = nil;
        self.addressModel.modelStreet = nil;
    }
    else if (segIndex == 2)
    {
        self.addressModel.modelCounty = (SBAddress4LevelModelCounty *)model;
        self.addressModel.modelStreet = nil;
    }
    else if (segIndex == 3)
    {
        self.addressModel.modelStreet = (SBAddress4LevelModelStreet *)model;
    }
}

- (void)dealloc
{
    NSLog(@"");
}

@end
