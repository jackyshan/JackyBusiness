//
//  ARLocationWork.h
//  PrometAR


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM (NSInteger, LZZLocationErrorType) {
    LZZLocationErrorTypeOK = 0,
    LZZLocationErrorTypeNotAccess,
    LZZLocationErrorTypeError
};


@protocol LocationHelperDelegate;

@interface LocationServer : NSObject <CLLocationManagerDelegate>

{
    __weak id<LocationHelperDelegate> _delegate;
}

@property (nonatomic, assign) double currentLat;
@property (nonatomic, assign) double currentLon;
@property (nonatomic, weak) id<LocationHelperDelegate> delegate;



/**
 初始化
 
 @param dele 代理
 */
-(id)initWithDelegate:(id<LocationHelperDelegate>)dele;
/**
 停止定位、停止取方向、停止取pitch
 
 */
- (void)stop;
/**
 重新定位
 
 */
- (void)reloadLocation;


+ (CLLocationCoordinate2D)transformLocation:(CLLocationCoordinate2D)aLocation;

@end


@protocol LocationHelperDelegate <NSObject>

@optional

- (void)location:(LocationServer *)server gotPreciseEnoughLocationWithError:(LZZLocationErrorType)error;

@end
