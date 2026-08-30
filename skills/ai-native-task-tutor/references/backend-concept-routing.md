# Backend Concept Routing

Read only the sections triggered by the task. Select no more than three blocking concepts for the first learning gate. Add another concept later only when new evidence makes it necessary.

## Java and object design

Trigger on domain logic, collections, exceptions, equality, interfaces, inheritance, streams, or concurrency.

Teach prerequisites in this order when relevant:

1. object identity, state, and references;
2. interfaces and responsibility boundaries;
3. equality and hashing for collections;
4. checked/unchecked failure propagation;
5. immutability and thread-safety;
6. concurrency primitives only when multiple threads actually matter.

Evidence questions: What object owns the rule? What can mutate? Which exception crosses the boundary? What breaks if equality is wrong?

## Spring container and configuration

Trigger on `@Bean`, `@Configuration`, component scanning, constructor injection, profiles, conditional configuration, scopes, or proxies.

Minimum ladder:

1. The application creates an object graph, not a collection of static calls.
2. A bean is an object whose construction and lifecycle are managed by the Spring container.
3. Injection supplies a managed dependency; constructor injection makes required dependencies explicit.
4. Scope and lifecycle determine whether state is shared.
5. Some Spring features work through proxies, so calls that bypass the proxy may bypass framework behavior.

Do not teach every bean lifecycle callback unless the code uses it. Connect the lesson to the actual bean definition, injection site, and runtime selection.

## HTTP and Spring MVC

Trigger on controllers, request mappings, DTOs, validation, serialization, exception handlers, filters, or interceptors.

Trace: transport input → deserialization → validation → controller → service → response/error mapping. Test invalid and boundary input, not only the happy path. Distinguish domain failure from HTTP representation.

## Transactions and persistence

Trigger on `@Transactional`, repositories, JPA/Hibernate entities, multiple writes, lazy relationships, or migrations.

Minimum ladder:

1. A transaction defines which data changes succeed or fail as one unit.
2. The boundary belongs around a business operation, not automatically around every method.
3. Rollback behavior depends on failure propagation and framework configuration.
4. Spring transaction behavior commonly relies on a proxy; self-invocation is therefore a concrete risk.
5. Persistence context, lazy loading, and query shape affect correctness and performance.

Check lost updates, duplicate writes, N+1 queries, constraint violations, transaction duration, and whether an external side effect can disagree with the database.

## SQL

Trigger on queries, schema changes, filters, joins, pagination, indexes, or performance work.

Teach from the actual query and schema: row shape, join cardinality, filter selectivity, index usefulness, ordering, null behavior, and execution plan. Require the learner to predict both result shape and at least one performance risk.

## Kafka and asynchronous flows

Trigger on producers, consumers, topics, partitions, offsets, retries, or event-driven workflows.

Minimum ladder:

1. Producing a message and processing it are separate failure domains.
2. Ordering is scoped, commonly by partition/key rather than the whole topic.
3. At-least-once processing implies duplicates are normal.
4. Consumer acknowledgement/offset timing changes loss and replay behavior.
5. Idempotency, retry policy, and dead-letter handling are business correctness concerns.

Trace database state, publish, consume, side effect, acknowledgement, retry, and observability. Ask what happens if the same message arrives twice or failure occurs between two adjacent steps.

## Tests and observability

Trigger on any behavior change; this section is nearly always relevant but need not consume one of the three concept slots unless verification is the learning focus.

Separate:

- unit tests for local decision logic;
- integration tests for framework wiring, persistence, serialization, or messaging;
- logs/metrics/traces for behavior that can fail after deployment.

A mock interaction alone does not prove runtime wiring. A green test proves only the behavior its assertion actually observes.

## Security and financial-system concerns

Trigger on authentication, authorization, customer/portfolio data, monetary values, audit trails, secrets, or privileged operations.

Check authorization at the correct boundary, sensitive-data exposure, decimal precision and currency, replay/duplicate effects, auditability, time/date interpretation, and safe logs. Do not paste proprietary code, credentials, personal data, or production values into unapproved tools.
