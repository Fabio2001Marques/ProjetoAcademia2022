public class ControllerListWarship {

    public ControllerListWarship() {
        init();
    }


    public List<Warship__c> warship{ get; set; }

    private void init(){      
        String userName = UserInfo.getUserName();
        User activeUser = [Select Email From User where Username = : userName limit 1];
        Contact contact = [Select id, email, Account.Name, isResponsibleForComunication__c from contact where email = :activeUser.Email and isResponsibleForComunication__c = true];

        warship = [Select id, Name, ActiveMilestones__c, Project_Status__c, Weapons_Status__c from Warship__c where account__r.Name = :contact.Account.Name];
    }
}
 