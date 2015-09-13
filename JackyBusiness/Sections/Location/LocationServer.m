//
//  ARLocationWork.m
//  PrometAR
//


#import "LocationServer.h"
#import "ARGPSCoord.h"

#define MAX_NUMBER_OF_TRIES             8               // 尝试定位到足够精确坐标的最大尝试次数
#define MIN_LOCATION_ACCURACY           100.0f          // 足够精确坐标的误差最大值

@interface LocationServer ()

{
    
    // 坐标管理器
    CLLocationManager *_locationManager;
    // 是否取到了足够精确的经纬度坐标
    BOOL _gotPreciseEnoughLocation;
    // 记录获取经纬度的尝试次数
    NSInteger _locationTries;
}

@end

@implementation LocationServer

- (void)dealloc
{
    
}

-(id)initWithDelegate:(id<LocationHelperDelegate>)dele
{
    self = [super init];
    if (self) {
        self.delegate = dele;
        
        // 置零
        [self _reset];
        // 配置管理器
        [self setupLocationManager];
        // 开始轮询
        [self checkGetEnoughLocation];
    }
    return self;
}

- (void)stop
{
    [self _reset];
    _locationManager.delegate = nil;
    _locationManager = nil;
}


// 刷新，重新定位
- (void)reloadLocation
{
    [self _reset];
    [_locationManager startUpdatingLocation];
    [self checkGetEnoughLocation];
}

- (void)_reset
{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkGetEnoughLocation) object:nil];
    
    [_locationManager stopUpdatingLocation];
    _gotPreciseEnoughLocation = NO;
    _locationTries = 0;
}


# pragma mark - LocationManager

-(void)setupLocationManager
{

    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    
    // 坐标
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 100.0f;
    if (bIOS8) {
        [_locationManager requestAlwaysAuthorization];
    }
    
    [_locationManager startUpdatingLocation];
    
}

// 轮询是否获得了足够精确的坐标（注：不过有时候即使返回的坐标，误差的属性很低，比如5米，实际上是定位到天涯海角了）
- (void)checkGetEnoughLocation
{
    if (_locationTries == MAX_NUMBER_OF_TRIES) {
        if (_delegate && [_delegate respondsToSelector:@selector(location:gotPreciseEnoughLocationWithError:)]) {
            [_delegate location:self gotPreciseEnoughLocationWithError:LZZLocationErrorTypeError];
        }
        
        [self _reset];
        
        
        
    } else {
        // 取不到足够精确的坐标，则尝试次数加1，继续轮询
        if (!_gotPreciseEnoughLocation) {
            _locationTries++;
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
            [self performSelector:@selector(checkGetEnoughLocation) withObject:nil afterDelay:0.5f];
        } else {
            
            
            // 有精确坐标之后才请求数据，因为要根据坐标画图
            if (_delegate && [_delegate respondsToSelector:@selector(location:gotPreciseEnoughLocationWithError:)]) {
                [_delegate location:self gotPreciseEnoughLocationWithError:LZZLocationErrorTypeOK];
            }
            
            [self _reset];
        }
    }
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    // 需要足够的精度
//    if (newLocation.horizontalAccuracy < MIN_LOCATION_ACCURACY
//        && newLocation.horizontalAccuracy > 0) {
    
        _gotPreciseEnoughLocation = YES;
        
        [self transformLocation:newLocation];
        
//    } else {
        NSLog(@"locationserver %f, %f", _currentLat, _currentLon);
//    }

}

//-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    
//    if (newLocation.horizontalAccuracy < MIN_LOCATION_ACCURACY
//        && newLocation.horizontalAccuracy > 0
//        && newLocation.verticalAccuracy < MIN_LOCATION_ACCURACY) {
//        
//        _gotPreciseEnoughLocation = YES;
//        
//        [self transformLocation:newLocation];
//        
//    }
//    
//}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    // 检测到没有开启手机的定位功能或者没有给搜房开定位权限
    if(![CLLocationManager locationServicesEnabled]
       || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        
        
        
        [self _reset];
        
        if (_delegate && [_delegate respondsToSelector:@selector(location:gotPreciseEnoughLocationWithError:)]) {
            [_delegate location:self gotPreciseEnoughLocationWithError:LZZLocationErrorTypeNotAccess];
        }
        
    }
}

// 坐标转换
- (void)transformLocation:(CLLocation *)aLocation
{
    // 用函数转换
    Location original = LocationMake(aLocation.coordinate.longitude, aLocation.coordinate.latitude);
    Location gcj = transformFromWGSToGCJ(original);
    Location bd = bd_encrypt(gcj);
    _currentLat = bd.lat;
    _currentLon = bd.lng;
}


+ (CLLocationCoordinate2D)transformLocation:(CLLocationCoordinate2D)aLocation
{
    // 用函数转换
    Location original = LocationMake(aLocation.longitude, aLocation.latitude);
    Location bd = bd_encrypt(original);
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(bd.lat, bd.lng);
    return coordinate;
}


@end
