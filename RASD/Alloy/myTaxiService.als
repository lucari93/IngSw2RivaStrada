open util/boolean
sig Strings{}
sig PhoneNumber{}
sig Date{}

abstract sig User {
//	name: one Strings,
//	surname: one Strings,
//	password: one Strings,
//	phone: one PhoneNumber,
	eMail: one Strings
}

sig Driver extends User {
//	drivingLicense: one Strings,
	isAvailable: one Bool
}

sig Client extends User {
//	birthday: one Date
}

sig Queue {
	root: lone Node
}
sig Node {
	driver: one Driver,
	next: lone Node
}

sig Zone {
	queue: one Queue,
}

sig TaxiCall {
	client: one Client
}

sig CallConfirmation {
	call: one TaxiCall,
	driver: one Driver
}

// ---------- FUNCTIONS ---------- //

fun driversInQueue [q: Queue] : set Driver {
	q.root.*next.driver
}

//----------------------------------FACTS--------------------------------------------------

// Queue
fact nextNotReflexive {
	no n:Node | n = n.next
}
fact nextNotCyclic {
	no n:Node | n in n.^next
}
fact allNodesBelongToAQueue {
	all n: Node | one q: Queue | n in q.root.*next
}
/*
fact driverInOnlyOneNode {
	all d: Driver, disj n1,n2: Node | d in n1.driver implies d not in n2.driver
}
*/
fact availableDriverInQueue {
	all d: Driver | (one n: Node | d.isAvailable.isTrue implies d in n.driver) or d.isAvailable.isFalse
	all d: Driver, n: Node | d in n.driver implies d.isAvailable.isTrue
}

fact queueMustBeInAZone {
	all q:Queue | one z: Zone | q in z.queue
}

fact oneCallConfirmationPerTaxiCall {
	all c: TaxiCall, disj cc1,cc2: CallConfirmation | c in cc1.call implies not c in cc2.call
}

fact oneTaxiCallPerClient {
	all c: Client, disj c1,c2: TaxiCall | c in c1.client implies not c in c2.client
}

fact oneCallConfirmationPerDriver {
	all d: Driver, disj cc1,cc2: CallConfirmation | d in cc1.driver implies d not in cc2.driver
}

fact busyDriver{
	all d: Driver, cc: CallConfirmation | d in cc.driver implies d.isAvailable.isFalse
}

fact noSameEMail{
	all disj c1, c2: Client | not c1.eMail = c2.eMail
	all disj d1, d2: Driver | not d1.eMail = d2.eMail
}

//-------------------------------ASSERTIONS--------------*-*-*------------------------------

assert noDriverInTwoZones{
	all d: Driver,  disj z1, z2: Zone | d in driversInQueue [z1.queue] implies d not in driversInQueue [z2.queue]
}
check noDriverInTwoZones for 5

assert noUnavailableDriverInAQueue{
	all d: Driver, z: Zone | d.isAvailable.isFalse implies d not in driversInQueue [z.queue]
}
check noUnavailableDriverInAQueue for 5

assert availableDriverInAZone {
	all d: Driver | (one z: Zone | d.isAvailable.isTrue implies d in driversInQueue[z.queue]) or d.isAvailable.isFalse
	all d: Driver, z: Zone | d in driversInQueue[z.queue] implies d.isAvailable.isTrue
}
check availableDriverInAZone for 5

assert differentEMail {
	no disj c1, c2: Client | c1.eMail = c2.eMail
}
check differentEMail for 5


//-------------------world------------------------------------

pred show(){

#Node = 3
#Driver = 4
#CallConfirmation = 1
#TaxiCall = 2
#Client =3
#Zone = 2

}
run show for 10
































