//
//  CameraCalibrator.h
//  SFM-iOS
//
//  Created by Xin Sun on 11/11/14.
//  Copyright (c) 2014 Xin Sun. All rights reserved.
//

#include <stdio.h>
#include <opencv2/opencv.hpp>

using namespace std;

class CameraCalibrator {

public:
    CameraCalibrator() : flag(0), mustInitUndistort(true) {};
    int addChessboardPoints(vector<cv::Mat> &images, cv::Size &boardSize);
    void getCameraMatrixAndDistCoeffMatrix(cv::Mat &outputCameraMatrix, cv::Mat &outputDistCoeffMatrix);
    double calibrate(cv::Size &imageSize);
    
private:
    vector<vector<cv::Point3f>> objectPoints;
    vector<vector<cv::Point2f>> imagePoints;
    cv::Mat cameraMatrix;
    cv::Mat distCoeffs;
    int flag;
    cv::Mat map1, map2;
    bool mustInitUndistort;
    void addPoints(const vector<cv::Point2f> &imageCorners, const vector<cv::Point3f> &objectCorners);
};