//
//  JReplyCell.m
//  JNews
//
//  Created by 王昊 on 16/6/24.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JReplyCell.h"
@interface JReplyCell ()
@property (strong, nonatomic) IBOutlet UILabel *nameLable;

@property (strong, nonatomic) IBOutlet UILabel *addressLable;

@property (strong, nonatomic) IBOutlet UILabel *supportLable;


@end

@implementation JReplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setReplyModel:(JReplyModel *)replyModel
{
    _replyModel = replyModel;
    if (_replyModel.name == nil) {
        _replyModel.name = @"";
    }
    self.nameLable.text = _replyModel.name;
    self.addressLable.text = _replyModel.address;
    
    NSRange rangeAddress = [_replyModel.address rangeOfString:@"&nbsp"];
    if (rangeAddress.location != NSNotFound) {
        self.addressLable.text = [_replyModel.address substringToIndex:rangeAddress.location];
    }
    
    self.saylable.text = _replyModel.say;
    
    NSRange rangeSay = [_replyModel.say rangeOfString:@"<br>"];
    if (rangeSay.location != NSNotFound) {
        NSMutableString *temSay = [_replyModel.say mutableCopy];
        [temSay replaceOccurrencesOfString:@"<br>" withString:@"\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, temSay.length)];
        self.saylable.text = temSay;
    }
    self.supportLable.text = _replyModel.suppose;
}
@end
