trigger AnimalTR on Animal__c (after insert) {

    AnimalTRHandler.handleTrigger(Trigger.new, Trigger.operationType);
    
}