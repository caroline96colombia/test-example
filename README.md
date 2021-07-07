# Salesforce DX Project: Code Challenge

Key Points
The goal is to show us some good quality work. While completing tasks in a timely manner is important, the primary purpose isn’t to see how fast you can complete this.
If any of the concepts/technologies are new to you, please take the time to do some research. The ability to research and learn new things is an important skill in our line of work.
Any questions, feel free to ask!

Data Model/Objects
Create custom objects to model the following relationship: There are Projects to which multiple people can make Payments. Likewise, a person can make payments to multiple projects. Use the standard Contact object for people and custom objects for Payments and Projects. The Project should have a field that shows the total amount of Payments made to it by people. There should be fields on Contact showing the total amount of payments and the most recent payment date that a person has made to projects. There should be a field on Payment to capture payment date.

Connect the objects using lookups instead of master-details.

Trigger
Write a trigger to populate these payment date and amount fields on Project and Contact. Use lookup relationships and Apex code instead of roll-up summary fields to compute the amounts. The trigger should handle insert, update and delete of Payments, including modification of payment date.

Lightning Web Components
Using the same data model from above, create one or more lightning web components that lists all people that have made at least one payment to any Project. For each person, show the total payment amount and the most recent payment date, and list the individual payments that a person has made underneath the summary line. The date and amount fields for each payment should be editable on the page.

The user can use this page to edit payments and see the rollups of total amount and most recent payment date in action. The internal user can also use this page to add and delete new payments for a given person listed on the page – so there should be add, delete functionality per person, and edit per payment row.

All of these fields should have  a field validation that checks the user's input value for validity (date, number) using Javascript - and displays errors before the user attempts to persist the data when editing or creating a record.

Please include unit tests like you normally would in actual development projects.
# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## Result

![image](https://user-images.githubusercontent.com/87058939/124710059-da73ab00-dec1-11eb-93f4-432face40ca7.png)


## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
