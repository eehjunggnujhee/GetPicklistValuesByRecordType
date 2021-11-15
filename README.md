# Retrieve picklist values of a Record Type using MetaData Service in Salesforce

We want the [Salesforce native Metadata API](https://ideas.salesforce.com/s/idea/a0B8W00000Gdm2SUAR/ability-to-update-metadata-from-apex-apex-metadata-api)! Retrieving picklist values of a record type wasn't an easy task! I wish it is as easy as using Schema class. That explains why there isn't a readly available free in-app that can help Salesforce administrators retrieve picklist values assigned to a record type (Let me know if you know any). I use apex-mdapi open source SOAP API wrapper to build the in-app Salesforce solution as needed. This is strictly a personal project intended for expansion of knowledge.


## Pre-Reployment Configuration: Set up Authentication to Own Org
The package requires the following pre-deployment configuration described below:

>> [Original Post](https://www.gscloudsolutions.com/blogpost/Using-Named-Credentials-with-the-Apex-Wrapper-Salesforce-Metadata-API-apex-mdapi?blogpost=true&utm_source=twitter&utm_medium=social&utm_campaign=named_credentials) 

>> [Image References](assets)

1. Set up a Connected App
2. Set up an Auth-Provider
3. Set up a Naming Credential

## Authenticate into Your Own Org
Once the pre-deployment Configuration and source deployment is done, open up the Naming Credential and click Edit and Save. The page redirects to login page for the authentication into the org.

### Credits and Resources

1. FinancialForce [apex-mdapi](https://github.com/financialforcedev/apex-mdapi/tree/master/apex-mdapi/src/classes)
2. ForceTalk [Parul Singh](https://www.forcetalks.com/blog/retrieve-picklist-value-of-a-record-type-using-metadata-service-in-salesforce/)

### DESCLAIMER 
This is strictly a personal project intended for expansion of knowledge. Please read below for license details on the `apex-mdapi` open source project.
```
/**
 * Copyright (c), FinancialForce.com, inc
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
```


