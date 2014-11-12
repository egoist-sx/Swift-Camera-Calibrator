#Swift Camera Calibrator

This project contains working camera calibrator for iPhone iOS 8.1 written in swift.

You should specify the number of images to be used for calibration in CalibrationViewController.

You must change chessboard size to be same as the one you used during capturing, in CVWrapper.mm file

Whenever the amount of image required are obtained, please do not click capture again, and just wait for result in console.

You could either just clone the whole repo(include OpenCV) or just necessary part, and link OpenCV framework manually.

If there is error during runtime shows that could not find enough point for subPix function. There are two possible sources of error:

1. Boardsize size specified in CVWrapper.mm is probabily wrong. 
2. Please use chessboard with white background, pattern on ipad might not work, as board of ipad could be confusing for algorithms.

Source of inspiration: 

1. https://github.com/foundry/OpenCVSwiftStitch
2. https://www.packtpub.com/books/content/opencv-estimating-projective-relations-images

