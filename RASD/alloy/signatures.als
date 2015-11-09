// Import boolean utility
open util/boolean
// Primitive String Type
sig Strings{}

// General user of the service
abstract sig User {
	eMail: one Strings
}
// Taxi Driver
sig Driver extends User {
	isAvailable: one Bool
}
// Client
sig Client extends User {}

// Taxi Drivers Queue
sig Queue {
	root: lone Node
}
// Queue Element
sig Node {
	ndriver: one Driver,
	next: lone Node
}

// City Zone
sig Zone {
	queue: one Queue,
}

// Taxi Call made by a Client
sig TaxiCall {
	client: one Client
}
// Call Confirmation made by a Taxi Driver and related to a Taxi Call
sig CallConfirmation {
	call: one TaxiCall,
	cdriver: one Driver
}

// Ride Request made by a Client
sig RideRequest {
	client: one Client
}
// Ride Confirmation made by a Taxi Driver and related to a Taxi Call
sig RideReservationConfirmation {
	request: one RideRequest,
	rdriver: one Driver
}