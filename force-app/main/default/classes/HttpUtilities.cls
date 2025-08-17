public with sharing class HttpUtilities {
    public HttpUtilities() {}

    public static HttpResponse makeCallout(
        String method,
        String endpoint
    ) {
        return makeCallout(method, endpoint, null, null, 10000);
    }   

    public static HttpResponse makeCallout(
        String method,
        String endpoint,
        String payload,
        Map<String, String> additionalHeaders,
        Integer TimeoutMS
    ) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod(method);
        req.setTimeout(TimeoutMS);
        req.setHeader('Content-Type', 'application/json');

        if (payload != null) {
            req.setBody(payload);
        }

        if (additionalHeaders != null) {
            for (String key : additionalHeaders.keySet()) {
                req.setHeader(key, additionalHeaders.get(key));
            }
        }

        try {
            Http http = new Http();
            HttpResponse response = http.send(req);

            Integer statusCode = response.getStatusCode();
            if (statusCode >= 200 && statusCode < 300) {
                return response;
            } else {
                System.debug('Callout failed. Status Code: ' + statusCode);
                System.debug('Response Body: ' + response.getBody());
                // return response;
                // System.debug('Callout Exception Error: ' + ex.getMessage());
                throw new CalloutException('Callout Error');
            }

        } catch (CalloutException ex) {
            System.debug('Callout Exception Error: ' + ex.getMessage());
            throw ex;
        }
    }
}