public class ContainerInvoiceTRDispatcher {

	public static void changeDateContainerBeforeInsert(List<ContainerInvoice__c> newList) {
        if(ContainerInvoiceTRUtil.containerContainsField('Test_Date__c')) {
        	ContainerInvoiceTRService.changeDateContainer(newList, Date.today());
        }
    }
    
    public static void changeDateContainerParentChange(Map<Id, ContainerInvoice__c> oldMap, Map<Id, ContainerInvoice__c> newMap) {
		if(ContainerInvoiceTRUtil.containerContainsField('Test_Date__c')) {
            List<ContainerInvoice__c> listCntrInv = new List<ContainerInvoice__c>();
            List<ContainerInvoice__c> listOldCntrInvToProcessing = new List<ContainerInvoice__c>();
            for(Id cntrId : newMap.keySet()) {
                ContainerInvoice__c cntrInvNew = newMap.get(cntrId);
                ContainerInvoice__c cntrInvOld = oldMap.get(cntrId);
                if(cntrInvNew.Container__c != cntrInvOld.Container__c){
					listCntrInv.add(cntrInvNew);
                    listOldCntrInvToProcessing.add(cntrInvOld);
                }    
            }
            if(!listCntrInv.isEmpty()) {
        		ContainerInvoiceTRService.changeDateContainer(listCntrInv, Date.today());
			}
            if(!listOldCntrInvToProcessing.isEmpty()) {
        		Map<Id, Datetime> containerIdToNewestChildCreatedDateMap = ContainerInvoiceTRUtil.defineMapContainerIdWithNewestChildCreatedDate(listOldCntrInvToProcessing);
                ContainerInvoiceTRService.changeDateContainer(containerIdToNewestChildCreatedDateMap);
			}
        }
    }     
}