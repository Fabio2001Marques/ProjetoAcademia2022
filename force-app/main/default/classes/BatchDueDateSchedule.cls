/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 21-07-2022
 * @last modified by  : Fábio Marques
**/
public class BatchDueDateSchedule implements Schedulable{
    public void execute (SchedulableContext context){
        Database.executeBatch(new BatchDueDate());
    }
    
}