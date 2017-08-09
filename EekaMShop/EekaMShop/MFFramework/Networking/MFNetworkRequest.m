//
//  MFNetworkRequest.m
//  YJCustom
//
//  Created by EEKA on 16/9/27.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MFNetworkRequest.h"
#import "MFNetWorkAgent.h"
#import "MShopLoginService.h"

#ifdef DEBUG
#define MFAppLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define MFAppLog(s, ... )
#endif

@implementation MFNetworkRequest

-(void)requestCompleteFilter
{
#ifdef DEBUG
    
    [[self class] logWithSuccessResponse:self.responseData url:self.baseUrl params:self.requestArgument];
    
#else

#endif
    
}

-(BOOL)useToken
{
    return YES;
}

-(id)requestArgumentWithToken
{
    return nil;
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    if ([self useToken])
    {
        MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
        NSString *token = [loginService getCurrentLoginToken];
        if (![MFStringUtil isBlankString:token]) {
            [requestArgument setObject:token forKey:@"token"];
        }
        
        if ([self requestArgumentWithToken]) {
            [requestArgument addEntriesFromDictionary:[self requestArgumentWithToken]];
        }
    }
    
    return requestArgument;
}

-(void)setCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure
{
    __weak __typeof(self) weakSelf = self;
    
    [super setCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        __strong __typeof(self) strongSelf = weakSelf;
        if ([strongSelf tokenExpire]) {
            
            MFNetWorkAgent *netWorkAgent = [[MMServiceCenter defaultCenter] getService:[MFNetWorkAgent class]];
            [netWorkAgent handleTokenExpire];
            return;
        }
        
        success(request);
        
    } failure:failure];
}

+ (void)logWithSuccessResponse:(id)response url:(NSString *)url params:(NSDictionary *)params {
    MFAppLog(@"\n");
    MFAppLog(@"\nRequest success, URL: %@\n params:%@\n response:%@\n\n",
              [self generateGETAbsoluteURL:url params:params],
              params,
              [self tryToParseData:response]);
}

+ (id)tryToParseData:(id)responseData {
    if ([responseData isKindOfClass:[NSData class]]) {
        // 尝试解析成JSON
        if (responseData == nil) {
            return responseData;
        } else {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&error];
            
            if (error != nil) {
                return responseData;
            } else {
                return response;
            }
        }
    } else {
        return responseData;
    }
}


// 仅对一级字典结构起作用
+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(id)params {
    if (params == nil || ![params isKindOfClass:[NSDictionary class]] || [params count] == 0) {
        return url;
    }
    
    NSString *queries = @"";
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            continue;
        } else if ([value isKindOfClass:[NSArray class]]) {
            continue;
        } else if ([value isKindOfClass:[NSSet class]]) {
            continue;
        } else {
            queries = [NSString stringWithFormat:@"%@%@=%@&",
                       (queries.length == 0 ? @"&" : queries),
                       key,
                       value];
        }
    }
    
    if (queries.length > 1) {
        queries = [queries substringToIndex:queries.length - 1];
    }
    
    if (([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) && queries.length > 1) {
        if ([url rangeOfString:@"?"].location != NSNotFound
            || [url rangeOfString:@"#"].location != NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@", url, queries];
        } else {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@", url, queries];
        }
    }
    
    return url.length == 0 ? queries : url;
}

-(void)requestFailedFilter
{
#ifdef DEBUG
    
    [[self class] logWithFailError:self.error url:self.baseUrl params:self.requestArgument];
    
#else
    
#endif
}

+ (void)logWithFailError:(NSError *)error url:(NSString *)url params:(id)params {
    NSString *format = @" params: ";
    if (params == nil || ![params isKindOfClass:[NSDictionary class]]) {
        format = @"";
        params = @"";
    }
    
    MFAppLog(@"\n");
    if ([error code] == NSURLErrorCancelled) {
        MFAppLog(@"\nRequest was canceled mannully, URL: %@ %@%@\n\n",
                  [self generateGETAbsoluteURL:url params:params],
                  format,
                  params);
    } else {
        MFAppLog(@"\nRequest error, URL: %@ %@%@\n errorInfos:%@\n\n",
                  [self generateGETAbsoluteURL:url params:params],
                  format,
                  params,
                  [error localizedDescription]);
    }
}

-(BOOL)messageSuccess
{
    if (![self.responseJSONObject isKindOfClass:[NSDictionary class]])
    {
        return YES;
    }
    
    NSDictionary *dict = self.responseJSONObject;
    NSNumber *number = dict[@"errcode"];
    if (number.intValue == 0)
    {
        return YES;
    }
    
    return NO;
}

-(BOOL)tokenExpire
{
    MFNetWorkAgent *netWorkAgent = [[MMServiceCenter defaultCenter] getService:[MFNetWorkAgent class]];
    return [netWorkAgent tokenExpire:self];
}

-(NSString*)errorMessage
{
    if (![self.responseJSONObject isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    
    NSDictionary *dict = self.responseJSONObject;
    id string = dict[@"errmsg"];
    if ([string isKindOfClass:[NSNull class]]) {
        string = @"服务器无错误描述";
    }
    
    return string;
}

@end
