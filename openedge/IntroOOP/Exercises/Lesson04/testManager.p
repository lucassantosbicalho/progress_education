
/*------------------------------------------------------------------------
    File        : testManager.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : 
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

using Progress.Lang.*.
using Enterprise.HR.Emp.
using Enterprise.HR.Role.Manager.
using Enterprise.HR.Role.TeamMember.

block-level on error undo, throw.


    
define variable MgrInstance as Manager no-undo.
define variable TMInstance as TeamMember no-undo.
define variable TMInstance2 as TeamMember no-undo.
define variable Phones as character extent 3
          initial ["111-111-1111","222-222-2222","333-333-3333"] no-undo.
define variable httEmployee as handle no-undo.

    
{include\ttEmployee.i}
     

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

MgrInstance = new Manager().
MgrInstance:Initialize(999,
                                 "Jane",
                                 "Doe",
                                 "321 Main Street",
                                 "01730",
                                 phones,
                                 40,
                                 "Manager").
       
TMInstance = new TeamMember(MgrInstance).
       
TMInstance:Initialize(9999,
                                 "John",
                                 "Doe",
                                 "321 Main Street",
                                 "01730",
                                 phones,
                                 40,
                                 "Developer").
TMInstance2 = new TeamMember(MgrInstance).
        
TMInstance2:Initialize(9999,
                                 "James",
                                 "Doe",
                                 "321 Main Street",
                                 "01730",
                                 phones,
                                 40,
                                 "Developer").                                                 
       
output to /progress_education/openedge/IntroOOP/log/testManager.out.
       
message "************* test AddTeamMember ****************".
        
MgrInstance:AddTeamMember(TMInstance).
MgrInstance:AddTeamMember(TMInstance2).
             
httEmployee = temp-table ttEmployee:handle. 
empty temp-table ttEmployee no-error. 
        
MgrInstance:GetManagersEmployees(output table ttEmployee).
        
message
     "Employees under this manager: " skip.
  for each ttEmployee:
     message
       cast(ttEmployee.EmpRef,Emp):GetInfo()
     .
  end.
  
 delete object MgrInstance.
 delete object TMInstance.
 delete object TMInstance2.
      
 output close.