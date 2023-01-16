
/*------------------------------------------------------------------------
    File        : testDept2.p
    Purpose     : 

    Syntax      :

    Description : Test the Dept Class (with inheritance)

    Author(s)   : 
    Created     : Tue Aug 16 09:06:05 EDT 2016
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

block-level on error undo, throw.
using Progress.Lang.*.
using Enterprise.HR.Emp.
using Enterprise.HR.Dept.
using Enterprise.HR.Role.Manager.
using Enterprise.HR.Role.TeamMember.

define variable DeptInstance as Dept no-undo.
define variable DeptInstance2 as Dept no-undo.
define variable EmpInstance as TeamMember no-undo.
define variable RetrievedEmp as Emp  no-undo.

define variable Phones as character extent 3 no-undo.

{include\ttEmployee.i}


/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

output to /progress_education/openedge/IntroOOP/log/testDept2.out.

/* create a Deptinstance using hard-coded values for initializing it */
DeptInstance = new Dept("Training",
                      "500",
                      "PROGRESS-3947").

for each Employee where Employee.Dept = "500" by Employee.EmpNum:
   // DeptMgr will be the first object created for the department
            // DeptMgr will always be instanted when a TeamMember is created
             assign
              Phones[1] = Employee.WorkPhone
              Phones[3] = Employee.HomePhone
              .
            if valid-object(DeptInstance:DeptMgr)
            then 
              do:                
                 EmpInstance = new TeamMember(DeptInstance:DeptMgr).
                 EmpInstance:Initialize(Employee.EmpNum,
                               Employee.FirstName,
                               Employee.LastName,
                               Employee.Address,
                               Employee.PostalCode,
                               Phones,
                               Employee.VacationDaysLeft * 8,
                               Employee.Position).
                 DeptInstance:AddEmployee (EmpInstance). 
                 DeptInstance:DeptMgr:AddTeamMember(EmpInstance). 
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
        /* New department */
        DeptInstance2 = new Dept("Facilities",
                                 "1000",
                                 "PROGRESS-8354"
                                 ).

message "******** Test AddManager *********".
assign
   Phones[1] = "111-111-1111"
   Phones[2] = "222-222-2222"
   Phones[3]= "333-333-3333"
   .
message   "Before adding employee, number of employees is: " DeptInstance2:NumEmployees.
             
        
        DeptInstance2:AddManager(999,
                                 "Jane",
                                 "Doe",
                                 "321 Main Street",
                                 "01730",
                                 phones,
                                 40,
                                 "Manager").
       message "After adding manager to the Facilities Department, number of employees is: " DeptInstance2:NumEmployees.
                                 
        retrievedEmp = DeptInstance2:GetEmployee("Jane", "Doe").  
        if valid-object(retrievedEmp)
        then
        do:
             message retrievedEmp:GetInfo()  skip.
             if valid-object(DeptInstance2:DeptMgr) 
             then         
               message " Examining DeptMgr instance: "  DeptInstance2:DeptMgr:GetInfo(). 
        end.

message "******** test AddEmployeeWithTeamMemberInstance ********".

 /* Add an employee to the "Training" department */
      message
             "************testAddTeamMemberWithEmpInstance()************" skip
             "Before adding employee, number of employees is: " DeptInstance:NumEmployees.
        EmpInstance = new TeamMember(DeptInstance:DeptMgr).
        EmpInstance:Initialize(9999,    
                            "John",
                            "Doe",
                            "123 Main Street",
                            "01730",
                            phones,
                            50,
                           "Senior Developer"). 
         DeptInstance:AddEmployee(EmpInstance). 
         
         message "After adding employee, number of employees is: " DeptInstance:NumEmployees.
         retrievedEmp = DeptInstance:GetEmployee("John", "Doe").  
       
        if valid-object(retrievedEmp)
        then
             message retrievedEmp:GetInfo() .
       
       /* now add an employee to the "Facilities" department */
          message
             "************testAddTeamMemberWithEmpInstance()************" skip
             "Before adding employee, number of employees is: " DeptInstance2:NumEmployees.
        EmpInstance = new TeamMember(DeptInstance2:DeptMgr).
        EmpInstance:Initialize(99999,
                            "James",
                            "Doe",
                            "123 Main Street",
                            "01730",
                            phones,
                            50,
                           "Senior Developer"). 
         DeptInstance2:AddEmployee(EmpInstance). 
         
         message "After adding employee, number of employees is: " DeptInstance2:NumEmployees.
         retrievedEmp = DeptInstance2:GetEmployee("James", "Doe").  
       
        if valid-object(retrievedEmp)
        then
             message retrievedEmp:GetInfo() .
/* delete the Department instances*/
delete object DeptInstance.
delete object DeptInstance2.
output close.                    