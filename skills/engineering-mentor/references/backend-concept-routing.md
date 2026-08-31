# Backend Concept Routing

Read only the sections triggered by the selected repository flow or semantic block. Use this as a guard against missing causal prerequisites, not as a curriculum to teach all at once.

## Java and object design

Trigger on domain logic, collections, exceptions, equality, interfaces, inheritance, streams, immutability, or concurrency.

Typical dependency order:

1. object identity, state, and references;
2. responsibility boundaries and interfaces;
3. equality and hashing for collections;
4. failure and exception propagation;
5. immutability and thread-safety;
6. concurrency primitives only when multiple threads matter.

Ask what owns the rule, what can mutate, which failure crosses a boundary, and what breaks if equality is wrong.

## Spring container and dependency injection

Trigger on `@Bean`, `@Configuration`, component scanning, constructor injection, profiles, conditional configuration, scopes, or framework proxies.

Typical dependency order:

1. the application is an object graph rather than static calls;
2. the container creates and owns managed objects;
3. constructor injection makes required collaborators explicit;
4. registration and conditions determine which concrete bean exists;
5. scope determines whether state is shared;
6. proxy-mediated features can be bypassed by calls that do not cross the proxy.

Do not teach lifecycle callbacks or scopes unless the selected flow uses them.

## HTTP and Spring MVC

Trigger on controllers, mappings, DTOs, serialization, validation, filters, interceptors, or exception handlers.

Trace:

```text
transport input → deserialization → validation → controller
→ application/service boundary → response or error mapping
```

Required-now concepts usually include only the stages present in the selected flow. Distinguish domain failure from its HTTP representation.

## Transactions, JPA, and persistence

Trigger on `@Transactional`, repositories, entities, multiple writes, lazy relationships, or migrations.

Typical dependency order:

1. a transaction groups data changes into one success/failure unit;
2. the boundary belongs around a business operation;
3. rollback depends on failure propagation and framework configuration;
4. Spring transaction behavior commonly relies on a proxy;
5. the persistence context tracks entity state;
6. lazy loading and query shape affect correctness and performance.

Inspect duplicate writes, lost updates, constraints, N+1 behavior, transaction duration, and disagreement between database state and external side effects only when relevant.

## SQL

Trigger on queries, schema, joins, filters, pagination, indexes, or database performance.

Trace actual result shape, join cardinality, null behavior, filtering, ordering, and index usefulness. The learner should predict result shape before advanced execution-plan details become required.

## Kafka and asynchronous flows

Trigger on producers, consumers, topics, keys, partitions, offsets, retries, or event-driven behavior.

Typical dependency order:

1. producing and consuming are separate failure domains;
2. ordering has a scope, commonly a partition/key;
3. at-least-once processing makes duplicates normal;
4. acknowledgement timing affects replay and loss;
5. idempotency, retries, and dead-letter behavior are correctness decisions.

Trace database state, publish, consume, side effect, acknowledgement, retry, and observability only as far as the selected repository flow requires.

## Testing and observability

Trigger on every behavior change, but make this a learning gate only when the learner cannot choose or interpret the verification seam.

Separate:

- unit tests for local decisions;
- integration tests for runtime wiring, serialization, persistence, or messaging;
- logs, metrics, and traces for behavior that can fail after deployment.

A passing check proves only the behavior observed by its assertions and environment.

## Security and monetary concerns

Trigger on authentication, authorization, personal data, secrets, privileged operations, monetary values, audit trails, or time-sensitive calculations.

Check authorization at the correct boundary, sensitive-data exposure, decimal precision and currency, replay effects, auditability, time interpretation, and safe logs. Never copy proprietary values into portable learner memory.
