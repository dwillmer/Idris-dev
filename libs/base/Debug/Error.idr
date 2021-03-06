module Debug.Error

import Language.Reflection
import System

||| Terminate the program after printing a user-specified error message.
|||
||| @ loc     The source location to display for the error
||| @ message The error to print
partial export
error : {default (%runElab sourceLocation) loc : SourceLocation} ->
        (message : String) ->
        a
error {loc = FileLoc filename (line, col) _} message =
  believe_me . unsafePerformIO $ 
    do let place = filename ++ " line " ++ show line ++ " column " ++ show col
       let message' = place ++ ": " ++ message
       putStrLn message'
       exit 1

