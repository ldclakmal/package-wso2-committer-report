import ballerina/io;
import ballerina/stringutils;

# Return the untainted next URL after clearing the given link header with other symbols. If next URL is not given,
# returns an empty string, which represents the last page
# `Link: <https://api.github.com/resource?page=2>; rel="next", <https://api.github.com/resource?page=5>; rel="last"`
#
# + linkHeader - Link header of the request
# + return - Next URL and Last URL
function getNextResourcePath(string linkHeader) returns @untainted string {
    string[] urlWithRelationArray = stringutils:split(linkHeader, COMMA);
    string nextUrl = "";
    foreach string urlWithRealtion in urlWithRelationArray {
        string urlWithBrackets = stringutils:split(urlWithRealtion, SEMICOLON)[0].trim();
        if (stringutils:contains(urlWithRealtion, NEXT_REALTION)) {
            nextUrl = getResourcePath(urlWithRealtion);
        }
    }
    return nextUrl;
}

# Return the resource path after clearing the given URL with other symbols
#
# + link - Link URL with other parameters
# + return - Cleaned resource path
function getResourcePath(string link) returns string {
    string urlWithBrackets = stringutils:split(link, SEMICOLON)[0].trim();
    return stringutils:replace(urlWithBrackets.substring(1, urlWithBrackets.length() - 1), GITHUB_API_BASE_URL, EMPTY_STRING);
}

# Return the build query parametrs for GMail API
#
# + userEmail - User email for 'from' parameter
# + excludeEmails - List of emails to be excluded from 'to' parameter
# + return - Built string with query parameters
function buildQueryParams(string userEmail, string[]? excludeEmails) returns string {
    string queryParams = "from:" + userEmail;
    if (excludeEmails is string[]) {
        queryParams += " to:(";
        foreach string email in excludeEmails {
            queryParams += " -" + email;
        }
        queryParams += ")";
    }
    queryParams += " -in:chats";
    return queryParams;
}

# Add the given key and value to the given map
#
# + m - Map, the value to be added
# + key - Key of the value
# + value - Actual value to be added
function addToMap(map<string[]> m, string key, string value) {
    if (m.hasKey(key)) {
        string[] valueArray = m[key] ?: [];
        valueArray[valueArray.length()] = value;
    } else {
        string[] valueArray = [value];
        m[key] = valueArray;
    }
}

# Print the given GitHub data map
#
# + m - The data as a map
function printGitHubDataMap(map<string[]> m) {
    foreach string key in m.keys() {
        string githubOrgWithRepo = stringutils:replace(key, GITHUB_API_BASE_URL + REPOS, EMPTY_STRING);
        string githubOrg = stringutils:split(githubOrgWithRepo, FORWARD_SLASH)[0];
        string githubRepo = stringutils:split(githubOrgWithRepo, FORWARD_SLASH)[1];
        io:println("GitHub Org  : " + githubOrg);
        io:println("GitHub Repo : " + githubRepo);
        string[] list = <string[]>m[key];
        foreach string item in list  {
            io:println(item);
        }
        io:println("---");
    }
}

# Print the given GMail data list
#
# + list - The data as a list
function printGmailDataList(string[] list, string category) {
    io:println("Category: " + category);
    io:println("*****************************");
    foreach string item in list  {
        io:println(item);
    }
    io:println("---");
}
