trigger MilestoneTrigger on Milestone__c (before insert) {
    List<Milestone__c> newM = Trigger.new;
    
    for(Milestone__c m : newM){
      if(m.Status__c == 'Complete') m.addError('A "Completed" Milestone cannot be created!!!');
      
      if(m.Status__c == 'Behind Schedule') m.addError('A "Behind Schedule" Milestone cannot be created!!!');  
    }      
}