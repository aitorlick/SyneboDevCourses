public class ContainerInvoiceTRUtil {

    public static Map<Id, Datetime> defineMapContainerIdWithNewestChildCreatedDate(List<Id> listIdCntr) {
		Map<Id, Datetime> containerIdToNewestChildCreatedDateMap = new Map<Id, Datetime>();
		AggregateResult[] groupedResults = [SELECT Container__c, Max(CreatedDate) maxCreatedDateContainerInvoice 
                              FROM ContainerInvoice__c 
                              WHERE Container__c IN : listIdCntr
                              GROUP BY Container__c];
        
		for (AggregateResult ar_i : groupedResults)  {
            containerIdToNewestChildCreatedDateMap.put((Id) ar_i.get('Container__c'),
                                                       (Datetime) ar_i.get('maxCreatedDateContainerInvoice'));
		}
        
        for (Id idCntr_i : listIdCntr)  {
            if(!containerIdToNewestChildCreatedDateMap.containsKey(idCntr_i)) {
                containerIdToNewestChildCreatedDateMap.put(idCntr_i, null);
            }
		}
        
		return containerIdToNewestChildCreatedDateMap;
    }
    
}