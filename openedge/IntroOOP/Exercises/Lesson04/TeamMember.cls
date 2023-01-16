 
 /*------------------------------------------------------------------------
    File        : TeamMember
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Admin
    Created     : Tue May 03 16:32:57 EDT 2016
    Notes       : 
  ----------------------------------------------------------------------*/
using Progress.Lang.*.
using Enterprise.HR.Emp.
using Enterprise.HR.Role.TeamMember.
using Enterprise.HR.Role.Manager.

block-level on error undo, throw.


class Enterprise.HR.Role.TeamMember inherits Emp: 
    
  define private property Mgr as Manager no-undo 
    get.
    set. 
          
    constructor public TeamMember ( input pMgr as Manager ):
        super ().
        assign
           EmpType = "TeamMember"
           Mgr = pMgr
           .
    end constructor.

    method public Manager GetManager(): 
      return Mgr.  
    end method.
 
   method public override character GetInfo(  ):
        
        define variable result as character no-undo.
        result = super:GetName() + ", Team Member " + 
                  Address + " " + PostalCode + " " +
                  "Job Title: " + JobTitle + " " +
                  "Vacation Hours: " + string(VacationHours).
        return result.

    end method.

end class.