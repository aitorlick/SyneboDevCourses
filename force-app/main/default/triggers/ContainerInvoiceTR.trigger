trigger ContainerInvoiceTR on ContainerInvoice__c (after update, after insert) {
    
	ContainerInvoiceTRHandler.handleTrigger(Trigger.new, Trigger.oldMap, Trigger.newMap, Trigger.operationType);
    
}