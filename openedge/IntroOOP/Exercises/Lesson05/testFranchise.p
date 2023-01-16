
/*------------------------------------------------------------------------
    File        : testFranchise.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : 
    Notes       :
  ----------------------------------------------------------------------*/
using Progress.Lang.*.
using Enterprise.BusinessUnit.Franchise.
using Enterprise.HR.Dept.
using Enterprise.HR.Role.Manager.
using Enterprise.HR.Role.TeamMember.

block-level on error undo, throw.
    
      define  variable FranchiseInstance as Franchise no-undo.
      define  variable DeptInstance as Dept no-undo.
      define  variable TeamMemberInstance as TeamMember no-undo.     
      define  variable CorpID as character no-undo initial "PROGRESS".
      define variable phoneNumbers as character extent 3 no-undo.
      
// This franchise has only 2 departments
        FranchiseInstance = new Franchise("TennisPros", 2).
        
output to /progress_education/openedge/IntroOOP/log/testFranchise.out.
        message "*********** testAddDepartment  ************************" skip.
        // grab data from the sports2020 database for the 2 departments
        for each Department where Department.DeptCode = "200" or Department.DeptCode = "400":
            DeptInstance = new Dept(Department.DeptName,
                                    Department.DeptCode,
                                    CorpID + "-" + Department.DeptCode).
            FranchiseInstance:AddDepartment(DeptInstance).
            
           
            /* add employees to the department */
            for each Employee where Employee.Dept = Department.DeptCode by Employee.EmpNum:
            // want first employee of every dept to be the manager
            // DeptMgr will be the first object created for the department
            // DeptMgr will always be instanted when a TeamMember is created
             assign
              phoneNumbers[1] = Employee.WorkPhone
              phoneNumbers[3] = Employee.HomePhone
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
                               phoneNumbers,
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
                                  phoneNumbers,
                                  Employee.VacationDaysLeft * 8,
                                  Employee.Position).        
               end.
           end.    
            message 
               "Number of Departments are: "  FranchiseInstance:NumDepartments skip.
            end.
       
       message "********** Departments:" skip.
       DeptInstance = FranchiseInstance:GetDepartment("200").
           message DeptInstance:DeptName.
        DeptInstance = FranchiseInstance:GetDepartment("400").
           message DeptInstance:DeptName.          

message "*********** testGetDepartment  ************************" skip.
        DeptInstance = FranchiseInstance:GetDepartment("200"). 
        message    
             "Department name for dept code 200 is: " DeptInstance:DeptName skip.
        DeptInstance = FranchiseInstance:GetDepartment("400").        
        message
            "Department name for dept code 400 is: " DeptInstance:DeptName skip.

message "*********** testNumberEmployees  ************************" skip.
        message
            "Total number of employees for this franchise is: " FranchiseInstance:NumberEmployees().
message "*********** testGetEmployeeList ************************" skip.
       
        message
            FranchiseInstance:GetEmployeeList().
       
       
       delete object FranchiseInstance.
        output close.
        
        