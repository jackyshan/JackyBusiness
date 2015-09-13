//
//  MGRecorder.h
//  TestAudioQueue
//
//  Created by wawebi on 14-4-9.
//  Copyright (c) 2014年 wawebi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreAudio/CoreAudioTypes.h>
#include "lame.h"

@protocol MGRecorderDelegate

@optional
- (void) onAudioStartRecord:(NSString*)filePath; //已开始录制（file：文件路径）
- (void) onAudioDataFinished:(int)len
                    filePath:(NSString *)filePath; //已录制的文件尺寸
- (void) onAudioEndRecord:(NSURL *)filePath; //已结束录制

@end


#define kNumberBuffers      (3)

typedef struct AQCallbackStruct {
    AudioStreamBasicDescription mDataFormat;
    AudioQueueRef               queue;
    AudioQueueBufferRef         mBuffers[kNumberBuffers];
    unsigned int                bufferSize;
    int                         run;
} AQCallbackStruct;


@interface MGRecorder : NSObject {
    __unsafe_unretained id delegate;
    AQCallbackStruct aqc;
    AudioFileTypeID fileFormat;
    AudioQueueLevelMeterState *levels;
    
    lame_t lame;               //压缩器句柄
    NSURL *strFilePath;     //录制好的mp3文件路径
    NSFileHandle *fileHandle;  //mp3文件保存句柄
    int  iFileSize;            //已录制文件尺寸
}

- (id) initWithDele:(id)dele;
- (BOOL) start;
- (void) stop;
- (void) pause;
- (void) resume;
- (float) peakPower;

@property (nonatomic, assign) AQCallbackStruct aqc;
@property (nonatomic, retain) NSFileHandle *fileHandle;

@end

