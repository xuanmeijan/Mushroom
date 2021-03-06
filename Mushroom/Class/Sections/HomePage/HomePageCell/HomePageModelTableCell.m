//
//  HomePageModelTableCell.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/20.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageModelTableCell.h"
#import "HomePageCollectionCell.h"

@interface HomePageModelTableCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) HomePageTableCellVM *viewModel;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation HomePageModelTableCell

+ (instancetype)cellWithTable:(UITableView *)tableView
                 andIndexPath:(NSIndexPath *)indexPath
                 andViewModel:(BaseTableViewCellVM *)viewModel
{
    NSString *identify = NSStringFromClass([self class]);
    NSString *cellName = [NSString stringWithFormat:@"%@%ld%ld",identify,indexPath.section,indexPath.row];
    HomePageModelTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil)
    {
        cell = [[HomePageModelTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName andindexPath:indexPath andViewModel:viewModel];
    }
    
    cell.viewModel = (HomePageTableCellVM *)viewModel;

    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                 andindexPath:(NSIndexPath *)indexPath
                 andViewModel:(BaseTableViewCellVM *)viewModel
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initView:indexPath];
        
        @weakify(self);
        [RACObserve(self, viewModel) subscribeNext:^(BaseTableViewCellVM *viewModel) {
            @strongify(self);
            [self initData];
        }];
    }
    
    return self;
}

- (void)initView:(NSIndexPath *)indexPath
{
    self.contentView.backgroundColor = [UIColor blueColor];
    [self initCollection];
}

- (void)initCollection
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    // 设置item大小
    flowLayout.itemSize = CGSizeMake(APP_SCREEN_WIDTH / 2 - 3, APP_SCREEN_HEIGHT / 4 - 30);
    // section距离边界的间距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 3, 0, 0);
    
    // 集合视图
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, (APP_SCREEN_HEIGHT / 4 - 20) * 3 - 10) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.bounces = NO;
    // 注册item
    [_collectionView registerClass:[HomePageCollectionCell class] forCellWithReuseIdentifier:@"reuse"];
    
    // 垂直:各小方格之间的列间距
    flowLayout.minimumInteritemSpacing = 2;
    // 行间距
    flowLayout.minimumLineSpacing = 10 ;
    
    [self.contentView addSubview:_collectionView];
}

- (void)initData
{
    _dataArray = [self.viewModel getDataArray];
    _collectionView.height = (APP_SCREEN_HEIGHT / 4 - 20) * _dataArray.count / 2;
}

#pragma mark - <UICollectionViewDelegate/UICollectionViewDataSource>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageSubDataModel *dataModel = _dataArray[indexPath.row];
    [self.viewModel.cellClickSubject sendNext:dataModel];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCollectionCell *homePageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    homePageCell.subDataModel = _dataArray[indexPath.row];
    
    return homePageCell;
}

@end
