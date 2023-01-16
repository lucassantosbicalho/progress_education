 
 /*------------------------------------------------------------------------
    File        : Franchise
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Admin
    Created     : Fri May 06 10:33:48 EDT 2016
    Notes       : 
  ----------------------------------------------------------------------*/


block-level on error undo, throw.

using Enterprise.BusinessUnit.Franchise from propath.
using Enterprise.BusinessUnit.IBusinessUnit from propath.
using Enterprise.HR.Dept from propath.
using Enterprise.HR.Emp from propath.

class Enterprise.BusinessUnit.Franchise implements IBusinessUnit: 

    define public property Name as character no-undo 
    get.
    private set. 

    define public property NumDepartments as integer no-undo 
    get.
    private set. 
    
    define private variable Departments as Dept extent no-undo.
    
    // this temp-table is used to produce the list of employees
    {include\ttEmployee.i &ClassAccess = "private"}
    
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
        
    constructor public Franchise (input pFranchiseName as character, input pMaxNumDepartments as integer):
        super ().
         assign
         Name = pFranchiseName
         extent(Departments) = pMaxNumDepartments
          .  
     end constructor.
     
    method public void AddDepartment( input pDept as Dept ):        
        NumDepartments = NumDepartments + 1.
        Departments[NumDepartments] = pDept.
    end method.

    method public Dept GetDepartment( input pDeptCode as character ):
        define variable i as integer no-undo.
        do i = 1 to NumDepartments: 
           if Departments[i]:DeptCode = pDeptCode
              then return   Departments[i].   
        end.
        return ?.

    end method.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    
    method public integer NumberEmployees(  ):
        define variable i as integer no-undo.
        define variable iTotal as integer no-undo.
        
        do i = 1 to NumDepartments: 
           iTotal = Departments[i]:NumEmployees + iTotal.          
        end.
        return iTotal.
    end method.

   // adding an extra public method to this class
    method public character GetEmployeeList(): 
        define variable i as integer no-undo.
        define variable cList as character no-undo.
        define variable e as Emp no-undo.
        define variable httEmployee as handle no-undo.
        
        httEmployee = temp-table ttEmployee:handle. 
        do i = 1 to NumDepartments: 
            
            empty temp-table ttEmployee no-error. 
            Departments[i]:GetEmployees(output table ttEmployee).
           
            for each ttEmployee:
                e = cast(ttEmployee.EmpRef,Emp).
                cList = cList + e:FirstName + " " + e:LastName + ", ".
            end.      
        end.
        return cList.
    end method.
    
    destructor public Franchise ( ):
      /* delete all of the Department objects */
      define variable i as integer no-undo.
      do i = 1 to NumDepartments: 
          delete object Departments[i].
       end.
    end destructor.

end class.