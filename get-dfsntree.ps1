# Define the namespace to search for DFSN folders
$Namespace = '\\graphisoft.hu\dev\*'

# Get the current date in the specified format
$date = Get-Date -Format "yyyyMMdd"

# Loop through each folder in the namespace
foreach ($folder in $Namespace)
{
    # Get all DFSN folders in the current folder
    $DFSNFolders = Get-DfsnFolder -Path $folder
    
    # Loop through each DFSN folder
    foreach ($DFSNFolder in $DFSNFolders)
    {
        # Get the DFS path
        $DFS = $DFSNFolder.Path
        
        # Get the DFS folder targets and select only the path, target path, and state properties
        $DFSTarget = Get-DfsnFolderTarget $DFS | Select Path, TargetPath, State
        
        # Export the results to a CSV file with a unique name based on the current date
        $DFSTarget | Export-Csv "c:\temp\DFS-$date.csv" -NoTypeInformation -Encoding UTF8 -Append
    }
}
