//
//  JNewsCell.m
//  JNews
//
//  Created by 王昊 on 16/6/10.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JNewsCell.h"
#import <UIImageView+WebCache.h>
@interface JNewsCell ()
//新闻图片
@property (strong, nonatomic) IBOutlet UIImageView *imageIcon;
//新闻标题
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
//
@property (strong, nonatomic) IBOutlet UILabel *lblReply;
//新闻副标题
@property (strong, nonatomic) IBOutlet UILabel *lblSubTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imageOther;
@property (strong, nonatomic) IBOutlet UIImageView *imageOther1;

@end

@implementation JNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNewsModel:(JNewsModel *)NewsModel
{
    _NewsModel = NewsModel;
    
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:self.NewsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"302"]];
    
    self.lblTitle.text = self.NewsModel.title;
    self.lblSubTitle.text = self.NewsModel.digest;
    
    // 如果回复太多就改成几点几万
    CGFloat count =  [self.NewsModel.replyCount intValue];
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    self.lblReply.text = displayCount;
    
    if (self.NewsModel.imgextra.count == 2) {
        
        //        [self.imgOther1 sd_setImageWithURL:[NSURL URLWithString:self.NewsModel.imgextra[0][@"imgsrc"]]];
        //        [self.imgOther2 sd_setImageWithURL:[NSURL URLWithString:self.NewsModel.imgextra[1][@"imgsrc"]]];
        
        [self.imageOther sd_setImageWithURL:[NSURL URLWithString:self.NewsModel.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"302"]];
        [self.imageOther1 sd_setImageWithURL:[NSURL URLWithString:self.NewsModel.imgextra[1][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"302"]];
    }
}

+(NSString *)idForRow:(JNewsModel *)NewsModel
{
  
    if (NewsModel.hasHead && NewsModel.photosetID) {
        return @"TopImageCell";
    }else if (NewsModel.hasHead){
        return @"TopTxtCell";
    }else if (NewsModel.imgType){
        return @"BigImageCell";
    }else if (NewsModel.imgextra){
        return @"ImagesCell";
    }else{
        return @"NewsCell";
    }

    
}


+(CGFloat)heigthOfCell:(JNewsModel *)NewsModel
{
    if (NewsModel.hasHead && NewsModel.photosetID){
        return 245;
    }else if(NewsModel.hasHead) {
        return 245;
    }else if(NewsModel.imgType) {
        return 170;
    }else if (NewsModel.imgextra){
        return 130;
    }else{
        return 80;
    }
}
@end
