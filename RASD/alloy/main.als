// Import all the parts of the model
open signatures
open functions
open facts
open assertions
open predicates

// Check the assertions
check noDriverInTwoZones for 5
check noUnavailableDriverInAQueue for 5
check availableDriverInAZone for 5
check differentEMail for 5

// Generate some Worlds
run show for 20
run showWorld1 for 10
run showWorld2 for 10
run showWorld3 for 10
run showWorld4 for 10
