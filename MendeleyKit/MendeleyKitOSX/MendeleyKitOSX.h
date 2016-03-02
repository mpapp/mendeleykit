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
@import Foundation;
@import AppKit;

//! Project version number for MendeleyKitOSX.
FOUNDATION_EXPORT double MendeleyKitOSXVersionNumber;

//! Project version string for MendeleyKitOSX.
FOUNDATION_EXPORT const unsigned char MendeleyKitOSXVersionString[];

#import <MendeleyKitOSX/MendeleyGlobals.h>
#import <MendeleyKitOSX/MendeleyOAuthCredentials.h>
#import <MendeleyKitOSX/MendeleyCancellableRequest.h>
#import <MendeleyKitOSX/MendeleySimpleNetworkTask.h>
#import <MendeleyKitOSX/MendeleyOAuthTokenHelper.h>
#import <MendeleyKitOSX/MendeleyObject.h>
#import <MendeleyKitOSX/NSDictionary+Merge.h>
#import <MendeleyKitOSX/MendeleyDocumentType.h>
#import <MendeleyKitOSX/MendeleyQueryRequestParameters.h>
#import <MendeleyKitOSX/MendeleySimpleNetworkProvider.h>
#import <MendeleyKitOSX/MendeleyTimer.h>
#import <MendeleyKitOSX/MendeleyDataHelper.h>
#import <MendeleyKitOSX/MendeleyNetworkProvider.h>
#import <MendeleyKitOSX/MendeleyKitHelper.h>
#import <MendeleyKitOSX/MendeleyKit.h>
#import <MendeleyKitOSX/MendeleyCatalogDocument.h>
#import <MendeleyKitOSX/MendeleyIdentifierType.h>
#import <MendeleyKitOSX/MendeleyAnnotation.h>
#import <MendeleyKitOSX/MendeleyDocument.h>
#import <MendeleyKitOSX/MendeleyLoginWindowController.h>
#import <MendeleyKitOSX/MendeleyDownloadHelper.h>
#import <MendeleyKitOSX/MendeleyGroup.h>
#import <MendeleyKitOSX/MendeleyDefaultNetworkProvider.h>
#import <MendeleyKitOSX/MendeleyConnectionReachability.h>
#import <MendeleyKitOSX/MendeleyFolder.h>
#import <MendeleyKitOSX/MendeleyError.h>
#import <MendeleyKitOSX/MendeleyMetadataLookup.h>
#import <MendeleyKitOSX/MendeleyReachability.h>
#import <MendeleyKitOSX/MendeleyPerson.h>
#import <MendeleyKitOSX/MendeleyModeller.h>
#import <MendeleyKitOSX/MendeleyResponse.h>
#import <MendeleyKitOSX/MendeleyProfile.h>
#import <MendeleyKitOSX/MendeleyAcademicStatus.h>
#import <MendeleyKitOSX/MendeleyModels.h>
#import <MendeleyKitOSX/MendeleyKitUserInfoManager.h>
#import <MendeleyKitOSX/MendeleyLog.h>
#import <MendeleyKitOSX/MendeleyPerformanceMeter.h>
#import <MendeleyKitOSX/MendeleySyncInfo.h>
#import <MendeleyKitOSX/MendeleyNetworkTask.h>
#import <MendeleyKitOSX/MendeleyTask.h>
#import <MendeleyKitOSX/MendeleyOAuthStore.h>
#import <MendeleyKitOSX/MendeleyURLBuilder.h>
#import <MendeleyKitOSX/NSMutableArray+MaximumSize.h>
#import <MendeleyKitOSX/MendeleyUploadHelper.h>
#import <MendeleyKitOSX/MendeleyKitConfiguration.h>
#import <MendeleyKitOSX/MendeleyBlockExecutor.h>
#import <MendeleyKitOSX/MendeleyRequest.h>
#import <MendeleyKitOSX/MendeleyErrorManager.h>
#import <MendeleyKitOSX/MendeleyFollow.h>
#import <MendeleyKitOSX/MendeleyPerformanceMeterSession.h>
#import <MendeleyKitOSX/NSError+MendeleyError.h>
#import <MendeleyKitOSX/MendeleyFile.h>
#import <MendeleyKitOSX/NSError+Exceptions.h>
#import <MendeleyKitOSX/MendeleyTaskProvider.h>
#import <MendeleyKitOSX/MendeleyOAuthProvider.h>
#import <MendeleyKitOSX/MendeleyOAuthConstants.h>
#import <MendeleyKitOSX/MendeleyObjectHelper.h>
#import <MendeleyKitOSX/MendeleyUserRole.h>
#import <MendeleyKitOSX/MendeleyLocation.h>
#import <MendeleyKitOSX/MendeleyDisciplinesAPI.h>
#import <MendeleyKitOSX/MendeleyGroupsAPI.h>
#import <MendeleyKitOSX/MendeleyDefaultOAuthProvider.h>
#import <MendeleyKitOSX/MendeleyNSURLRequestDownloadHelper.h>
#import <MendeleyKitOSX/MendeleyNSURLRequestHelper.h>
#import <MendeleyKitOSX/MendeleyFoldersAPI.h>
#import <MendeleyKitOSX/MendeleyFollowersAPI.h>
#import <MendeleyKitOSX/MendeleyAcademicStatusesAPI.h>
#import <MendeleyKitOSX/MendeleyMetadataAPI.h>
#import <MendeleyKitOSX/MendeleyFilesAPI.h>
#import <MendeleyKitOSX/MendeleyObjectAPI.h>
#import <MendeleyKitOSX/MendeleyProfilesAPI.h>
#import <MendeleyKitOSX/MendeleyAnnotationsAPI.h>
#import <MendeleyKitOSX/MendeleyDocumentsAPI.h>
#import <MendeleyKitOSX/MendeleyLocationAPI.h>
#import <MendeleyKitOSX/MendeleyNSURLRequestUploadHelper.h>
#import <MendeleyKitOSX/MendeleyNSURLConnectionProvider.h>
#import <MendeleyKitOSX/MendeleyAnalyticsRegistry.h>
