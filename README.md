Code challenge


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

Once Completed
Please put your work into a git repo and provide us with the link.
Provide us with a login to a dev instance using our email so we don’t need to get a verification code from you. We will need access to test so we recommend creating a fresh dev org.

![image](https://user-images.githubusercontent.com/87058939/124709409-0fcbc900-dec1-11eb-9242-7fefa43b2182.png)
