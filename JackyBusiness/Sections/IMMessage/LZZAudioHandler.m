//
//  LZZAudioHandler.m
//  YSBPro
//
//  Created by lu lucas on 20/3/15.
//  Copyright (c) 2015 lu lucas. All rights reserved.
//

#import "LZZAudioHandler.h"
#import "MGRecorder.h"
#import <AVFoundation/AVFoundation.h>

@interface LZZAudioHandler () <MGRecorderDelegate>

{
    
    MGRecorder *_recorder;
    AVAudioPlayer *_avPlayer;
}

@end

@implementation LZZAudioHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _recorder = [[MGRecorder alloc] initWithDele:self];
    }
    return self;
}

- (void)startRecordAudio
{
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
    [_recorder start];
}

- (void)stopRecordAudio
{
    [_recorder stop];
}

- (float)peakPower
{
    return [_recorder peakPower];
}

- (void)playAudioAtUrl:(NSURL *)url
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    _avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    NSLog(@"语音长度 %@", @(_avPlayer.duration));
    [_avPlayer prepareToPlay];
    [_avPlayer play];
}

- (void)stopPlayAudio
{
    [_avPlayer stop];
}

#pragma mark - mgrecorder delegate
- (void)onAudioEndRecord:(NSURL *)filePath
{
    if (_delegate && [_delegate respondsToSelector:@selector(onAudioFinishRecord:)]) {
        [_delegate onAudioFinishRecord:filePath];
    }
}

@end
