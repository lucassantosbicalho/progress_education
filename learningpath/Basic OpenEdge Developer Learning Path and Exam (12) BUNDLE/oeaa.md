# OpenEdge Application Architecture (OEAA)

*Highlights*

## OEAA Layers:
- Layer Client
  - Presentation: implements user interface
  - Enterprise Services (API): implements external access to business logic
- Layer Server
  - Service Interfaces: exposes business components as services to clients of all types
  - Business Components: implements the business logic
  - Data Access: implements the encapsulation of business data
  - Data sources: implements access to physical data
  - Common Infrastructure: implements code that can be reused by other parts of the server side of the application
  
## Business Components
Task, Entity, Workflow, Synchronization (TT)

The Business Components layer in OEAA represents the business logic. Business Components are used to provide information to clients (Presentation UI and Enterprise Service layers).

## Business Entity
Defines the business logic around a set of business data that is important to one or more business use cases. A Business Entity works with logical data, typically implemented as temp-tables and/or datasets.
A Business Entity can have a wide variety of responsibilities that include:

 - Data validation 
 - Managing updates to data
 - Business logic computation
 - Transaction assurance

## Service Interface 
Expose a Business Entity to Clients. Service Interfaces define how clients (REST/SOAP/JMS/ABL etc.) access the functionality of a Business Component as a service.

  
