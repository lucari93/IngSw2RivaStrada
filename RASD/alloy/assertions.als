open signatures
open functions

// Check that a driver belogs only to one zone
assert noDriverInTwoZones{
	all d: Driver,  disj z1, z2: Zone | d in driversInQueue [z1.queue] implies d not in driversInQueue [z2.queue]
}

// Check that in a queue there aren't unavailable drivers
assert noUnavailableDriverInAQueue{
	all d: Driver, z: Zone | d.isAvailable.isFalse implies d not in driversInQueue [z.queue]
}

// Check that each the available drivers belog to a zone
assert availableDriverInAZone {
	all d: Driver | (one z: Zone | d.isAvailable.isTrue implies d in driversInQueue[z.queue]) or d.isAvailable.isFalse
	all d: Driver, z: Zone | d in driversInQueue[z.queue] implies d.isAvailable.isTrue
}

// Check that two clients have different e-mails
assert differentEMail {
	no disj c1, c2: Client | c1.eMail = c2.eMail
}
