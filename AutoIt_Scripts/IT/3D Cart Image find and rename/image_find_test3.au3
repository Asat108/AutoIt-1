

Func RecursiveFileSearch($RFSstartDir, $RFSFilepattern = ".", $RFSFolderpattern = ".", $RFSFlag = 0, $RFSrecurse = true, $RFSdepth = 0)
    
   ;Ensure starting folder has a trailing slash
     If StringRight($RFSstartDir, 1) <> "\" Then $RFSstartDir &= "\"

     If $RFSdepth = 0 Then
       ;Get count of all files in subfolders for initial array definition
         $RFSfilecount = DirGetSize($RFSstartDir, 1)
        
       ;File count + folder count (will be resized when the function returns)
        If IsArray($RFSfilecount) Then 
            Global $RFSarray[$RFSfilecount[1] + $RFSfilecount[2] + 1]
        Else
            SetError(1)
            Return
        EndIf
     EndIf
    
     $RFSsearch = FileFindFirstFile($RFSstartDir & "*.*")
     If @error Then Return

   ;Search through all files and folders in directory
     While 1
         $RFSnext = FileFindNextFile($RFSsearch)
         If @error Then ExitLoop
        
       ;If folder and recurse flag is set and regex matches
         If StringInStr(FileGetAttrib($RFSstartDir & $RFSnext), "D") Then
            
             If $RFSrecurse AND StringRegExp($RFSnext, $RFSFolderpattern, 0) Then
                 RecursiveFileSearch($RFSstartDir & $RFSnext, $RFSFilepattern, $RFSFolderpattern, $RFSFlag, $RFSrecurse, $RFSdepth + 1)
                 If $RFSFlag <> 1 Then
                   ;Append folder name to array
                     $RFSarray[$RFSarray[0] + 1] = $RFSstartDir & $RFSnext
                     $RFSarray[0] += 1
                 EndIf
             EndIf
         ElseIf StringRegExp($RFSnext, $RFSFilepattern, 0) AND $RFSFlag <> 2 Then
           ;Append file name to array
             $RFSarray[$RFSarray[0] + 1] = $RFSstartDir & $RFSnext
             $RFSarray[0] += 1
         EndIf
     WEnd
     FileClose($RFSsearch)

     If $RFSdepth = 0 Then
         Redim $RFSarray[$RFSarray[0] + 1]
         Return $RFSarray
     EndIf
EndFunc ;==>RecursiveFileSearch