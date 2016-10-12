//
//  PraticeSpokenController.m
//  TNF
//
//  Created by dongliwei on 16/4/22.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "PraticeSpokenController.h"
#import "TFNCollectionLayout.h"
#import "ImgCollecFootView.h"
#import "SubjectDetailCell.h" //题目cell
#import "VoiceDetailController.h"
#import "SiftMachineController.h"
#import "VoiceCell.h"
#import "BottomView.h"

#define TopItemUsr @"TopCell"
#define DownItemUsr @"ImgCell"
#define VoiceViewTag 10009
#define PlayViewTag 10010
@interface PraticeSpokenController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    
    UIView *_headView;

    
    UICollectionView *_imgCollecView;
    UICollectionView *_topCollecView;
    
    
    CGFloat _edge;
    
    TFNCollectionLayout *_imgLayout;
    
    UITextView *_solveIdeaView;
    UIView *_voiceDetailView;
    UIButton *_voiceBtn;
    UILabel *_voiceLabel;
    UIView *_voiceBtnView;
    BottomView *_bottomView;
    
    BOOL _rotate; //bottomView动画
    
    CGPoint _panGesturePoint;
    NSString *playingUrl;
    VoiceDetailController *_voiceDetailVC;
    
}

@property(nonatomic,strong)ImgCollecFootView *footerView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)AVPlayer *player;

@end


@implementation PraticeSpokenController
-(AVPlayer *)player{
    if (_player == nil) {
        AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:@""]];
        _player = [[AVPlayer alloc]initWithPlayerItem:item];
        
    }
    return _player;
}
-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_player pause];
}

-(void)dealloc{
    _player = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:_bottomView];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _rotate = YES;
    [self initSubViews];

}

#pragma mark --初始化视图
-(void)initSubViews{
    
    _voiceDetailVC = [[VoiceDetailController alloc]init];
    [self addChildViewController:_voiceDetailVC];

    //如果是机经练习，rightBarbutton是筛选按钮
    UIButton *conditionBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [conditionBtn setImage:[UIImage imageNamed:@"pratice_condition"] forState:UIControlStateNormal];
    [conditionBtn addTarget:self action:@selector(conditionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    conditionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0,-10);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:conditionBtn];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageV.image = [UIImage imageNamed:@"Default-667h"];
    imageV.userInteractionEnabled = YES;
    [self.view addSubview:imageV];

    
    _edge = 10;
    self.indexdic = [NSMutableDictionary dictionary];
    self.dataArr = [NSMutableArray array];
    

    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 175 * ratioHeight)];
    _headView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_headView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(kScreenWidth - 20,155*ratioHeight);
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.minimumLineSpacing = 5;
    
    layout.minimumInteritemSpacing = 0;
    
    _topCollecView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 175*ratioHeight) collectionViewLayout:layout];
    _topCollecView.dataSource = self;
    _topCollecView.delegate = self;
    _topCollecView.backgroundView = nil;
    _topCollecView.showsHorizontalScrollIndicator = NO;
    _topCollecView.showsVerticalScrollIndicator = NO;
    _topCollecView.backgroundColor = [MyColor colorWithHexString:@"0x4c4c4c"];
    _topCollecView.backgroundView = nil;
    _topCollecView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [_topCollecView registerClass:[SubjectDetailCell class] forCellWithReuseIdentifier:TopItemUsr];
    _topCollecView.backgroundView = nil;
    [_headView addSubview:_topCollecView];
    
    
    //下方
    
    _imgLayout = [[TFNCollectionLayout alloc]init];
    _imgLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _imgLayout.itemSize = CGSizeMake(75, 75);
    _imgLayout.minimumInteritemSpacing = 10;
    _imgLayout.minimumLineSpacing = 10;
    _imgLayout.columnCount = 3;
    _imgLayout.dataList = [NSMutableArray array];
    _imgCollecView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _headView.height, kScreenWidth, kScreenHeight-_headView.height-64-55*ratioHeight) collectionViewLayout:_imgLayout];
    [_imgCollecView registerNib:[UINib nibWithNibName:@"VoiceCell" bundle:nil] forCellWithReuseIdentifier:DownItemUsr];
    _imgCollecView.backgroundColor = [[UIColor yellowColor]colorWithAlphaComponent:0.7];
    _imgCollecView.delegate = self;
    _imgCollecView.dataSource = self;
    _imgCollecView.bounces = YES;
    [self.view addSubview:_imgCollecView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FSVoiceBubbleShouldStopNotification" object:nil];
    
    
    [self _loadData];
    
    //轻扫 划出 解题思路
    UIPanGestureRecognizer *swipe = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureEvent:)];
    [self.view addGestureRecognizer:swipe];
    
    
    //解题思路
    _solveIdeaView = [[UITextView alloc]initWithFrame:CGRectMake(kScreenWidth, _imgCollecView.top, kScreenWidth, _imgCollecView.height)];
    
    [self.view addSubview:_solveIdeaView];

    
    
    //_voiceBtnView
    _voiceBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 55*ratioHeight-64, kScreenWidth, 55*ratioHeight)];
    _voiceBtnView.tag = VoiceViewTag;
    _voiceBtnView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_voiceBtnView];
    
    //voiceBtn
    _voiceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40*ratioWidth, 40*ratioHeight)];
    [_voiceBtn setImage:[UIImage imageNamed:@"recordBtnImg"] forState:UIControlStateNormal];
    [_voiceBtn addTarget:self action:@selector(recordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_voiceBtnView addSubview:_voiceBtn];
    _voiceBtn.center = CGPointMake(_voiceBtnView.width/2.0, _voiceBtnView.height/2.0);

   //下方播放bottomView
    _bottomView = [[[NSBundle mainBundle]loadNibNamed:@"BottomView" owner:nil options:nil] lastObject];
    _bottomView.frame = CGRectMake(0, kScreenHeight - 55*ratioHeight-64, kScreenWidth, 55*ratioHeight);
    _bottomView.tag = PlayViewTag;
    [self.view insertSubview:_bottomView belowSubview:_voiceBtnView];
    //加tap手势进入声音详情
    [_bottomView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enterVoiceDetail:)]];

    _bottomView.player = self.player;
//    [self.view addSubview:_bottomView];
   
}

#pragma mark --机经预测筛选--
-(void)conditionBtnClick{
    
    SiftMachineController *siftVC = [[SiftMachineController alloc]init];
    [self.navigationController pushViewController:siftVC animated:YES];
}

#pragma mark --进入声音详情页
-(void)enterVoiceDetail:(UITapGestureRecognizer*)tap{
    if (_bottomView.voice == nil) {
        return;
    }
    if (_bottomView.top == kScreenHeight - 55*ratioHeight - 64) { //下方
        [UIView animateWithDuration:0.5 animations:^{
            
            _bottomView.top = _imgCollecView.top;
           
            
         } completion:^(BOOL finished) {
           
            _voiceDetailVC.model = _bottomView.voice;
            _voiceDetailVC.ID = _bottomView.voice.ID;
            _voiceDetailVC.view.frame = CGRectMake(0, _imgCollecView.top+55*ratioHeight, kScreenWidth, kScreenHeight - _imgCollecView.top-55*ratioHeight);
            [self.view addSubview:_voiceDetailVC.view];
        }];
        

    }else{
        [_voiceDetailVC.view removeFromSuperview];
        [UIView animateWithDuration:0.5 animations:^{
           
            _bottomView.top = kScreenHeight - 55*ratioHeight - 64;
        }];
        
    }
    
    
}

#pragma mark  --进入首次加载数据，loadData第一个question，以及前后各一个question
//选中的数据
- (void)_loadData
{

    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"page":@"1",@"key":@"1",@"id":self.ID,@"lid":self.lid,@"type":self.types};
    
    [TNFHttpRequest getSubjectDetai:params completeHandle:^(id result) {
        
        SubjectModel *_subjectM = result;
        [self.dataArr addObject:_subjectM];
        
        
        self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];

        
        _imgLayout.dataList = _subjectM.voiceArr;
        
        [_imgCollecView reloadData];
        
        
        [self beginLoadDown:_subjectM]; //后一个数据

        [_topCollecView reloadData];
        
        
        
        //footer
        if (_subjectM.voiceArr.count !=  10) {
            [self.indexdic setValue:@"1" forKey:_subjectM.ID];

        }else{
            [self.indexdic setValue:@"2" forKey:_subjectM.ID];

        }

    }];
    
}

//begin前面，首次进入加载当前的后一个数据
- (void)beginLoadDown:(SubjectModel *)models
{
    if ([models.next integerValue] == 0) { //后边没了
        [self loadDataup:models];
        return;
    }
    NSLog(@"%@",models.next);
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"page":@"1",@"key":@"1",@"id":models.next,@"lid":self.lid,@"type":self.types};
    
    [TNFHttpRequest getSubjectDetai:params completeHandle:^(id result) {
        
        SubjectModel *_subjectM = result;
        if (_subjectM == nil) { //已是最后一个数据
            [self loadDataup:models];

        }else{
            
            [self.dataArr addObject:_subjectM];
            [_topCollecView reloadData];
            
            if (_subjectM.voiceArr.count !=  10) {
                [self.indexdic setValue:@"1" forKey:_subjectM.ID];
                
            }else{
                [self.indexdic setValue:@"2" forKey:_subjectM.ID];
                
            }
            [self loadDataup:models];  //请求当前的前一个

        }
        
    }];
    

}


#pragma mark --collectionVIew当前展示的第一个question，需要请求新数据
- (void)loadDataup:(SubjectModel *)model
{
    if ([model.pre integerValue] == 0) {
        [_topCollecView reloadData];
        return;
    }
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"page":@"1",@"key":@"1",@"id":model.pre,@"lid":self.lid,@"type":self.types};
    
    [TNFHttpRequest getSubjectDetai:params completeHandle:^(id result) {
        
        SubjectModel *_subjectM = result;
        [self.dataArr insertObject:_subjectM atIndex:0];
        //indexPath row=0位置插入新的数据，selectedIndexPath+1
        self.selectedIndexPath = [NSIndexPath indexPathForItem:self.selectedIndexPath.row + 1 inSection:0];
        
        _topCollecView.contentOffset = CGPointMake(kScreenWidth - 5, 0);
        
        [_topCollecView reloadData];
        
        if (_subjectM.voiceArr.count !=  10) {
            
            [self.indexdic setValue:@"1" forKey:_subjectM.ID];
            
        }else{
            
            [self.indexdic setValue:@"2" forKey:_subjectM.ID];
            
        }
        //pre插入一个数据，本来item是0，更改为1
        [_topCollecView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]  atScrollPosition:UICollectionViewScrollPositionNone animated:NO];        [_topCollecView reloadData];
    }];
    
    
}

#pragma makr --- collectionView当前展示最后一个数据，需要请求下一个quesiton
- (void)loadDatanext:(SubjectModel *)model
{
    
    if ([model.next integerValue] == 0) {
        return;
    }
    NSLog(@"%@",model.next);
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"page":@"1",@"key":@"1",@"id":model.next,@"lid":self.lid,@"type":self.types};
    
    [TNFHttpRequest getSubjectDetai:params completeHandle:^(id result) {
        
        SubjectModel *_subjectM = result;
        
        [self.dataArr addObject:_subjectM];
        
        if (_subjectM.voiceArr.count !=  10) {
            [self.indexdic setValue:@"1" forKey:_subjectM.ID];
            
        }else{
            [self.indexdic setValue:@"2" forKey:_subjectM.ID];
            
        }
        [_topCollecView reloadData];
        
    }];
    
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _topCollecView) {
        
        return self.dataArr.count;

    }else  if(collectionView == _imgCollecView){
        
        if (self.dataArr.count == 0) {
            return 0;
        }
        
        SubjectModel *model = self.dataArr[self.selectedIndexPath.row];
      
        return model.voiceArr.count;
    }
    
    return 0;
    
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _topCollecView) {
    
        SubjectDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TopItemUsr forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.model = self.dataArr[indexPath.row];
        [cell setNeedsLayout];
        return cell;
    }else if(collectionView == _imgCollecView){
        VoiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DownItemUsr forIndexPath:indexPath];
        NSArray *voiceArr = [self.dataArr[self.selectedIndexPath.row] mp3_list];
        NSArray *voiceArray = [self.dataArr[self.selectedIndexPath.row] mp3_list_my];
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:voiceArray];
        [arr addObjectsFromArray:voiceArr];
//        cell.contentView.backgroundColor = [UIColor yellowColor];
        cell.model = arr[indexPath.row];;
        return cell;
        
    }

    return nil;
    
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _imgCollecView) {
        [UIView animateWithDuration:0.3 animations:^{
            
            cell.transform = CGAffineTransformMakeRotation(0.5);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                cell.transform = CGAffineTransformIdentity;
                
            }];
        }];
        
        //关键帧旋转
        
        CGFloat centerX = cell.center.x;
        
        [cell.layer addAnimation:[self keyAnimation:centerX] forKey:@"cellA"];
        
    }
    
}

//动画
-(CAKeyframeAnimation*)keyAnimation:(CGFloat)centerX{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation.values = @[@(centerX),@(centerX - 0.5),@(centerX+0.5)];
    animation.keyTimes = @[@(0.5),@(0.2),@(0.2)];
    animation.duration = 0.9;
    animation.repeatDuration = 5;
    return animation;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _topCollecView) { //题目展开
        
        SubjectDetailCell *cell = (SubjectDetailCell*)[_topCollecView cellForItemAtIndexPath:indexPath];
        [cell downButtonAction];
        [_bottomView stopPlay];
        cell.publicVoiceSuccess = ^{
            [self refreshCurrenData];
        };
        
    }
    if (collectionView == _imgCollecView) {
        
        
        
        SubjectModel *model = _dataArr[self.selectedIndexPath.row];
        VoicesModel *voice = model.voiceArr[indexPath.row];
        //播放
        _bottomView.voice = voice;
        [self playVoice:@"http://m.tuoninfu.com/Public/upload/media/20151229/14513689134197.mp3"];
        
    }
    
}

#pragma mark --playerBottolView的显示和隐藏动画--
-(void)bottomViewHidden{
    
    if (_rotate) {
        _rotate = NO;
        
        [UIView animateWithDuration:0.5 animations:^{
            CATransition *myTra = [CATransition animation];
            myTra.duration = 0.5;
            myTra.type = kCATransitionMoveIn;
            [_voiceBtnView.layer addAnimation:myTra forKey:nil];
            
            //水波动效果
            CATransition *transition = [CATransition animation];
            
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            transition.duration = 1.0f;
            transition.type = @"rippleEffect";
            
            [_bottomView.layer addAnimation:transition forKey:@"rippleEffect"];
            
            [self.view bringSubviewToFront:_bottomView];
            
            
        }];
        //        [UIView animateWithDuration:4.0 animations:^{
        //            _bottomView.layer.anchorPoint = CGPointMake(_bottomView.width/2.0, 0);
        //
        //            _bottomView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        ////            _bottomView.transform = CGAffineTransformMakeTranslation(0,_bottomView.height/2.0);
        //        }];
    }else{
        
        _rotate = YES;
        CATransition *myTra = [CATransition animation];
        myTra.duration = 0.5;
        myTra.type = kCATransitionMoveIn;
        [_bottomView.layer addAnimation:myTra forKey:nil];
        
        //水波动效果
        CATransition *transition = [CATransition animation];
        
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        transition.duration = 1.0f;
        transition.type = @"rippleEffect";
        
        [_voiceBtnView.layer addAnimation:transition forKey:@"rippleEffect"];
        [self.view bringSubviewToFront:_voiceBtnView];
        
        
        //        [UIView animateWithDuration:4.0 animations:^{
        //            _bottomView.layer.anchorPoint = CGPointMake(_bottomView.width/2.0, 0);
        //
        //            _bottomView.transform = CGAffineTransformMakeRotation(M_PI_2);
        ////            _bottomView.transform = CGAffineTransformMakeTranslation(0, -_bottomView.height/2.0);
        //        }];
        
        
        
        
    }
    
    
    
}

#pragma mark --播放控制--
-(void)playVoice:(NSString*)url{
    
    //切换至录音按钮
    if (playingUrl && [playingUrl isEqualToString:url]) {
        //暂停
        [self pausePlayVoice:playingUrl];
        [_bottomView pausePlay];
        [self bottomViewHidden];

        return;
        
    }
    
    if (_rotate == YES) {
        [self bottomViewHidden];

    }
    //打开了新的播放
    [self.player replaceCurrentItemWithPlayerItem:[[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:@"http://m.tuoninfu.com/Public/upload/media/20151229/14513689134197.mp3"]]];
    
    [self.player play];
    [_bottomView beginPlay];
    playingUrl = url;
    
}

-(void)pausePlayVoice:(NSString*)url{
    [self.player pause];
    playingUrl = nil;
}

-(void)animate{
    
    CATransform3D move = CATransform3DMakeTranslation(0, 80*ratioHeight, 0);
    
    CATransform3D back = CATransform3DMakeTranslation(0, -80*ratioHeight,0);
    
    CATransform3D rotate0 = CATransform3DMakeRotation(-M_PI_2, 1, 0, 0);
    
    CATransform3D rotate1 = CATransform3DMakeRotation(M_PI_2, 1, 1, 0);
    CATransform3D mat0 = CATransform3DConcat(CATransform3DConcat(move, rotate0), back);
    
    CATransform3D mat1 = CATransform3DConcat(CATransform3DConcat(move, rotate1), back);
    _voiceBtnView.layer.transform = mat0;
    _bottomView.layer.transform = mat1;
    
}


#pragma mark - UIScrollView Delegate ，数据联动
//当selectedIndexPath是第一个或最后一个时，要请求新的数据，滑动时展示
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self clearViewAppear];
    
    if (self.selectedIndexPath.row == 0) {
        
        SubjectModel *model = [self.dataArr firstObject];
        [self loadDataup:model]; //请求前一个question
        
    }
    
    if(self.selectedIndexPath.row == self.dataArr.count - 1){
        SubjectModel *model = [self.dataArr lastObject];
        [self loadDatanext:model]; //请求后一个question
    }
    
    
    
    
    
    
}

#pragma mark --滑动切换，页面的view部分消失
-(void)clearViewAppear{
    //切换到声音按钮
    if (_rotate == NO) { //不是声音
        [self bottomViewHidden];
        [self.player pause];
    }
    //解题思路消失
    [self ideaViewDisAppear];
    
    //声音详情消失
    if (_bottomView.top != kScreenHeight - 55*ratioHeight - 64) { //下方
        [_voiceDetailVC.view removeFromSuperview];
        _bottomView.top = kScreenHeight - 55*ratioHeight - 64;

        [UIView animateWithDuration:0.5 animations:^{
            
        }];
        
        
    }

    //处理掉播放的音频
    [_bottomView stopPlay];
    
}

//手指离开屏幕时候调用的， 记录新的selectedIndexPath
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //velocity :加速状态,可以根据它的值判断滑动方向
    
    if (scrollView == _topCollecView) {
        
        //1.获取手足滑动之前表示图的偏移量
        double contentOfSet_x = self.selectedIndexPath.row * (kScreenWidth - 20) - _edge;
        //2.获取手指离开时表示图的偏移量
        double touchEnd_x = scrollView.contentOffset.x;
        
        //3.根据原始的位置和手指离开的位置判断滑动到那一个单元格
        if (velocity.x >= .7 || touchEnd_x - contentOfSet_x >= 70) {
            //-----------向左滑动,要现实右边的视图---------------
            if (self.selectedIndexPath.row < self.dataArr.count - 1) {
                self.selectedIndexPath = [NSIndexPath indexPathForRow:self.selectedIndexPath.row + 1 inSection:0];
            }
            
            targetContentOffset ->x = self.selectedIndexPath.row * (kScreenWidth - 15) - _edge;
            
            
        } else if (velocity.x < -0.7 || touchEnd_x - contentOfSet_x < -70) {
            //-----------向右滑动,要现实左侧的视图---------------
            if (self.selectedIndexPath.row > 0) {
                self.selectedIndexPath = [NSIndexPath indexPathForRow:self.selectedIndexPath.row - 1 inSection:0];
            }
            
            targetContentOffset ->x = self.selectedIndexPath.row * (kScreenWidth - 15) - _edge;
            
        } else {
            
            targetContentOffset ->x = self.selectedIndexPath.row * (kScreenWidth - 15) - _edge;
            
        }
        
        //当前应该展示的quesiton，根据当前voiceArr的数量，决定有无上拉加载更多
        SubjectModel *hearder = self.dataArr[self.selectedIndexPath.row];
        self.text = hearder.info.title;
        NSString *page = [self.indexdic objectForKey:hearder.ID];
        
        if ([page isEqualToString:@"1"]) {
            
            _imgCollecView.footer = nil;
            
            
        }else{
            
            _imgCollecView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
            
        }
        
        SubjectModel *model =  self.dataArr[self.selectedIndexPath.row];
        _imgLayout.dataList = model.voiceArr;
        [_imgCollecView reloadData]; //刷新下方数据
    }
    
    
}


#pragma mark --加载更多 优等声
- (void)upLoad
{
    
    SubjectModel *hearder = self.dataArr[self.selectedIndexPath.row];
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSString *page = [self.indexdic objectForKey:hearder.ID];
    NSDictionary *params = @{@"member_id":useid,@"page":page,@"key":@"1",@"id":hearder.ID,@"lid":hearder.lid,@"type":self.types};
    
    [TNFHttpRequest getSubjectDetai:params completeHandle:^(id result) {
        
        SubjectModel *subjectM = result;
        if (subjectM == nil) {
            [_imgCollecView.footer endRefreshing];
            _imgCollecView.footer = nil;
            
        }else{
            
            [_imgCollecView reloadData];
            if (subjectM.voiceArr.count == 10){ //下一页page数
                
                [self.indexdic setObject:[NSString stringWithFormat:@"%d",[[self.indexdic objectForKey:hearder.ID] intValue] + 1] forKey:hearder.ID];
                
            }else{
                
                [self.indexdic setObject:@"1" forKey:hearder.ID];
            }

        }
    }];

    return;
    
    [WXDataService requestAFWithURL:Url_getSubjectInfo params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [TNFPublicTool HUDWithString:result[@"msg"]];
//
                [_imgCollecView.footer endRefreshing];
                _imgCollecView.footer = nil;
                return;
                
            }
            
            
            NSDictionary *dic = result[@"result"];
            NSArray *myarray1 = dic[@"mp3_list"];
            NSMutableArray *ma = [NSMutableArray array];
            for (NSDictionary *mydic in myarray1) {
                
                VoiceModel *mymodel = [[VoiceModel alloc] initWithDataDic:mydic];
                [ma addObject:mymodel];
                
            }
            
//            for (int i = 0; i < model.voiceArr.count;i++) {
//                
//                NSDictionary *dic = model.titles[i];
//                NSString *str = [[dic allKeys] firstObject];
//                if ([str isEqualToString:@"其他的"]) {
//                    
//                    NSMutableArray *array = [dic objectForKey:str];
//                    [array addObjectsFromArray:ma];
//                    NSDictionary *xdic = @{@"其他的":array};
//                    [model.titles replaceObjectAtIndex:i withObject:xdic];
//                    
//                }
//            }
//            
            if (ma.count == 10){ //下一页page数
                
                [self.indexdic setObject:[NSString stringWithFormat:@"%d",[[self.indexdic objectForKey:hearder.ID] intValue] + 1] forKey:hearder.ID];
                
            }else{
                
                [self.indexdic setObject:@"1" forKey:hearder.ID];
            }
            
            
        }
        
        [_imgCollecView.footer endRefreshing];
        SubjectModel *hearder = self.dataArr[self.selectedIndexPath.row];
        NSString *page = [self.indexdic objectForKey:hearder.ID];
        if ([page isEqualToString:@"1"]) {
            
            _imgCollecView.footer = nil;
            
        }else{
            
            _imgCollecView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
            
        }
        
        _imgLayout.dataList =  [self.dataArr[self.selectedIndexPath.row] titles];

        [_imgCollecView reloadData];
        
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
}



#pragma mark ----------解题思路-----------
- (void)loadContent
{
    
    SubjectModel *hearder = self.dataArr[self.selectedIndexPath.row];
    if (hearder.content != nil) {  // 已经请求过该数据，且添加到model.contents属相
        [self solveIdeaViewAppear:hearder.content];
        return;
    }
    [TNFPublicTool showHUDWithView:self.view];
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"page":@"1",@"key":@"3",@"id":hearder.ID,@"lid":hearder.lid,@"type":self.types};
    
    [TNFHttpRequest getSubjectDetai:params completeHandle:^(id result) {
        
        SubjectModel *subjectM = result;
        SubjectModel *oldModel = self.dataArr[self.selectedIndexPath.row];
        oldModel.content = subjectM.content;
        [TNFPublicTool hideHUDWithView:self.view];

        [self solveIdeaViewAppear:oldModel.content];

        
    }];
    
   
}

#pragma mark ----------相关素材-----------
/*
- (void)loadflies
{
//    _tableView.footer = nil;
    SubjectModel *hearder = self.dataArr[self.selectedIndexPath.row];
    if (hearder.files != nil) {
        
        return;
    }
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"page":@"1",@"key":@"2",@"id":hearder.ID,@"lid":hearder.lid,@"type":self.types};
    
    [WXDataService requestAFWithURL:Url_getSubjectInfo params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                
                return;
                
            }
            
            NSDictionary *dic = result[@"result"];
            SubjectModel *model = self.dataArr[self.selectedIndexPath.row];
            NSArray *array = dic[@"file_list"];
            NSMutableArray *marray = [NSMutableArray array];
            for (NSDictionary *subdic in array) {
                
                subj *file = [[FileModel alloc] initWithDataDic:subdic];
                [marray addObject:file];
                
            }
            
            model.files = marray;
            type = 2;
            _imgLayout.dataList =  [self.dataArr[self.selectedIndexPath.row] titles];

            [_imgCollecView reloadData];
        }
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
}

*/

#pragma mark ---轻扫 显示或隐藏解题思路
-(void)swipeGestureEvent:(UIPanGestureRecognizer*)ges{
    CGPoint  point = [ges translationInView:self.view];
    if (ges.state == UIGestureRecognizerStateBegan) {
        _panGesturePoint = point;
        
    }else if (ges.state == UIGestureRecognizerStateEnded) {
        //x方向的移动，出现解题思路，y方向的移动不作处理
        CGFloat y = fabsf(_panGesturePoint.y - point.y);
        if (y < 50 ) {
            if (_solveIdeaView.left == kScreenWidth) {
                [self loadContent];
            }else{
                [self ideaViewDisAppear];
            }

        }
        
    }
    
    
    

}


#pragma mark --解题思路view--
-(void)solveIdeaViewAppear:(NSString*)text{
 
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[text dataUsingEncoding:NSUTF8StringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
//    NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc]initWithString:@"解题思路:\n"];
//    [textStr appendAttributedString:attrStr];
    _solveIdeaView.attributedText = attrStr;
    [UIView animateWithDuration:0.2 animations:^{
        _solveIdeaView.transform = CGAffineTransformMakeTranslation(-kScreenWidth, 0);
        [self.view bringSubviewToFront:_solveIdeaView];

    }];
    
    
    
}
-(void)ideaViewDisAppear{
    [UIView animateWithDuration:0.2 animations:^{
        _solveIdeaView.transform = CGAffineTransformIdentity;
        
    }];
    
}


#pragma mark --录音按钮--
-(void)recordBtnClick{
    SubjectDetailCell *cell = (SubjectDetailCell*)[_topCollecView cellForItemAtIndexPath:self.selectedIndexPath];
    [cell downButtonAction];
    cell.publicVoiceSuccess = ^{
        
        [self refreshCurrenData];
    };
    
}

#pragma mark --上传录音成功刷新voice 数据
-(void)refreshCurrenData{
    
    SubjectModel *hearder = self.dataArr[self.selectedIndexPath.row];
    NSString *useid = [UserDefaults objectForKey:Userid];
    
    
    NSDictionary *params = @{@"member_id":useid,@"page":@"1",@"key":@"1",@"id":hearder.ID,@"lid":hearder.lid,@"type":self.types};
    
    [TNFHttpRequest getSubjectDetai:params completeHandle:^(id result) {
        
        SubjectModel *subjectM = result;
        if (subjectM == nil) {
            [_imgCollecView.footer endRefreshing];
            _imgCollecView.footer = nil;
            
        }else{
            
            [_imgCollecView reloadData];
            if (subjectM.voiceArr.count == 10){ //下一页page数
                
                [self.indexdic setObject:@"2" forKey:hearder.ID];
                
            }else{
                
                [self.indexdic setObject:@"1" forKey:hearder.ID];
            }
            
        }
    }];
    

}


@end
