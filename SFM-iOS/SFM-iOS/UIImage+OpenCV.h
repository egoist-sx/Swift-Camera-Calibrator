//
//  UIImage+OpenCV.h
//  SFM-iOS
//
//  Created by Xin Sun on 11/4/14.
//  Copyright (c) 2014 Xin Sun. All rights reserved.
//

#import <UIkit/UIKit.h>
#import <opencv2/opencv.hpp>

@interface UIImage (OpenCV)

//cv::Mat to UIImage
+ (UIImage *)imageWithCVMat:(const cv::Mat&)cvMat;
- (id)initWithCVMat:(const cv::Mat&)cvMat;

//UIImage to cv::Mat
- (cv::Mat)CVMat;
- (cv::Mat)CVMat3;
- (cv::Mat)CVGrayScaleMat;

@end
