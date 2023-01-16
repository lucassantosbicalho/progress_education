
/*------------------------------------------------------------------------
    File        : ttEmployee.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Mon Apr 25 12:06:09 EDT 2016
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */


/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

define {&ClassAccess} temp-table ttEmployee no-undo
    field FirstName              as character
    field LastName               as character
    field EmpRef               as Progress.Lang.Object
    index idxLastName is word-index LastName. 