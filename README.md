# ReClaim:A Community-Based Lost and Found Verification System with Claim Matching
## Description
ReClaim is a mobile application designed to help users report,track and claim their lost items efficiently.Users can manage their own reports,while adminstrators manage verification and resolve conflicts. 

## Team Members 

| Name | ID |
|------|----|
| Darik Kefelegn |UGR/8508/16|
| Liya Tegared | UGR/8172/16 |
| Ruth Dagim | UGR/9664/16 |
| Yeabsera Zewdu | UGR/1970/16 |
| Yeshak Tsegaye  | UGR/0585/16 |

## Target users
- Students
- Small Organizations
## Authentication and Authorization

The application uses user login credentials to ensure secure authentication.
It is a role-bases acces control.
- Users: can report items,submit claims and manage their own data
- Item Owners: Can review and respond to claims for their items.
- Admins: Can oversee all items and claims and resolve disputes

## Business Features and CRUD Operations

### 1.Lost and Found Item Management

Create:Users can report lost or found items by providing details such as item name, description, category, location, date, and optional image.

Read:
Users can browse and search for lost or found items, filter by category or location, and view detailed information including item status.

Update:
Users can edit their submitted item details or update the item status (e.g., lost, found, recovered).

Delete:
Admin can remove an item  when they are no longer relevant.
### 2.Claim Verification and Matching
Create:
Users can submit a claim request for a found item they believe belongs to them, providing supporting details for verification.

Read:
Users can view their submitted claims and potential matches, while item owners can view all claims related to their items.

Update:
Claim status can be updated. Item owners or administrators can verify and respond to claims.

Delete:
Users can withdraw their claims, and item owners can reject invalid claims.

## Additional Features
### Automatic Matching

The system automatically suggests possible matches between lost and found items based on similarities in title, description, category, and location.
Create:
The system automatically generates match records when a new lost or found item is created.

Read:
Users can view suggested matches related to their reported items.

Update:
Matching results are updated automatically when item details are modified or new items are added.

Delete:
Outdated or irrelevant matches are removed automatically by the system.
### Match Confidence Score

Each suggested match is assigned a confidence score based on how closely the items match like keyword similarity, same category, same location. 
Create:
A confidence score is generated when a match is created, based on similarity factors such as keywords, category, and location.

Read:
Users can view the confidence score associated with each suggested match.

Update:
The confidence score is recalculated when related item data changes.

Delete:
Confidence scores are removed when the corresponding match is deleted.
