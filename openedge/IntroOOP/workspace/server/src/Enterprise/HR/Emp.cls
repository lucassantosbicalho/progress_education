 
 /*------------------------------------------------------------------------
    File        : Emp
    Purpose     : 
    Syntax      : 
    Description : Try It 2.1: Define classes
    Author(s)   : lucas.santos
    Created     : Tue Jan 17 14:22:34 BRST 2023
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Enterprise.HR.Emp: 

    DEFINE PUBLIC PROPERTY Adress AS CHARACTER NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY EmpNum AS CHARACTER NO-UNDO 
    GET.
    PRIVATE SET. 

    DEFINE PUBLIC PROPERTY FirstName AS CHARACTER NO-UNDO 
    GET.
    PRIVATE SET. 

    DEFINE PUBLIC PROPERTY JobTitle AS CHARACTER NO-UNDO 
    GET.
    PRIVATE SET. 

    DEFINE PUBLIC PROPERTY LastName AS CHARACTER NO-UNDO 
    GET.
    PRIVATE SET.     

    DEFINE PUBLIC PROPERTY Phones AS CHARACTER EXTENT 3 NO-UNDO 
    GET(INPUT idx AS INTEGER):
         RETURN Phones[idx].
    END GET.
    SET(INPUT arg AS CHARACTER, INPUT idx AS INTEGER):
        Phones[idx] = arg.        
    END SET.

    DEFINE PUBLIC PROPERTY PostalCode AS CHARACTER NO-UNDO 
    GET.
    SET(INPUT arg AS CHARACTER):
                
    END SET.

    DEFINE PUBLIC PROPERTY VacationHours AS CHARACTER NO-UNDO 
    GET.
    PRIVATE SET. 

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    CONSTRUCTOR PUBLIC Emp (  ):
        SUPER ().
        
    END CONSTRUCTOR.
    
    
    /*
    method [access-mode] {<return-type> | void } <method-name> 
    ( [<parameter-use> <parameter> as <type-name> ][,…]): 
       <body of method>
       return [return-value].
    end method.
    */
    METHOD PUBLIC VOID Initialize (INPUT Adress AS CHARACTER, 
                                   INPUT EmpNum AS CHARACTER, 
                                   INPUT FirstName AS CHARACTER, 
                                   INPUT JobTitle AS CHARACTER, 
                                   INPUT LastName AS CHARACTER,
                                   INPUT Phones AS CHARACTER,
                                   INPUT PostalCode AS CHARACTER,
                                   INPUT VacationHours AS CHARACTER):
        
    END METHOD. 
    
    METHOD PUBLIC VOID SetVacationHours (INPUT pHours AS INTEGER):
        
    END METHOD.
    
    METHOD PUBLIC VOID SetJobTitle (INPUT pJobTitle AS CHARACTER):
        
    END METHOD.
    
    METHOD PUBLIC CHARACTER GetInfo():
    
    END METHOD.
    
    METHOD PRIVATE CHARACTER GetName():
        
    END METHOD.
    
    
END CLASS.