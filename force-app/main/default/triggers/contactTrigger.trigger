trigger contactTrigger on Contact (before insert, before update, after update) {
    List<Contact> contacts = Trigger.new;
    List<Contact> contactsOld = Trigger.old;
    
    List<Contact> contact= [Select id from Contact where isResponsibleForComunication__c = true and AccountId = :contacts[0].accountId];
    
    if(contact.size()>0){
        for(Contact c : contacts ){  
            if (Trigger.isInsert) {
                if(c.isResponsibleForComunication__c  == true) c.addError('Já existe um responsável para esta account');
            }
            if (Trigger.isBefore && Trigger.isUpdate) {
                if((c.isResponsibleForComunication__c  == true) && (c.isResponsibleForComunication__c != contactsOld[0].isResponsibleForComunication__c))  c.addError('Já existe um responsável para esta account');
            }    
           
        } 
    }
    if (Trigger.isAfter) {
        if (contacts[0].isResponsibleForComunication__c == true) {
            Contact c = [Select id from contact where isResponsibleForComunication__c = true and AccountId = :contacts[0].accountId limit 1];
            Account acc = [select id, Contact__c from Account where Id = :contacts[0].AccountId limit 1];
            acc.Contact__c = c.Id;
            update acc;
        }      
    }
    
}