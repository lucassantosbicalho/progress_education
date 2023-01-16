 
 /*------------------------------------------------------------------------
    File        : Dept
    Purpose     : 
    Syntax      : 
    Description : Information for a department
                  Holds information about the employees in this department

    Author(s)   : Admin
    Created     : Sat Sep 19 08:30:31 EDT 2015
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
using Enterprise.HR.Role.TeamMember.
using Enterprise.HR.Role.Manager.
using Enterprise.HR.Emp.

block-level on error undo, throw.

class Enterprise.HR.Dept: 
    
 	define public property DeptName as character no-undo 
	get.
	private set. 
  
    define public property DeptCode as character no-undo 
    get.
    private set. 
    
    define public property ExpenseCode as character no-undo 
    get.
    private set.
    
    define public property NumEmployees as integer no-undo
    get.
    private set. 
    
    define public property DeptMgr as Manager no-undo
    get.
    private set.
 
    {include\ttEmployee.i &ClassAccess = "private"}
	
	constructor public Dept (input pDeptName as character,
	                         input pDeptCode as character,
	                         input pExpenseCode as character  ):
		
		super ().
		assign
          DeptName = pDeptName
          DeptCode = pDeptCode
          ExpenseCode = pExpenseCode
        .       
                                                 
	end constructor.


	method public void AddEmployee( input pEmployee as Emp ):
		 create ttEmployee.
		 assign
          ttEmployee.FirstName = pEmployee:FirstName
          ttEmployee.LastName = pEmployee:LastName
          ttEmployee.EmpRef = pEmployee
          NumEmployees = NumEmployees + 1
        .  

		return.
    end method.
    

    method public void AddManager( input pEmpNum as integer,
                                    input pFirstName as character,
                                    input pLastName as character,
                                    input pAddress as character,
                                    input pPostalCode as character,
                                    input pPhones as character extent 3,
                                    input pVacationHours as integer,
                                    input pJobTitle as character  ):
        define variable Empl as Manager no-undo.
        assign
           Empl = new Manager()
           DeptMgr = Empl
           .
        Empl:Initialize(pEmpNum, pFirstName,pLastName,pAddress,pPostalCode,
                       pPhones,pVacationHours,pJobTitle).
        create ttEmployee.
        assign
          ttEmployee.FirstName = pFirstName
          ttEmployee.LastName = pLastName
          ttEmployee.EmpRef = Empl
          NumEmployees = NumEmployees + 1
        .  
        
 
        return.

    end method.
  
  method public void AddTeamMember( input pEmpNum as integer,
                                    input pFirstName as character,
                                    input pLastName as character,
                                    input pAddress as character,
                                    input pPostalCode as character,
                                    input pPhones as character extent 3,
                                    input pVacationHours as integer,
                                    input pJobTitle as character  ):
        define variable Empl as TeamMember no-undo.
        Empl = new TeamMember(DeptMgr).
        Empl:Initialize(pEmpNum, pFirstName,pLastName,pAddress,pPostalCode,
                       pPhones,pVacationHours,pJobTitle).
        DeptMgr:AddTeamMember(Empl).
        create ttEmployee.
        assign
          ttEmployee.FirstName = pFirstName
          ttEmployee.LastName = pLastName
          ttEmployee.EmpRef = Empl
          NumEmployees = NumEmployees + 1
        .  
        
 
        return.

    end method.

	method public Emp GetEmployee( input pFirstName as character,
	                               input pLastName as character ):
				
        find first ttEmployee where ttEmployee.FirstName = pFirstName and
                                    ttEmployee.LastName = pLastName.
        if available(ttEmployee)
          then              
             return cast(ttEmployee.EmpRef,Emp).        
          else
              return ?.	
	end method.

    	
	method public void GetEmployees(output table ttEmployee): 
   // this method simply returns the current ttEmployee temp-table
    end method.
       
	destructor public Dept ( ):
       for each ttEmployee:        
           delete object cast(ttEmployee.EmpRef,Emp).
           delete ttEmployee.
       end.
	end destructor.

end class.