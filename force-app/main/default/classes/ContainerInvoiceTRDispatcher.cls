public class ContainerInvoiceTRDispatcher {

	public static void changeDateContainerBeforeInsert(List<ContainerInvoice__c> newList) {
		ContainerInvoiceTRService.changeDateContainer(newList, Date.today());
    }
    
    public static void changeDateContainerParentChange(Map<Id, ContainerInvoice__c> oldMap, Map<Id, ContainerInvoice__c> newMap) {
		List<ContainerInvoice__c> listCntrInv = new List<ContainerInvoice__c>();
		List<Id> listOldCntrIdToProcessing = new List<Id>();
		for(Id cntrId : newMap.keySet()) {
			ContainerInvoice__c cntrInvNew = newMap.get(cntrId);
			ContainerInvoice__c cntrInvOld = oldMap.get(cntrId);
			if(cntrInvNew.Container__c != cntrInvOld.Container__c){
				listCntrInv.add(cntrInvNew);
				listOldCntrIdToProcessing.add(cntrInvOld.Container__c);
			}    
		}
		if(!listCntrInv.isEmpty()) {
			ContainerInvoiceTRService.changeDateContainer(listCntrInv, Date.today());
		}
		if(!listOldCntrIdToProcessing.isEmpty()) {
			Map<Id, Datetime> containerIdToNewestChildCreatedDateMap = ContainerInvoiceTRUtil.defineMapContainerIdWithNewestChildCreatedDate(listOldCntrIdToProcessing);
			ContainerInvoiceTRService.changeDateContainer(containerIdToNewestChildCreatedDateMap);
		}
    }     
}