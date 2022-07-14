/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 14-07-2022
 * @last modified by  : Fábio Marques
**/
trigger MilestoneTrigger on Milestone__c (before insert) {
    List<Milestone__c> newM = Trigger.new;
    
    Id userId = UserInfo.getUserId();

    List<AggregateResult> permission = [SELECT count(Id) FROM PermissionSetAssignment WHERE AssigneeId = :Userinfo.getUserId() AND PermissionSet.Name = 'Disable_Validation_Rule'];

    if (permission[0].get('expr0') == 0) {
      for(Milestone__c m : newM){       
        if(m.Status__c == 'Complete') m.addError('A "Completed" Milestone cannot be created!!!');
        
        if(m.Status__c == 'Behind Schedule') m.addError('A "Behind Schedule" Milestone cannot be created!!!');  
      }  
    }        
}