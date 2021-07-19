public class ContainerInvoiceTRHandler {

    public static void handleTrigger(List<ContainerInvoice__c> newList, Map<Id, ContainerInvoice__c> oldMap, Map<Id, ContainerInvoice__c> newMap, System.TriggerOperation triggerEvent) {
        
        switch on triggerEvent {
            when AFTER_INSERT {
                System.debug('AFTER_INSERT');
                ContainerInvoiceTRDispatcher.changeDateContainerBeforeInsert(newList);
            }
            when AFTER_UPDATE {
                System.debug('AFTER_UPDATE');
                ContainerInvoiceTRDispatcher.changeDateContainerParentChange(oldMap, newMap);
            }
            when else {
                System.debug('do nothing on others trigger events');
            }
        }

    }
    
}