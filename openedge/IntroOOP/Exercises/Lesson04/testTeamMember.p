
/*------------------------------------------------------------------------
    File        : testTeamMember.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Thu Aug 18 16:51:43 EDT 2016
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
define variable EmpInstance as Emp no-undo.
define variable Phones as character extent 3
          initial ["111-111-1111","222-222-2222","333-333-3333"] no-undo.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

MgrInstance = new Manager().
MgrInstance:Initialize(999,
                                 "Jane",
                                 "Doe",
                                 "321 Main Street",
                                 "01730",
                                 Phones,
                                 40,
                                 "Manager").
       
output to /progress_education/openedge/IntroOOP/log/testTeamMember.out.
          
message "************  test AddTeamMember  and GetManger ***************".
 
TMInstance = new TeamMember(MgrInstance).
       
TMInstance:Initialize(9999,
                                 "John",
                                 "Doe",
                                 "321 Main Street",
                                 "01730",
                                 Phones,
                                 40,
                                 "Developer").
                                                  
MgrInstance:AddTeamMember(TMInstance).
    
 
EmpInstance = TMInstance:GetManager().
        
message
              "Manager of this TeamMember is: " EmpInstance:GetInfo().
               
       
delete object MgrInstance.
delete object TMInstance.

output close.