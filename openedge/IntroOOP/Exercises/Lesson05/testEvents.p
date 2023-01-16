
/*------------------------------------------------------------------------
    File        : testEvents.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Wed Sep 07 15:06:28 IST 2016
    Notes       :
  ----------------------------------------------------------------------*/
using Progress.Lang.*.
using Enterprise.HR.Dept.
using Enterprise.HR.Role.Manager.
using Enterprise.HR.Role.TeamMember.


block-level on error undo, throw.

define  variable DeptInstance as Dept no-undo.
define  variable DepartmentManagerInstance as Manager no-undo.
    define variable tm as TeamMember no-undo.
    define variable Phones as character extent 3 no-undo.
    
{include\ttEmployee.i }
   
        output to /progress_education/openedge/IntroOOP/log/testDeptWithEvent.out.
        
        DeptInstance = new Dept("Training",
                                "500",
                                "PROGRESS-3947"
                                ).
                    for each Employee where Employee.Dept = "500" by Employee.EmpNum:
            // want first employee of every dept to be the manager
            // DeptMgr will be the first object created for the department
            // DeptMgr will always be instanted when a TeamMember is created
             assign
              Phones[1] = Employee.WorkPhone
              Phones[3] = Employee.HomePhone
              .
            if valid-object(DeptInstance:DeptMgr)
            then 
              do:                
                 tm = new TeamMember(DeptInstance:DeptMgr).
                 tm:Initialize(Employee.EmpNum,
                               Employee.FirstName,
                               Employee.LastName,
                               Employee.Address,
                               Employee.PostalCode,
                               Phones,
                               Employee.VacationDaysLeft * 8,
                               Employee.Position).
                 DeptInstance:AddEmployee (tm). 
                 DeptInstance:DeptMgr:AddTeamMember(tm). 
              end.
            else 
               do:
                  DeptInstance:AddManager(Employee.EmpNum,
                                  Employee.FirstName,
                                  Employee.LastName,
                                  Employee.Address,
                                  Employee.PostalCode,
                                  Phones,
                                  Employee.VacationDaysLeft * 8,
                                  Employee.Position).
               end.
           end.                 
                                
                                
                                
        message "*************testDischargeEmployeeEvent()**************" skip.
        message "Number of employees before the discharge: " DeptInstance:NumEmployees skip.
        /* discharge an employee */
        DepartmentManagerInstance = DeptInstance:DeptMgr.
        DepartmentManagerInstance:DischargeTeamMember("Harold", "Tedford").
        message "Number of employees after the discharge: " DeptInstance:NumEmployees skip.

delete object DeptInstance.
/*delete object DepartmentManagerInstance.
delete object EmpInstance.*/
output close.
      