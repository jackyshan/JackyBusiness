//
//  MGRecorder.m
//  TestAudioQueue
//
//  Created by wawebi on 14-4-9.
//  Copyright (c) 2014年 wawebi. All rights reserved.
//

#import "MGRecorder.h"
#import "NSString+MKNetworkKitAdditions.h"

#if !__has_feature(objc_arc)
#error no "objc_arc" compiler flag
#endif

@interface MGRecorder ()

- (void) processAudioBuffer:(AudioQueueBufferRef)buffer
                  withQueue:(AudioQueueRef)queue;

@end

@implementation MGRecorder

@synthesize aqc, fileHandle;

//回调函数(每录制好一个buffer，系统会回调该函数。创建录音器的时候，需将该函数指针作为参数传入)
static void AQInputCallback (void                   *inUserData,
                             AudioQueueRef          inAudioQueue,
                             AudioQueueBufferRef    inBuffer,
                             const AudioTimeStamp   *inStartTime,
                             unsigned long          inNumPackets,
                             const AudioStreamPacketDescription *inPacketDesc)
{
    MGRecorder *engine = (__bridge MGRecorder *)inUserData;

    if (inNumPackets > 0)
    {
        [engine processAudioBuffer:inBuffer
                         withQueue:inAudioQueue];
    }

    AudioQueueEnqueueBuffer(engine.aqc.queue,
                            inBuffer,
                            0,
                            NULL);
}

- (id) initWithDele:(id)dele {
    self = [super init];

    if (self) {
        
        delegate = dele;

        //设置录音格式
        aqc.mDataFormat.mFormatID = kAudioFormatLinearPCM;
        aqc.mDataFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
        aqc.mDataFormat.mSampleRate = 12000.0;
        aqc.mDataFormat.mChannelsPerFrame = 1;
        aqc.mDataFormat.mFramesPerPacket = 1;
        aqc.mDataFormat.mBitsPerChannel = 16;
        aqc.mDataFormat.mBytesPerFrame  = (aqc.mDataFormat.mBitsPerChannel / 8) * aqc.mDataFormat.mChannelsPerFrame;
        aqc.mDataFormat.mBytesPerPacket = aqc.mDataFormat.mBytesPerFrame * aqc.mDataFormat.mFramesPerPacket;

        //计算每个缓冲区的尺寸
        int frames = (int)ceil(0.5 * aqc.mDataFormat.mSampleRate);
		aqc.bufferSize = frames * aqc.mDataFormat.mBytesPerFrame;

        aqc.queue = nil;
    }

    return self;
}

- (BOOL) start
{
    [self stop];
    NSString *fileName = [NSString stringWithFormat:@"%.0f.mp3", [NSDate date].timeIntervalSince1970 * 1000];
    strFilePath = [[CommonHelper mediaCacheDirectory] URLByAppendingPathComponent:[fileName md5]];
    [[NSFileManager defaultManager] createFileAtPath:strFilePath.path contents:nil attributes:nil];

    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:strFilePath.path];
    iFileSize = 0;

    //初始化压缩器
    lame = lame_init();
    lame_set_num_channels(lame, 1); // 单声道／立体声
    lame_set_in_samplerate(lame, 12000.0);// 16K采样率
    lame_set_brate(lame, 128);// 压缩的比特率为128K
    lame_set_mode(lame, 3);
    lame_set_quality(lame, 5);
    lame_init_params(lame);

    //创建新的音频队列
    int status = AudioQueueNewInput(&aqc.mDataFormat,
                                    AQInputCallback,
                                    (__bridge void *)self,
                                    NULL,
                                    kCFRunLoopCommonModes,
                                    0,
                                    &aqc.queue);
    NSLog(@"AudioQueueStart = %d", status);

    if (status != 0)
    {
        lame_close(lame);
        [fileHandle closeFile];
        return NO;
    }

    //分配缓冲区并排队
    for (int i=0;i<kNumberBuffers;i++)
    {
        AudioQueueAllocateBuffer(aqc.queue,
                                 aqc.bufferSize,
                                 &aqc.mBuffers[i]);
        AudioQueueEnqueueBuffer(aqc.queue,
                                aqc.mBuffers[i],
                                0,
                                NULL);
    }

    //开始录制
    aqc.run = 1;
    status = AudioQueueStart(aqc.queue, NULL);
    NSLog(@"AudioQueueStart = %d", status);

    if (status != 0)
    {
        aqc.run = 0;
        lame_close(lame);
        [fileHandle closeFile];

        AudioQueueDispose(aqc.queue, false);
        for (int i = 0; i < kNumberBuffers ; i++)
        {
            aqc.mBuffers[i] = NULL;
        }
        aqc.queue = nil;

        return NO;
    }

    //监听音量
    if (levels != NULL)
    {
        free(levels);
        levels = NULL;
    }
    levels = (AudioQueueLevelMeterState *)calloc(aqc.mDataFormat.mChannelsPerFrame, sizeof(AudioQueueLevelMeterState));
    UInt32 trueValue = true;
    AudioQueueSetProperty(aqc.queue, kAudioQueueProperty_EnableLevelMetering, &trueValue, sizeof(UInt32));

    //向上层报告
    if ([delegate respondsToSelector:@selector(onAudioStartRecord:)])
    {
        [delegate onAudioStartRecord:strFilePath.path];
    }

    return YES;
}

- (void) stop
{
    if (aqc.run == 0)
    {
        return;
    }

    AudioQueueStop(aqc.queue, true);
    AudioQueueDispose(aqc.queue, false);
    aqc.run = 0;
    aqc.queue = nil;

    for (int i = 0; i < kNumberBuffers ; i++)
    {
        aqc.mBuffers[i] = NULL;
    }

    //释放监听内存
    if (levels != NULL)
    {
        free(levels);
        levels = NULL;
    }

    lame_close(lame);
    [fileHandle closeFile];

    if ([delegate respondsToSelector:@selector(onAudioEndRecord:)])
    {
        [delegate onAudioEndRecord:strFilePath];
    }
}

- (void) pause
{
    AudioQueuePause(aqc.queue);
    aqc.run = 0;
}

- (void) resume
{
    AudioQueueStart(aqc.queue, NULL);
    aqc.run = 1;
}

- (float) peakPower
{
    if (aqc.run != 1)
    {
        return 0;
    }

    UInt32 ioDataSize = aqc.mDataFormat.mChannelsPerFrame * sizeof(AudioQueueLevelMeterState);
	AudioQueueGetProperty(aqc.queue, (AudioQueuePropertyID)kAudioQueueProperty_CurrentLevelMeter, levels, &ioDataSize);

    return levels[0].mPeakPower;
}

- (void) processAudioBuffer:(AudioQueueBufferRef)buffer
                  withQueue:(AudioQueueRef)queue {
    //long size = buffer->mAudioDataByteSize / aqc.mDataFormat.mBytesPerPacket;
    short *recordingData = (short *)buffer->mAudioData;
    int   iPcmLen = buffer->mAudioDataByteSize;
    unsigned char bufMP3[iPcmLen];
    int recvLen = lame_encode_buffer(lame,
                                     recordingData,
                                     recordingData,
                                     iPcmLen/2,
                                     bufMP3,
                                     iPcmLen);
    if(fileHandle != nil && recvLen > 0)
    {
        NSData *data = [NSData dataWithBytes:bufMP3 length:recvLen];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        iFileSize += recvLen;

        //向上层报告
        if ([delegate respondsToSelector:@selector(onAudioDataFinished:filePath:)])
        {
            [delegate onAudioDataFinished:iFileSize filePath:strFilePath.path];
        }
    }
}

@end

