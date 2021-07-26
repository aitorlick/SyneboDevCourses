public class AnimalTRHandler {

    public static void handleTrigger(List<Animal__c> newList, System.TriggerOperation triggerEvent) {
        
        switch on triggerEvent {
            when AFTER_INSERT {
                System.debug('AFTER_INSERT');
                AnimalTRDispatcher.setAnimalFields(newList);
            }
            when else {
                System.debug('do nothing on others trigger events');
            }
        }

    }
    
}