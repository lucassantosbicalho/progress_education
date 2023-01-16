
/*------------------------------------------------------------------------
    File        : testCompany.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Mon Aug 29 14:58:30 IST 2016
    Notes       :
  ----------------------------------------------------------------------*/
using Progress.Lang.*.
using Enterprise.BusinessUnit.Company.
using Enterprise.HR.Dept.
using Enterprise.HR.Role.Manager.
using Enterprise.HR.Role.TeamMember.


block-level on error undo, throw.

define variable CompanyInstance as Company no-undo.
      define  variable DeptInstance as Dept no-undo.
     
      define  variable TeamMemberInstance as TeamMember no-undo.
       define variable CorpID as character no-undo initial "PROGRESS".
define variable Phones as character extent 3 no-undo.




CompanyInstance = new Company("Sports3000").

output to /progress_education/openedge/IntroOOP/log/testCompany.out.

        message "*********** testAddDepartment  ************************" skip.
         for each Department:
            DeptInstance = new Dept(Department.DeptName,
                                    Department.DeptCode,
                                    CorpID + "-" + Department.DeptCode).
            CompanyInstance:AddDepartment(DeptInstance).
            
           
            /* add employees to the department */
            for each Employee where Employee.Dept = Department.DeptCode by Employee.EmpNum:
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
                 TeamMemberInstance = new TeamMember(DeptInstance:DeptMgr).
                 TeamMemberInstance:Initialize(Employee.EmpNum,
                               Employee.FirstName,
                               Employee.LastName,
                               Employee.Address,
                               Employee.PostalCode,
                               Phones,
                               Employee.VacationDaysLeft * 8,
                               Employee.Position).
                 DeptInstance:AddEmployee (TeamMemberInstance). 
                 DeptInstance:DeptMgr:AddTeamMember(TeamMemberInstance). 
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
            message 
               "Number of Departments are: "  CompanyInstance:NumDepartments skip.
            end.
       
       message "********** Departements:" skip.
       DeptInstance = CompanyInstance:GetDepartment("300").
           message DeptInstance:DeptName.
        DeptInstance = CompanyInstance:GetDepartment("500").
           message DeptInstance:DeptName.          
        
       
    
    message "*********** testGetDepartment  ************************" skip.
        DeptInstance = CompanyInstance:GetDepartment("300").        
        message
            "Department name for dept code 300 is: " DeptInstance:DeptName skip.
        DeptInstance = CompanyInstance:GetDepartment("500").        
        message
            "Department name for dept code 500 is: " DeptInstance:DeptName skip.
       
       
        message "*********** testNumberEmployees  ************************" skip.
        message
            "Total number of employees for this company is: " CompanyInstance:NumberEmployees().
       
         
    delete object CompanyInstance.
    output close.
    