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

import Foundation

public class MendeleyDefaultAnalytics: NSObject, MendeleyAnalytics
{
    var cacheManager = MendeleyAnalyticsCacheManager()
    public var versionString = String()
    public var identityString = String()
    public var profileUUID = String()
    
    public class var sharedInstance : MendeleyDefaultAnalytics
    {
        struct Static
        {
            static let instance : MendeleyDefaultAnalytics = MendeleyDefaultAnalytics()
        }
        return Static.instance
    }
    
    public func configureMendeleyAnalytics(profileID: String, clientVersionString: String, clientIdentityString: String)
    {
        profileUUID = profileID
        versionString = clientVersionString
        identityString = clientIdentityString
    }
    
    public func configureMendeleyAnalytics(profileID: String, clientVersionString: String, clientIdentityString: String, batchSize: Int)
    {
        profileUUID = profileID
        versionString = clientVersionString
        identityString = clientIdentityString
        cacheManager.preferredBatchSize = batchSize
    }
    
    
    public func logMendeleyAnalyticsEvent(name: String)
    {
        let event = MendeleyAnalyticsEvent()
        event.name = name
        
        if versionString.characters.count == 0 || identityString.characters.count == 0 || profileUUID.characters.count == 0
        {
            return
        }
        
        event.origin[kMendeleyAnalyticsJSONOriginVersion] = versionString
        event.origin[kMendeleyAnalyticsJSONOriginIdentity] = identityString
        event.profile_uuid = profileUUID
        cacheManager.addMendeleyAnalyticsEvent(event: event)
    }
    
    
    public func logMendeleyAnalyticsEvents(events:[MendeleyAnalyticsEvent])
    {
        if versionString.characters.count == 0 || identityString.characters.count == 0 || profileUUID.characters.count == 0
        {
            return
        }
        for event in events
        {
            event.origin[kMendeleyAnalyticsJSONOriginVersion] = versionString
            event.origin[kMendeleyAnalyticsJSONOriginIdentity] = identityString
            event.profile_uuid = profileUUID
        }
        cacheManager.addMendeleyAnalyticsEvents(events: events)
    }
    
    
    public func dispatchMendeleyAnalyticsEvents(completionHandler: MendeleyCompletionBlock?)
    {
        cacheManager.sendAndClearAnalyticsEvents(completionHandler: completionHandler)
    }

}
