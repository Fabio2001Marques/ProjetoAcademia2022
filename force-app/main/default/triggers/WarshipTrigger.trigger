trigger WarshipTrigger on Warship__c (after Update) {
    List<Warship__c> newM = Trigger.new;
    
    List<Warship__c> lockedWarships = new List<Warship__c>();

    for(Warship__c w: newM){       
        if(w.Project_Status__c == 'Complete') lockedWarships.add(w);
    }
    Approval.LockResult[] lrList = Approval.lock(lockedWarships, false);

    // Iterate through each returned result
    for(Approval.LockResult lr : lrList) {
        if (lr.isSuccess()) {
            // Operation was successful, so get the ID of the record that was processed
            System.debug('Successfully locked account with ID: ' + lr.getId());
        }
        else {
            // Operation failed, so get all errors                
            for(Database.Error err : lr.getErrors()) {
                System.debug('The following error has occurred.');                    
                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                System.debug('Account fields that affected this error: ' + err.getFields());
            }
        }
    }

}