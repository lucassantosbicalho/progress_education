# ABL Classes

ABL Classes are used to represent users, objects, and systems, wich are business entities in an enterprise aplication.
A class contains data members and methods that are used to provide the behavior for the class and to access the data members of the class.

An instance of a class is an in-memory object that contains values for the data members. There can be several instances of a class at runtime, each with its own data.

These are the tasks you perform to define an ABL class:

 1. Determine the package name.
 2. Determine the class name.
 3. Create the class file.
 4. Define the following parts of the class:
    - Data members
    - Constructors
    - Methods
    - Destructor
	
	
## 1. Determine the package name
A package is a directory path in wich a class file is located. ABL uses the PROPATH and the package to locate your classes.

## 2. Determine the class name.
The name of a class should represent its purpose. It must begin with a letter and it can contain letters, numbers, underscores, or hyphens. It must not contain spaces or periods. The name of the class must be the same as the name of the file with the .cls extension that contains the class definition.

## 3. Create the class file.
Use the `New ABL Class` wizard.

## 4. Parts of an ABL class definition

An ABL class consists of definitions of *data members*, definitions and implementations of *constructors*, *methods*, and a *destructor*. 

Constructors are used to *create class instances at runtime*.

Destructors *cleans up* resources when a class instance is deleted.



### Data members of a class

Data members of a class are used to hold run-time values for a class instace. Whenever an instance of a class is  created, each instance has its own values for the data members of the class.
The values for the data members of a class instance are assigned when the instance is created or are assigned by the methods of the class.

*FOUR TYPES OF DATA MEMBERS:*

 - *VARIABLE*
    - Holds a value of a built-in type or user-defined type. A best practice is to define variables as *private* or *protected* so that they can only be accessed by methods of the class.
 - *PROPERTY*
    - Holds a value of a built-in type or user-defined type. A property is like a variable, but it allows you to customize how its values will be read or set. A best practice is to define properties as *public* for reading and *private* or *protected* for setting. This enables you to control how data is accessed by code from other parts of your application.
 - *TEMP-TABLE*
    - Holds aggregate data such as database record in a relational database table. A temp-table typically holds data of multiple types. A best practice is to define a temp-table as *private*.
 - *DATASET*
    - Holds data that represent a set of temp-tables.
	
When you define a data member, you specify the type of access it will have at run time. The ABL provides the following access modes for data member and methods.

 - *PRIVATE* 
    - Limits access to the class.
 - *PACKAGE-PRIVATE*
    - Limits access to the class and any class within its package.
 - *PROTECTED*
    - Limits access to the class and subclasses of the class.
 - *PACKAGE-PROTECTED*
    - Limits access to the class, any class within its package, and to any subclass that inherits from the class.
 - *PUBLIC*
    - Accessible to all.
	

### Define a data member as a variable 

Defining a variable for a class is similar to defining a variable for a procedure. The *main difference* is the *access-mode* you specify for the variable.

Syntax: 

```
DEFINE <ACCESS-MODE> VARIABLE <VARIABLE NAME> AS <TYPE-NAME> [NO-UNDO].
```

Where 
 - *ACCESS-MODE*: private, package-private, protected, package-protected or public. Best practice: private or protected.
 - *VARIABLE-NAME*: Must begin with a letter and it can contain letters, numbers, underscores, or hyphens.
 - *TYPE-NAME*: Can be one of the ABL data types.
 - *NO-UNDO*: *No-undo* is recommended for all variable definitions, regardless of where they are used. If you use *no-undo*, the value of the variable is not restored to its original value in the event of a transaction rollback.
 
*Note:* If you do not specify an access mode, the default access mode for a variable is private.


### Define a data member as a property

You define a property the same way you define a variable, except that you use the keyword *property*. 
In addition, you need to specify the *get* and *set* accessors for the property. Optionally, you can customize the behavior of the `get()` and `set()` accessors methods.

*Note:* You must define get() before set(), otherwise your code will not compile.

Syntax:

```
define[<access-mode>] property <property-name> as <type-name> [no-undo]
<access-mode> get 
    [(): <body of get that returns property> end get].
<access-mode>] set
    [(<parameter>): <body of set that sets property> end set].
```


## Class constructors

A class constructor is a _special_ method that creates an _instance_ _of_ _a_ _class_. The constructors returns an instance of the class. A best practice is to define the constructor as *public* so that other parts of the application can create instances of the class.

A class *can have more than one constructor*, each with a different parameter list. This is useful when you need to create instances in different ways for different parts of the application.

You can use the *New Constructor* wizard to generate the code for a constructor (right-click, then select *Source > New Constructor*).

*Note:* If you use the *New Constructor* wizard to generate the constructor, the first statement that is generated is the call to *super()*. This means the constructor for the super class will be called first. It is safe to keep this statement in your constructor, even if you have not defined a super class.

## Class methods

Class methods are used to perform the behavior and functionality of the class. When a class instance is created, memory is allocated for the data members of the instance. The methods for the class operate on the data members of the class instance. Some methods are private or protected and can only be called by other methods in the class. Other methods in a class may be public, in which case they can be called by other parts of the application.

Syntax:

```
method [access-mode] {<return-type> | void } <method-name> 
( [<parameter-use> <parameter> as <type-name> ][,…]): 
   <body of method>
   return [return-value].
end method.
```

Where 
 - *ACCESS-MODE*: private, package-private, protected, package-protected or public. Best practice: private or protected.
 - *RETURN-TYPE*: Can be a built-in or user-defined type. If void is specified, the method returns no value.
 - *PARAMETER-USE*: Can be one of input, output or input-output.
 - *PARAMETER*: The name for the parameter.
 - *TYPE-NAME*: Can be one of the ABL data types.
 - *BODY OF METHOD*: The ABL code necessary to implement the functionality of the method. If the method specifies a return type, the body of the method must be written to return a valu of the return type specified in the definition of the method.
 - *RETURN-VALUE*: If the method returns a value, the value must match the type specified for return-type.
 
 *Note:* If you do not specify an access mode, the *default* access mode for a method is *public*.
 
## Class destructor 
 
Here is the simplified syntax for defining a destructor for a class: 
 
```
destructor public <class-name> ():
  <body of destructor>
end destructor.
```
 
Where 
 - *CLASS-NAME*: Must match the name of the class in the class definition.
 - *BODY OF DESTRUCTOR*: The ABL code necessary to implement the functionality of the destructor.

