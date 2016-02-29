//
//  MendeleyLocationAPI.h
//  MendeleyKit
//
//  Created by Schmidt, Peter (ELS) on 29/02/2016.
//  Copyright © 2016 Mendeley. All rights reserved.
//

#import <MendeleyKitOSX/MendeleyKitOSX.h>

@interface MendeleyLocationAPI : MendeleyObjectAPI
/**
 @name MendeleyLocationAPI v2 API model
 the methods can only be used in development as the API is in BETA
 */

/**
 This method is only used when paging through a list of locations on the server.
 All required parameters are provided in the linkURL, which should not be modified
 
 @param linkURL the full HTTP link to the locations listings page
 @param task
 @param completionBlock
 */
#warning this is a v2 API BETA method - DO NOT USE IN PRODUCTION
- (void)locationsWithLinkedURL:(NSURL *)linkURL
              developmentToken:(NSString *)developmentToken
                          task:(MendeleyTask *)task
               completionBlock:(MendeleyArrayCompletionBlock)completionBlock;

/**
 obtains a list of locations for the first page.
 @param parameters the parameter set to be used in the request
 @param task
 @param completionBlock
 */
#warning this is a v2 API BETA method - DO NOT USE IN PRODUCTION
- (void)locationsWithQueryParameters:(MendeleyDocumentParameters *)queryParameters
                    developmentToken:(NSString *)developmentToken
                                task:(MendeleyTask *)task
                     completionBlock:(MendeleyArrayCompletionBlock)completionBlock;

@end
