open signatures

// given a Queue, return all the drivers in this Queue
fun driversInQueue [q: Queue] : set Driver {
	q.root.*next.ndriver
}
