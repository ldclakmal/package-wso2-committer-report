# Package WSO2 Committer Report

The WSO2 Committer Report connector allows you to list all the pull requests you sent, list all the issues you get involved and list all the emails you get involved.

## Compatibility

| Ballerina Version  |
|:------------------:|
| 0.981.1            |

## Getting started

1. Refer the [Getting Started](https://ballerina.io/learn/getting-started/) guide to download and install Ballerina.

2. Import the GitReport package to your Ballerina program as follows.

    ```ballerina
    import chanakal/gitreport;
    ```

## Sample code

This code explains how to get the given state pull requests sent by the given username.

```ballerina
import ballerina/io;
import chanakal/gitreport;

endpoint gitreport:Client gitReportClient {};

function main (string... args) {
    string githubUser = "ldclakmal";
    var details = gitReportClient->printPullRequestList(githubUser, gitreport:STATE_ALL);
    match details {
        () => {}
        error err => { io:println(err); }
    }
}
```

This code explains how to get the given state issues, that the given username involves in.

```ballerina
import ballerina/io;
import chanakal/gitreport;

endpoint gitreport:Client gitReportClient {};

function main (string... args) {
    string githubUser = "ldclakmal";
    var details = gitReportClient->printIssueList(githubUser, gitreport:STATE_ALL);
    match details {
        () => {}
        error err => { io:println(err); }
    }
}
```

This code explains how to get the emails, that the given user involves in.

```ballerina
import ballerina/io;
import chanakal/gitreport;

endpoint gitreport:Client gitReportClient {};

function main (string... args) {
    string email = "chanakal@wso2.com";
    string[] excludeEmails = ["vacation-group@wso2.com"];
    int maxListSize = 150;
    var details = gitReportClient->printEmailList(email, 150, excludeEmails);
    match details {
        () => {}
        error err => {
            test:assertFail(msg = err.message);
        }
    }
}
```
