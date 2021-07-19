public class ContainerInvoiceTRService {

    public static void changeDateContainer(List<ContainerInvoice__c> listCntrInv, Date updateDate) { 
        Map<Id,Container__c> cntrToUpdate = new Map<Id,Container__c>();
        for(ContainerInvoice__c currentContainerInvoice : listCntrInv) {
            if (cntrToUpdate.containsKey(currentContainerInvoice.Container__c)) {
				continue;
            }
            Container__c cntr = new Container__c(Id = currentContainerInvoice.Container__c);
        	cntr.Test_Date__c = updateDate;
            cntrToUpdate.put(currentContainerInvoice.Container__c,cntr);
		}
        update cntrToUpdate.values();                
    }
    
    public static void changeDateContainer(Map<Id, Datetime> containerIdToNewestChildCreatedDateMap) { 
        List<Container__c> cntrToUpdate = new List<Container__c>();
        for(Id containerId_i : containerIdToNewestChildCreatedDateMap.keySet()) {
        	Container__c cntr = new Container__c(Id = containerId_i);
            cntr.Test_Date__c = containerIdToNewestChildCreatedDateMap.get(containerId_i);
            cntrToUpdate.add(cntr);
		}
        update cntrToUpdate;                
    }
    
}