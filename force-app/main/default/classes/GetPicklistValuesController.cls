public class GetPicklistValuesController{
 
    public String selectedObj {get;set;} // selected Object Type
    public String selectedRT {get;set;} // selected Record Type
    public String selectedPList {get;set;} // selected Picklist Field
    public List<SelectOption> sObjectTypeList {get;set;}
    public List<SelectOption> recordTypeList {get;set;}
    public List<SelectOption> picklistList {get;set;}
    public List<String> listofValues{get;set;}
    
    List<Schema.SObjectType> gd{get;set;}
    
    public GetPicklistValuesController(){
        sObjectTypeList = new List<SelectOption>();
        recordTypeList = new List<SelectOption>();
        picklistList = new List<SelectOption>();
        getObjectTypeList();
     
    }

    public Pagereference getRecordType() {

        getRecordTypeList();
        getPickFields();
        return null;
     }

     public Pagereference getPicklistValues() {

        retrieveValue(selectedRT, selectedObj,selectedPList);
        return null;
     }
    
    public void getObjectTypeList() { // list objects at instatiation
        gd = Schema.getGlobalDescribe().Values();
        sObjectTypeList = new List<SelectOption>();
        for(Schema.SObjectType f : gd)
        {
            List<Schema.RecordTypeInfo> rtiList = f.getDescribe().getRecordTypeInfos();
            for(Schema.RecordTypeInfo rti : rtiList){                
                if(rti.getDeveloperName() != 'master'){
                    if(f.getdescribe().isSearchable() && f.getdescribe().isAccessible()){
                    sObjectTypeList.add(new SelectOption(f.getDescribe().getLabel(),f.getDescribe().getName()));
                    system.debug(f.getDescribe().getName());
                    break;
                    }
                }
            }
        } 
    }

    public void getRecordTypeList(){ // list record type based on selected object
        recordTypeList = new List<SelectOption>();  // clear the previously collected values
        List<RecordType> rtList = [SELECT Id,Name, DeveloperName FROM RecordType WHERE sObjectType= :selectedObj];
        recordTypeList.add(new SelectOption('--None--', '--None--'));
        for(RecordType rt : rtList)
        {
            recordTypeList.add(new SelectOption(rt.DeveloperName,rt.DeveloperName));
        }
        // return recordTypeList;
    }
     
    // get a list of picklist fields
	public void getPickFields(){
        picklistList = new List<SelectOption>(); // clear the previously collected values
        List<String> pickListFields = new List<String>();
        // get field api names
        String query = 'SELECT QualifiedApiName'
                        + ' FROM FieldDefinition WHERE EntityDefinitionId = \'' 
                        + selectedObj
                        +'\' ORDER BY Label ASC';
                        
        List<sObject> fieldDescribe = Database.query(query);
        Map<String,sObject> fieldNameObject = new Map<String,sObject>();

        for(sObject oneField : fieldDescribe) 
        {
            String fieldName = oneField.get('QualifiedApiName').toString();
            fieldNameObject.put(fieldName,oneField);
            system.debug(fieldNameObject);
        }

        sObjectType t = ((sObject)Type.forName('Schema',selectedObj).newInstance()).getSObjectType();
        DescribeSobjectResult r = t.getDescribe();
        Map<String, Schema.SObjectField> fieldMap = r.fields.getMap();
        Set<String> fieldNames = fieldMap.keySet();

        for(String fieldName : fieldNames) 
        {
            DescribeFieldResult tmptField = fieldMap.get(fieldName).getDescribe();
            String type = String.valueOf(tmptField.getType());
            if(tmptField.getPicklistValues()!=null && type =='picklist')
            {
                picklistList.add(new SelectOption(fieldName,tmptField.getLabel()));
            }
        }
        // return picklistList;
   }
   // retrieve picklist values assign to a selected record type
    public void retrieveValue(String selectedRT, String selectedObj,String selectedPList ){       
        if (!Test.isRunningTest()){
            listofValues = MetadataServiceExamples.getDependentPicklistValuesByRecordType(selectedObj,selectedRT,selectedPList);
        } else {
            listofValues = this.listofValues;
        }
    }

}