open signatures

// Show generic big world
pred show {
}

// Show a generic world
pred showWorld1(){
	#Node = 3
	#Driver = 4
	#CallConfirmation = 1
	#TaxiCall = 2
	#Client =3
	#Zone = 2
	#RideRequest = 0
}

// Show a world with only available taxi driver
pred showWorld2 {
	#Zone = 1
	#Driver = 5
	#Client = 0
	#RideRequest = 0
}

// Show a world with no available taxi driver
pred showWorld3 {
	some d: Driver | d.isAvailable.isFalse and not ( one cc: CallConfirmation | d in cc.cdriver ) and not ( one rr: RideReservationConfirmation | d in rr.rdriver )
}

// Show a world in which is enlighted the coexistence between Calls and Reservations
pred showWorld4 {
	#Zone = 1
	#RideReservationConfirmation > 1
	#RideRequest > #RideReservationConfirmation
	#CallConfirmation > 0
}
