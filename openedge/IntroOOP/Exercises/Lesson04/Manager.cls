 
 /*------------------------------------------------------------------------
    File        : Manager
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Admin
    Created     : Tue May 03 15:10:20 EDT 2016
    Notes       : 
  ----------------------------------------------------------------------*/


block-level on error undo, throw.

using Enterprise.HR.Emp from propath.
using Enterprise.HR.Role.Manager from propath.
using Enterprise.HR.Role.TeamMember from propath.

class Enterprise.HR.Role.Manager inherits Emp: 
   
        {include\ttEmployee.i &ClassAccess = "private"}
    
    
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
        
    constructor public Manager (  ):
        super ().
        EmpType = "Manager".
    end constructor.
    
     method public void AddTeamMember(input ptm as TeamMember):
        create ttEmployee.
        assign
          ttEmployee.FirstName = ptm:FirstName
          ttEmployee.LastName = ptm:LastName
          ttEmployee.EmpRef = ptm
        .  
    end method.
    
    method public void GetManagersEmployees(output table ttEmployee): 
      end method.
    
    method public override character GetInfo(  ):
        
        define variable result as character no-undo.
        result = super:GetName() + ", Manager " + 
                  Address + " " + PostalCode + " " +
                  "Job Title: " + JobTitle + " " +
                  "Vacation Hours: " + string(VacationHours).
        return result.

    end method.
    
         
    destructor public Manager ( ):
        for each ttEmployee:           
           delete ttEmployee.
       end.
    end destructor.

end class.