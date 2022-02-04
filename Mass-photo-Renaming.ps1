#file renaming script
#By: Nathan Saunders
#written 04/02/2022
#version 1

#what the script does: renames seleted photos in a folder.

#Note:
#-no Error handling in script
#-no GUI

cls #clears screen

Write-Host "File Renaming Script" #title of the script
Write-Host " "#extra space
$rootpath = read-host "what is the root path of the files?" #path of folder where files are located
$common = Read-Host "what common letters in the filenames?" #used to select only the files to be modified
$split = Read-Host "what is the last Character Before the Number?" #what is the Character between the static and sequence part of the file
$type = ".jpg" #file type

$filelist = Get-ChildItem -Path $rootpath | select name #used to get the listing of files

cls #clears screen

#processing for each file
foreach ($file in $filelist) {

#cls #clears screen

#output to screen
$CName = $file | select name
Write-Host "processing started on $($CName.Name)"

    #if the file gets Modified 
    if ($CName.Name -Match $common){ 
        Write-Host "renaming $($CName.Name)"

        #isulating the sequence number
        $selectnumber=$($CName.Name).split("$split",2)
        $numberoutput=$selectnumber.split(".",2)[1]

        #building of the Full Filepath with file name
        $renamedFile = "2012-06-02-"+$numberoutput+"-Shannon and Trent's wedding"
        $path = $($rootpath)+"\"+$($CName.Name)
        $new = $renamedFile+$type
        Rename-Item -Path $path -NewName $new
        Write-Host "processing ended on $($CName.Name)"
}

#if the file is not to be renamed.
else {
Write-Host "skipping $($CName.Name)"
Write-Host "processing ended on $($CName.Name)"
continue
}

}

Write-Host "Script is Complete."