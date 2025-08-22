/**
 * @description Wrapper class to deserialize the JSON response from the Exchange Rate API
 * Students will implement the properties and methods to process the data
 */
public class ExchangeRateWrapper {
    
    // TODO: Implement properties to match the JSON structure of the API response
    // Sample response:
    // {
    //   "base_code": "USD",
    //   "time_last_update_unix": 1740690001,
    //   "conversion_rates": {
    //     "EUR": 0.9488,
    //     "GBP": 0.8393,
    //     "JPY": 136.57,
    //     ...
    //   }
    // }
    
    public String base_code; // base currency code
    public String time_last_update_unix;
    public Map<String, Decimal> conversion_rates; // map {currency_code, exchange rate}
    public String externalId; // baseCurrency + '_' + targetCurrency
    
    /**
     * @description Converts the wrapper data to a list of Exchange_Rate__c records
     * @return List<Exchange_Rate__c> The list of exchange rate records
     */
    public List<Exchange_Rate__c> toExchangeRates() {
        List<Exchange_Rate__c> exchangeRates = new List<Exchange_Rate__c>();
        for (String targetCurrency : conversion_rates.keySet()) {
            Decimal rate = conversion_rates.get(targetCurrency);
            Datetime lastUpdated = DateTime.newInstance(Long.valueOf(time_last_update_unix));
            
            exchangeRates.add(new Exchange_Rate__c(
                Base_Currency__c = this.base_code,
                External_Id__c = this.base_code + '_' + targetCurrency,
                Last_Updated__c = lastUpdated,
                Rate__c = rate,
                Target_Currency__c = targetCurrency
            ));
        }
        
        return exchangeRates;
    }
    
    /**
     * @description Static method to parse the JSON response into the wrapper class
     * @param jsonResponse The JSON response from the API
     * @return ExchangeRateWrapper The parsed wrapper instance
     */
    public static ExchangeRateWrapper parse(String jsonResponse) {
        return (ExchangeRateWrapper) JSON.deserialize(jsonResponse, ExchangeRateWrapper.class);
    }
}