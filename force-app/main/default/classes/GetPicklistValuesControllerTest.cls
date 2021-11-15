@isTest
public class GetPicklistValuesControllerTest {
    @isTest
    static void getRecordTypeTest() {

        Test.StartTest(); 
        PageReference pageRef = Page.GetPicklistValues;
       
        pageRef.getParameters().put('selectedObj', 'Account');
        pageRef.getParameters().put('selectedRT', 'Organization');
        pageRef.getParameters().put('selectedPList', 'Industry'); 
        Test.setCurrentPage(pageRef);


        GetPicklistValuesController ctr = new GetPicklistValuesController();
        ctr.selectedObj = 'Account';
        ctr.selectedRT  = 'Organization';
        ctr.selectedPList = 'Industry';

        ctr.getRecordType();
        ctr.getPicklistValues();
        
        Test.StopTest(); 

    }
    @IsTest static void testGetDependentPicklistValuesByRecordType()
    {	
        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();
        // Invoke operations     
        Test.startTest(); 
        List<String> results = MetadataServiceExamples.getDependentPicklistValuesByRecordType('Account', 'Organization', 'Industry');
        Test.stopTest();

        System.assert(results == new List<String>{'Education'});
    }

    @IsTest
	private static void testCreateService()
	{	
    	// Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();
        // Invoke operations     
        Test.startTest();    
        MetadataService.MetadataPort mmp = MetadataServiceExamples.createService();
        Test.stopTest();
	}


    class WebServiceMockImpl implements WebServiceMock {
        public void doInvoke(
                Object stub, Object request, Map<String, Object> response,
                String endpoint, String soapAction, String requestName,
                String responseNS, String responseName, String responseType){
            // using the variables you saved in the constructor as input, 
            // return values in the arguments to this method in response
                if(request instanceof MetadataService.readMetadata_element){
                    MetadataService.readMetadata_element requestReadMetadata_element  = 
                        (MetadataService.readMetadata_element) request;
                    if (requestReadMetadata_element.type_x == 'RecordType') { 
                    
                        MetadataService.RecordType[] mrt = new 
                        List<MetadataService.RecordType>();
                        MetadataService.RecordType mockLabel = new MetadataService.RecordType();

                        MetadataService.RecordTypePicklistValue mrypv = new MetadataService.RecordTypePicklistValue();
                        MetadataService.PicklistValue mpv = new MetadataService.PicklistValue();
                        mpv.fullName = 'Education';

                        mrypv.picklist = 'Industry';
                        mrypv.Values = new List<MetadataService.PicklistValue>{mpv};
                        mockLabel.fullname = 'Account.Organization';
                        
                        mockLabel.picklistValues = new List<MetadataService.RecordTypePicklistValue>{mrypv};
                        mrt.add(mockLabel);
                        // do more labels
                        MetadataService.readRecordTypeResponse_element mockRes  = new  
                        MetadataService.readRecordTypeResponse_element();
                        mockRes.result           = new MetaDataService.ReadRecordTypeResult();
                        mockRes.result.records   = mrt;
                        response.put('response_x', mockRes);
                }
            }
        }
    }

}
