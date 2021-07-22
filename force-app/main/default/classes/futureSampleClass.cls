global class futureSampleClass{

    @future
    public static void testFutureMethod(List<Id> recordIds) {
        Container__c cntr = new Container__c();
        try {
			insert cntr;	    
        } catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        System.debug('new cntr: '+cntr);
    }
    
}