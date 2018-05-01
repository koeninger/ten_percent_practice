pragma solidity ^0.4.17;

// Contract that manages the instances of a campaign contract
contract CampaignFactory {
    // Defines a short description of the campaign
    struct CampaignShort{
        address campaignAddress;
        string description;
        uint minimum;
    }
    // Keep track of all deployed instinces of the campaign contract
    CampaignShort[] public campaigns;
    uint public campaignCount; 

    // Creates a new campaign
    function createCampaign(uint minimum, string description) public {
        // Creates new instance of Campaign contract
        address campaignAddress = new Campaign(minimum, description, msg.sender);
        
        // Factory will keep a description of each campaign
        CampaignShort memory newCampaign = CampaignShort({
            campaignAddress: campaignAddress,
            description: description,
            minimum: minimum
        });
        
        // Store address of new contract instance
        campaigns.push(newCampaign);
        campaignCount++;
    }
}

// Contract for a specific campaign
contract Campaign {
    // Structure that defines a spending request
    struct Request{
        string requestDescription;
        uint requestValue;
        address recipient;
        bool complete;
        uint approvalCount;
        mapping(address => bool) approvals;
    }


    string public campaignDescription;
    Request[] public requests;					// List of created spending requests
    address public manager;						// Creator of the campaign
    uint public minimumContribution;			// Minimum amount of Wei required to contribute to campaign
    mapping(address => bool) public approvers;	// List of contributors of the campaign
    uint public approversCount;                 // Keep track of number of approvers


    // A modifier to be added to functions that only the manager should have access to
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }


    // Constructor that initiates a campaign
    function Campaign(uint minimum, string description, address creator) public {
        require(minimum > 0);

        manager = creator;
        campaignDescription = description;
        minimumContribution = minimum;
    }

    // Allows users to contribute to campaign if enough ether is sent
    function contribute() public payable {
        // The contribution must be greater than minimumContribution
        require(msg.value >= minimumContribution);

        if(!approvers[msg.sender]){
            // Store contributors address
            approvers[msg.sender] = true;
            approversCount++;
        }
    }

    // Creates a spending request (restricted to managers only)
    function createRequest(string requestDescription, uint requestValue, address recipient) public restricted {
        // New spending request from manager
        Request memory newRequest = Request({
            requestDescription: requestDescription,
            requestValue: requestValue,
            recipient: recipient,
            complete: false,
            approvalCount: 0
        });
        // Store new request
        requests.push(newRequest);
    }

    // Accepts the index of the request the user wants to approve
    function approveRequest(uint index) public {
        // Get the request from the index parameter
        Request storage request = requests[index];

        // Check that user is a contributor
        require(approvers[msg.sender]);
        // Check that approver has not already approved this request
        require(!request.approvals[msg.sender]);

        // User approves request
        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }

    // Completes spending request by manager
    function finalizeRequest(uint index) public restricted {
        // Get the request from the index parameter
        Request storage request = requests[index];

        // Check that request has not already been finalized
        require(!request.complete);
        // Check that at least half of contributors have approved the sending request
        require(request.approvalCount > (approversCount/2));

        // Send the money to the receipient of spending request
        request.recipient.transfer(request.requestValue);
        // Mark request as complete
        request.complete = true;
    }

    // Returns a summary of details for a campaing
    function getSummary() public view returns (string, uint, uint, uint, uint, address) {
        return (
            campaignDescription,
            minimumContribution,
            this.balance,
            requests.length,
            approversCount,
            manager
        );
    }

    function getRequestsCount() public view returns (uint) {
        return requests.length;
    }

    // Checks if a contributor has approved a given request
    function isContributorApprover(uint index, address contributor) public view returns (bool) {

        // Get the request from the index parameter
        Request storage request = requests[index];

        // Check if contributor has approved that request
        return request.approvals[contributor];
    }
}