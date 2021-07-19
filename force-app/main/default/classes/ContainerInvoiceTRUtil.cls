public class ContainerInvoiceTRUtil {

    public static boolean containerContainsField(String fieldName){
        if(String.isBlank(fieldName)) {
            return false;
        }            
        Set<String> containerFields = Schema.SObjectType.Container__c.fields.getMap().keySet();       
        return containerFields.contains(fieldName.toLowerCase());
    }
    
    public static Map<Id, Datetime> defineMapContainerIdWithNewestChildCreatedDate(List<ContainerInvoice__c> listCntrInv) {
		Map<Id, Datetime> containerIdToNewestChildCreatedDateMap = new Map<Id, Datetime>();
		AggregateResult[] groupedResults = [SELECT Container__c, Max(CreatedDate) maxCreatedDateContainerInvoice 
                              FROM ContainerInvoice__c 
                              WHERE ContainerInvoice__c.Id IN : listCntrInv
                              GROUP BY Container__c];
        
		for (AggregateResult ar : groupedResults)  {
            containerIdToNewestChildCreatedDateMap.Put((Id) ar.get('Container__c'),
                                                       (Datetime) ar.get('maxCreatedDateContainerInvoice'));
		}
        
		return containerIdToNewestChildCreatedDateMap;
    }
    
}