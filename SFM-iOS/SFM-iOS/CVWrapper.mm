//
//  CVWrapper.m
//  SFM-iOS
//
//  Created by Xin Sun on 11/5/14.
//  Copyright (c) 2014 Xin Sun. All rights reserved.
//

#import "CVWrapper.h"
#import "CameraCalibrator.h"
#import "UIImage+OpenCV.h"

@implementation CVWrapper

+ (void) calibrateWithImageArray:(NSArray *)images {
    CameraCalibrator* calibrator = new CameraCalibrator();
    std::vector<cv::Mat> imageVector;
    for (int i = 0; i < images.count; i++) {
        UIImage *image = images[i];
        cv::Mat imageMatrix = image.CVMat3;
        imageVector.push_back(imageMatrix);
        std::cout << "Loading image matrix: " << i << std::endl;
    }
    std::cout << "Done loading image matrix" << std::endl;
    cv::Size boardSize;
    //specifiy the board size - 1
    //for example, if you has a chessboard with 8*8 grid, put 7 for height and width here.
    boardSize.height = 7;
    boardSize.width = 7;
    calibrator->addChessboardPoints(imageVector, boardSize);
    cv::Size imageSize = imageVector[0].size();
    double error = calibrator->calibrate(imageSize);
    std::cout << "Done calibration, error: " << error << std::endl;
    
    cv::Mat cameraMatrix, distMatrix;
    calibrator->getCameraMatrixAndDistCoeffMatrix(cameraMatrix, distMatrix);
    cout << "Camera Matrix: \n" << cameraMatrix << endl << endl;
    cout << "Dist Matrix: \n" << distMatrix << endl << endl;
}

@end
