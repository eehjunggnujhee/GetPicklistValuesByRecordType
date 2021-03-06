/**
 * Copyright (c) 2012, FinancialForce.com, inc
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice,
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice,
 *      this list of conditions and the following disclaimer in the documentation
 *      and/or other materials provided with the distribution.
 * - Neither the name of the FinancialForce.com, inc nor the names of its contributors
 *      may be used to endorse or promote products derived from this software without
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

/**
 * This file demonstrates how to call the Salesforce Metadata API from Apex
 *   for warnings, limits and further todos of this approach please review the readme
 *   at https://github.com/financialforcedev/apex-mdapi for more information
 **/

public with sharing class MetadataServiceExamples
{
    public static List<String> listofavailablevalue = new List<String>();
    public static List<String> getDependentPicklistValuesByRecordType(String objectName,String recordTypeName,String fieldName){
        String objectRecordType = objectName + '.' + recordTypeName;
        // Create service
        
            MetadataService.MetadataPort service = createService();
            MetadataService.RecordType recordType = (MetadataService.RecordType) service.readMetadata('RecordType', new String[] { objectRecordType }).getRecords()[0];
            for ( MetadataService.RecordTypePicklistValue rpk : recordType.picklistValues ) {
                if ( rpk.picklist == fieldName ) {
                    for ( MetadataService.PicklistValue pk : rpk.values ) {
                        listofavailablevalue.add(String.valueof(pk.fullName));
                    }
                }
            }
        return listofavailablevalue;
    }


    public class MetadataServiceExamplesException extends Exception { }

    public static MetadataService.MetadataPort createService()
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        // service.endpoint_x = 'callout:ApexMDAPI/services/Soap/m/42.0';
        service.SessionHeader = new MetadataService.SessionHeader_element();
        // service.SessionHeader.sessionId = UserInfo.getSessionId();
        service.SessionHeader.sessionId = '{!$Credential.OAuthToken}';
        return service;
    }
}