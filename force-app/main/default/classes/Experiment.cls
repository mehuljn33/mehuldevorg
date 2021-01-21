public class Experiment {
    
    public static List<Account> returnAccounts() {
        List<Account> acc = [Select id, name from Account limit 5];
        return acc;
    }
}