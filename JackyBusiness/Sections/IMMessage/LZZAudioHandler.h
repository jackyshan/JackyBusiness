//
//  LZZAudioHandler.h
//  YSBPro
//
//  Created by lu lucas on 20/3/15.
//  Copyright (c) 2015 lu lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LZZAudioHandlerDelegate;

@interface LZZAudioHandler : NSObject

{
    __weak id<LZZAudioHandlerDelegate> _delegate;
}
@property (nonatomic, weak) id<LZZAudioHandlerDelegate> delegate;

- (void)startRecordAudio;
- (void)stopRecordAudio;

- (void)playAudioAtUrl:(NSURL *)url;
- (void)stopPlayAudio;

- (float)peakPower;

@end

@protocol LZZAudioHandlerDelegate <NSObject>

- (void)onAudioFinishRecord:(NSURL *)filePath;

@end