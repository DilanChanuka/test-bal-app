import ballerina/http;
import ballerina/io;
import ballerina/log;

// HTTP client configuration
http:Client httpClient = check new ("http://tailscale-proxy-2271099802:8080");

public function main() returns error? {
    // Log before making the request
    log:printInfo("Starting HTTP request to fetch Readme.md file");
    log:printInfo("Target URL: http://tailscale-proxy-2271099802:8080/Readme.md");
    
    // Make the HTTP GET request
    http:Response|error response = httpClient->get(path = "/Readme.md");
    
    if response is error {
        log:printError("Failed to fetch Readme.md file", 'error = response);
        return response;
    }
    
    // Log after receiving the response
    log:printInfo("Successfully received response from the server");
    log:printInfo(string `Response status code: ${response.statusCode}`);
    
    // Get the response payload as string
    string|error responseBody = response.getTextPayload();
    
    if responseBody is error {
        log:printError("Failed to read response body", 'error = responseBody);
        return responseBody;
    }
    
    // Log the response content
    log:printInfo("Response received successfully. Content:");
    io:println("=== README.MD CONTENT ===");
    io:println(responseBody);
    io:println("=== END OF CONTENT ===");
    
    log:printInfo("HTTP request completed successfully");
}