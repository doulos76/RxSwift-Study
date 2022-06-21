# Traits

## RxCocoa Traits

### Signal

A `Signal` is similar to `Driver` with on difference, it does __not__ replay the latest event on subscription, but subscribers still share the sequence's computational resources.

It can be considerd a builder pattern to modal Imperative Events in a Reactive way as part of your application.

A `Singal`:

* Can't error out
* Delivers events on Main Scheduler.
* Shares computational resources(`share(scope: .whileConnected`)
* Does NOT replay elements on subscription.