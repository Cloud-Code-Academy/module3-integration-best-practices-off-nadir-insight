/**
 * @description Service class that handles API callouts to the Exchange Rate API
 * Students will implement the methods to make callouts and process responses
 */
public class ExchangeRateService {
    
    // The named credential to use for the callout
    private static final String NAMED_CREDENTIAL = 'ExchangeRateAPI';
    
    // The base currency to use for exchange rates
    private static final String BASE_CURRENCY = 'USD';
    
    /**
     * @description Makes a callout to the Exchange Rate API to get the latest exchange rates
     * @return ExchangeRateWrapper containing the response data
     */
    public static ExchangeRateWrapper getLatestRates() {
        // TODO: Implement the method to make a callout to the Exchange Rate API
        HttpResponse response = HttpUtilities.makeCallout('GET', 'callout:NAMED_CREDENTIAL/latest' + BASE_CURRENCY);
        ExchangeRateWrapper responseParsed = ExchangeRateWrapper.parse(response.getBody());

        return responseParsed; // Replace with actual implementation
    }
    
    /**
     * @description Processes the exchange rate data and creates or updates records
     * @param rateData The wrapper containing exchange rate data
     * @return List<Exchange_Rate__c> The list of records created or updated
     */
    public static List<Exchange_Rate__c> processRates(ExchangeRateWrapper rateData) {
        // TODO: Implement the method to process rates and create/update records

        List<Exchange_Rate__c> exchangeRatesToUpsert = rateData.toExchangeRates();
        
        upsert exchangeRatesToUpsert External_Id__c;
        // return null; // Replace with actual implementation
        return exchangeRatesToUpsert;
    }
    
    /**
     * @description Combines getting and processing rates into a single operation
     * @return List<Exchange_Rate__c> The list of records created or updated
     */
    public static List<Exchange_Rate__c> updateExchangeRates() {
        // TODO: Implement the method to get and process rates
        // 1. Call getLatestRates to retrieve the data
        // 2. Call processRates to create/update records
        // 3. Return the processed records

        ExchangeRateWrapper parsedJson = getLatestRates();
        List<Exchange_Rate__c> updatedExchangeRates = processRates(parsedJson);
        
        // return null; // Replace with actual implementation
        return updatedExchangeRates; // Replace with actual implementation
    }
}