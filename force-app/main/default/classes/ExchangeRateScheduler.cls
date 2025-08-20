/**
 * @description Scheduler class to run the exchange rate update on a schedule
 * Scheduling should be done in Salesforce Setup Apex Classes -> Schedule Apex
 */
global class ExchangeRateScheduler implements Schedulable {
    
    /**
     * @description Executes the scheduled job to update exchange rates
     * @param context The SchedulableContext
     */
    public void execute(SchedulableContext sc) {
        // TODO: Implement the method to update exchange rates
        // 1. Call ExchangeRateService.updateExchangeRates()
        // 2. Add error handling
        // 3. Consider adding logging if available
        try {
            ExchangeRateService.updateExchangeRates();
        } catch (Exception ex) {
            System.debug('General Exception caught: ' + ex.getMessage());
            Logger.error('General Exception caught: ' + ex.getMessage());
            Logger.saveLog();
        }
    }
}