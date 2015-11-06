open signatures

// BEGIN: Definition of a generic Queue:
// A node cannot be connected to itself
fact nextNotReflexive {
	no n:Node | n = n.next
}
// Cycles must not be present
fact nextNotCyclic {
	no n:Node | n in n.^next
}
// Cannot exist a node not in a queue
fact allNodesBelongToAQueue {
	all n: Node | one q: Queue | n in q.root.*next
}
// END

// All the available taxi drivers must be in one and only one queue
fact availableDriverInQueue {
	all d: Driver | (one n: Node | d.isAvailable.isTrue implies d in n.ndriver) or d.isAvailable.isFalse
	all d: Driver, n: Node | d in n.ndriver implies d.isAvailable.isTrue
}

// A queue must own to a zone
fact queueMustBeInAZone {
	all q:Queue | one z: Zone | q in z.queue
}

// A Taxi call can have at most a Call Confirmation
fact oneCallConfirmationPerTaxiCall {
	all c: TaxiCall, disj cc1,cc2: CallConfirmation | c in cc1.call implies not c in cc2.call
}

// A Client can make at most a Taxi Call at a time
fact oneTaxiCallPerClient {
	all c: Client, disj c1,c2: TaxiCall | c in c1.client implies not c in c2.client
}

// A Taxi Driver can accept at most a Call at a time
fact oneCallConfirmationPerDriver {
	all d: Driver, disj cc1,cc2: CallConfirmation | d in cc1.cdriver implies d not in cc2.cdriver
}

// A Taxi Driver who accepts a Taxi Call must become "unavailable"
fact busyDriver{
	all d: Driver, cc: CallConfirmation | d in cc.cdriver implies d.isAvailable.isFalse
}

// A Ride Request can have at most a Ride Reservation Confirmation
fact oneRideReservationConfirmationPerRideRequest {
	all rr: RideRequest, disj rc1,rc2: RideReservationConfirmation | rr in rc1.request implies not rr in rc2.request
}

// Two different Users cannot have the same e-mail address but with the same e-mail a driver must be registered as a client too.
fact noSameEMail{
	all disj c1, c2: Client | not c1.eMail = c2.eMail
	all disj d1, d2: Driver | not d1.eMail = d2.eMail
}
