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
	client: one Client,
}

fact driverInOnlyOneZone {
	all d: Driver,  disj z1, z2: Zone | d in z1.queue and d not in z2.queue
}

fact availableDriverInQueue {
	all d: Driver, z: Zone | d in z.queue implies d.isAvailable.isTrue
	all d: Driver, z: Zone | d.isAvailable.isTrue implies d in z.queue
}

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
