open util/boolean
sig Strings{}
sig PhoneNumber{}
sig Date{}

abstract sig User {
	name: one Strings,
	surname: one Strings,
	password: one Strings,
	phone: one PhoneNumber,
	eMail: one Strings
}

sig Driver extends User {
	drivingLicense: one Strings,
	isAvailable: Bool
}

sig Client extends User {
	birthday: one Date
}

sig Zone {
	queue: set Driver,
	clients: set Client
}

sig TaxiCall {
	client: one Client
}

sig CallConfirmation {
	call: one TaxiCall,
	driver: one Driver
}

//----------------------------------FACTS--------------------------------------------------

fact driverInOnlyOneZone {
	all d: Driver,  disj z1, z2: Zone | d in z1.queue and d not in z2.queue
}

fact clientInOnlyOneZone {
	all c: Client,  disj z1, z2: Zone | c in z1.clients and c not in z2.clients
}


fact availableDriverInQueue {
	all d: Driver, z: Zone | d in z.queue implies d.isAvailable.isTrue
	all d: Driver, z: Zone | d.isAvailable.isTrue implies d in z.queue
}

fact sameZone{
	all cc: CallConfirmation, z: Zone | cc.call.client in z.clients and cc.driver in z.queue
}

fact noSameEMail{
	all disj c1, c2: Client | not c1.eMail = c2.eMail
	all disj d1, d2: Driver | not d1.eMail = d2.eMail
}

fact busyDriver{
	all d: Driver, cc: CallConfirmation | d in cc.driver implies d.isAvailable.isFalse
}


//-------------------------------ASSERTIONS--------------*-*-*------------------------------

assert noDriverInTwoZones{
	all d: Driver,  disj z1, z2: Zone | d in z1.queue and d in z2.queue
}
check noDriverInTwoZones for 10

assert noUnavailableDriverInAQueue{
	all d: Driver, z: Zone | d.isAvailable.isFalse implies d not in z.queue
}
check noUnavailableDriverInAQueue for 10

assert availableDriverInAZone {
	all d: Driver, z: Zone | d.isAvailable.isTrue implies d in z.queue
}
check availableDriverInAZone for 10

assert noDifferentZone {
	no cc: CallConfirmation, disj z1, z2: Zone | cc.call.client in z1.clients and cc.driver in z2.queue
}
check noDifferentZone for 10

assert differentEMail {
	no disj c1, c2: Client | c1.eMail = c2.eMail
}
check differentEMail for 10


//-------------------world------------------------------------

pred show(){
#Client > 1
#Driver >1
}
run show for 10
































