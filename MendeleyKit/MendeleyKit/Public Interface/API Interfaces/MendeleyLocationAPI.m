//
//  MendeleyLocationAPI.m
//  MendeleyKit
//
//  Created by Schmidt, Peter (ELS) on 29/02/2016.
//  Copyright © 2016 Mendeley. All rights reserved.
//

#import "MendeleyLocationAPI.h"
#import "MendeleyLocation.h"
#import "MendeleyKitConfiguration.h"
#import "NSDictionary+Merge.h"
#import "NSError+Exceptions.h"

@implementation MendeleyLocationAPI
- (NSDictionary *)defaultServiceRequestHeaders
{
    return @{ kMendeleyRESTRequestAccept: kMendeleyRESTRequestJSONLocationType };
}

- (NSDictionary *)developmentServiceRequestHeadersWithToken:(NSString* )developmentToken
{
    return @{ kMendeleyRESTRequestDevelopmentToken: developmentToken };
}


#warning this is a v2 API BETA method - DO NOT USE IN PRODUCTION
- (void)locationsWithLinkedURL:(NSURL *)linkURL
              developmentToken:(NSString *)developmentToken
                          task:(MendeleyTask *)task
               completionBlock:(MendeleyArrayCompletionBlock)completionBlock
{
    [NSError assertArgumentNotNil:linkURL argumentName:@"linkURL"];
    [NSError assertArgumentNotNil:completionBlock argumentName:@"completionBlock"];

    NSMutableDictionary *header = [NSMutableDictionary dictionaryWithDictionary:[self defaultServiceRequestHeaders]];
    if (nil != developmentToken)
    {
        [header addEntriesFromDictionary:[self developmentServiceRequestHeadersWithToken:developmentToken]];
    }

    [self.provider invokeGET:linkURL
                         api:nil
           additionalHeaders:header
             queryParameters:nil       // we don't need to specify parameters because are inehrits from the previous call
      authenticationRequired:YES
                        task:task
             completionBlock: ^(MendeleyResponse *response, NSError *error) {
                 MendeleyBlockExecutor *blockExec = [[MendeleyBlockExecutor alloc] initWithArrayCompletionBlock:completionBlock];
                 if (![self.helper isSuccessForResponse:response error:&error])
                 {
                     [blockExec executeWithArray:nil
                                        syncInfo:nil
                                           error:error];
                 }
                 else
                 {
                     MendeleyModeller *jsonModeller = [MendeleyModeller sharedInstance];
                     [jsonModeller parseJSONData:response.responseBody
                                    expectedType:kMendeleyModelLocation
                                 completionBlock: ^(NSArray *locations, NSError *parseError) {
                                     if (nil != parseError)
                                     {
                                         [blockExec executeWithArray:nil
                                                            syncInfo:nil
                                                               error:parseError];
                                     }
                                     else
                                     {
                                         [blockExec executeWithArray:locations
                                                            syncInfo:response.syncHeader
                                                               error:nil];
                                     }
                                 }];
                 }
             }];

    
}

/**
 obtains a list of locations for the first page.
 @param parameters the parameter set to be used in the request
 @param task
 @param completionBlock
 */
#warning this is a v2 API BETA method - DO NOT USE IN PRODUCTION
- (void)locationsWithQueryParameters:(MendeleyLocationParameters *)queryParameters
                    developmentToken:(NSString *)developmentToken
                                task:(MendeleyTask *)task
                     completionBlock:(MendeleyArrayCompletionBlock)completionBlock
{
    NSDictionary *query = [queryParameters valueStringDictionary];
    NSDictionary *mergedQuery = [NSDictionary dictionaryByMerging:query with:[[MendeleyQueryRequestParameters alloc] valueStringDictionary]];
    NSMutableDictionary *header = [NSMutableDictionary dictionaryWithDictionary:[self defaultServiceRequestHeaders]];
    if (nil != developmentToken)
    {
        [header addEntriesFromDictionary:[self developmentServiceRequestHeadersWithToken:developmentToken]];
    }
    
    [self.helper mendeleyObjectListOfType:kMendeleyModelLocation
                                      api:kMendeleyRESTAPILocations
                               parameters:mergedQuery
                        additionalHeaders:header
                                     task:task
                          completionBlock:completionBlock];
}
@end
