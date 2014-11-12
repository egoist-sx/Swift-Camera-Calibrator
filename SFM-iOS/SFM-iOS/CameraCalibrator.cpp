//
//  CameraCalibrator.cpp
//  SFM-iOS
//
//  Created by Xin Sun on 11/11/14.
//  Copyright (c) 2014 Xin Sun. All rights reserved.
//

#include "CameraCalibrator.h"

int CameraCalibrator::addChessboardPoints(vector<cv::Mat> &images, cv::Size &boardSize) {
    vector<cv::Point2f> imageCorners;
    vector<cv::Point3f> objectCorners;
    
    for (int i = 0; i < boardSize.height; i++) {
        for (int j = 0; j < boardSize.width; j++) {
            objectCorners.push_back(cv::Point3f(i, j, 0));
        }
    }
    
    int success = 0;
    for (int i = 0; i < images.size(); i++) {
        
        cv::Mat image = images[i];
        cv::Mat grayImage;
        cv::cvtColor(image, grayImage, CV_RGB2GRAY);
        cout << "finding chessboard corners" << endl;
        cv::findChessboardCorners(grayImage, boardSize, imageCorners);
        
        cout << "finding corners subpix" << endl;
        cv::cornerSubPix(grayImage, imageCorners, cv::Size(5,5), cv::Size(-1,-1), cv::TermCriteria(cv::TermCriteria::MAX_ITER+cv::TermCriteria::EPS,30,0.1));
        
        if (imageCorners.size() == boardSize.area()) {
            addPoints(imageCorners, objectCorners);
            success++;
        }
        
    }
    cout << "Done finding corners, success: " << success << endl;
    return success;
}

void CameraCalibrator::addPoints(const vector<cv::Point2f> &imageCorners, const vector<cv::Point3f> &objectCorners) {
    imagePoints.push_back(imageCorners);
    objectPoints.push_back(objectCorners);
}

double CameraCalibrator::calibrate(cv::Size &imageSize) {
    
    cout << "Start calibration" << endl;
    
    mustInitUndistort = true;
    vector<cv::Mat> rvecs, tvects;
    return cv::calibrateCamera(objectPoints, imagePoints, imageSize, cameraMatrix, distCoeffs, rvecs, tvects,flag);
}

void CameraCalibrator::getCameraMatrixAndDistCoeffMatrix(cv::Mat &outputCameraMatrix, cv::Mat &outputDistCoeffMatrix) {
    outputCameraMatrix = cameraMatrix;
    outputDistCoeffMatrix = distCoeffs;
}