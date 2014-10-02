/*
 ******************************************************************************
 * Copyright (C) 2014-2017 Elsevier/Mendeley.
 *
 * This file is part of the Mendeley iOS SDK.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *****************************************************************************
 */

#import "MendeleyAnnotationsAPI.h"
#import "MendeleyModels.h"
#import "NSDictionary+Merge.h"

@implementation MendeleyAnnotationsAPI

#pragma mark Private methods

- (NSDictionary *)defaultServiceRequestHeaders
{
    return @{ kMendeleyRESTRequestAccept: kMendeleyRESTRequestJSONAnnotationType };
}

- (NSDictionary *)defaultUploadRequestHeaders
{
    return @{ kMendeleyRESTRequestAccept: kMendeleyRESTRequestJSONAnnotationType,
              kMendeleyRESTRequestContentType : kMendeleyRESTRequestJSONAnnotationType };
}

- (NSDictionary *)defaultQueryParameters
{
    return [[MendeleyAnnotationParameters new] valueStringDictionary];
}

#pragma mark -

- (void)annotationWithAnnotationID:(NSString *)annotationID
                   completionBlock:(MendeleyObjectCompletionBlock)completionBlock
{
    [NSError assertStringArgumentNotNilOrEmpty:annotationID argumentName:@"annotationID"];
    NSString *apiEndPoint = [NSString stringWithFormat:kMendeleyRESTAPIAnnotationWithID, annotationID];
    [self.helper mendeleyObjectOfType:kMendeleyModelAnnotation
                           parameters:nil
                                  api:apiEndPoint
                    additionalHeaders:[self defaultServiceRequestHeaders]
                      completionBlock:completionBlock];
}

- (void)deleteAnnotationWithID:(NSString *)annotationID
               completionBlock:(MendeleyCompletionBlock)completionBlock
{
    [NSError assertStringArgumentNotNilOrEmpty:annotationID argumentName:@"annotationID"];
    NSString *apiEndPoint = [NSString stringWithFormat:kMendeleyRESTAPIAnnotationWithID, annotationID];
    [self.helper deleteMendeleyObjectWithAPI:apiEndPoint
                             completionBlock:completionBlock];
}

- (void)updateAnnotation:(MendeleyAnnotation *)updatedMendeleyAnnotation
         completionBlock:(MendeleyObjectCompletionBlock)completionBlock
{
    [NSError assertArgumentNotNil:updatedMendeleyAnnotation argumentName:@"updatedMendeleyAnnotation"];
    NSString *apiEndpoint = [NSString stringWithFormat:kMendeleyRESTAPIAnnotationWithID, updatedMendeleyAnnotation.object_ID];
    [self.helper updateMendeleyObject:updatedMendeleyAnnotation
                                  api:apiEndpoint
                    additionalHeaders:[self defaultUploadRequestHeaders]
                         expectedType:kMendeleyModelAnnotation
                      completionBlock:completionBlock];
}

- (void)createAnnotation:(MendeleyAnnotation *)mendeleyAnnotation
         completionBlock:(MendeleyObjectCompletionBlock)completionBlock
{
    [self.helper createMendeleyObject:mendeleyAnnotation
                                  api:kMendeleyRESTAPIAnnotations
                    additionalHeaders:[self defaultUploadRequestHeaders]
                         expectedType:kMendeleyModelAnnotation
                      completionBlock:completionBlock];
}


- (void)annotationListWithLinkedURL:(NSURL *)linkURL
                    completionBlock:(MendeleyArrayCompletionBlock)completionBlock
{
    [NSError assertArgumentNotNil:linkURL argumentName:@"linkURL"];
    [NSError assertArgumentNotNil:completionBlock argumentName:@"completionBlock"];

    [self.provider invokeGET:linkURL
                         api:nil
           additionalHeaders:[self defaultServiceRequestHeaders]
             queryParameters:nil // we don't need to specify parameters because are inehrits from the previous call
      authenticationRequired:YES
             completionBlock: ^(MendeleyResponse *response, NSError *error) {
         MendeleyBlockExecutor *blockExec = [[MendeleyBlockExecutor alloc] initWithArrayCompletionBlock:completionBlock];
         if (![self.helper isSuccessForResponse:response error:&error])
         {
             [blockExec executeWithArray:nil syncInfo:nil error:error];
         }
         else
         {
             MendeleyModeller *jsonModeller = [MendeleyModeller sharedInstance];
             [jsonModeller parseJSONData:response.responseBody
                            expectedType:kMendeleyModelAnnotation
                         completionBlock: ^(NSArray *annotations, NSError *parseError) {
                  if (nil != parseError)
                  {
                      [blockExec executeWithArray:nil
                                         syncInfo:nil
                                            error:parseError];
                  }
                  else
                  {
                      [blockExec executeWithArray:annotations
                                         syncInfo:response.syncHeader
                                            error:nil];
                  }
              }];
         }
     }];
}


- (void)annotationListWithQueryParameters:(MendeleyAnnotationParameters *)queryParameters
                          completionBlock:(MendeleyArrayCompletionBlock)completionBlock
{
    NSDictionary *query = [queryParameters valueStringDictionary];

    [self.helper mendeleyObjectListOfType:kMendeleyModelAnnotation
                                      api:kMendeleyRESTAPIAnnotations
                               parameters:[NSDictionary dictionaryByMerging:query with:[self defaultQueryParameters]]
                        additionalHeaders:[self defaultServiceRequestHeaders]
                          completionBlock:completionBlock];
}
@end