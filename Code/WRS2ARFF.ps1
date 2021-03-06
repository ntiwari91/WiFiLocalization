Set-StrictMode -Version 1

function reWriteHeader()
{
        Write-Host "RE-Writing header."

        # This function will read through the data looking for unique Room names, computer names and unique BSSIDs.
        # It will then rewrite the  header to include them as nominal values.
        $global:header_is_written = $true
        $global:outputPath = $global:outputFolder + $global:outputFile 
        $global:fileData = Get-Content $global:outputPath
		
		
   $header = @(
       "@relation tm450",
	   "@attribute iterations",
        "@attribute RSSI integer [0,100]",
        "@data")


   # Write the header information
   Out-File $global:outputPath -Encoding ASCII

   # Write the data back to the file
   Write-Host "RE-Writing Data."
   $global:fileData | Out-File $global:outputPath -Append -Encoding ASCII
}            



function scanWAPs()
{
   if ($global:header_is_written)
   { 
       # Collect together the MAC addresses with their
       # corresponding Signal Strengths as one READING
       for ($iter=1; $iter -le $global:maxIter; $iter++)
       {
           $wlanData = @()
           # Get the data
           if ($global:runningLocally)
           {
                $wlanData = netsh wlan show networks mode=bssid
           }
           else
           {
                $wlanData = Invoke-Command -ComputerName $global:computer -ScriptBlock{netsh wlan show networks mode=bssid}
           }
           
           if ($wlanData -eq $null)
           {
                Write-Host
                Write-Host "No WLAN data available."
                Write-Host "   Are you trying to check a non-domain registered computer?"
                Write-Host "   Does the remote computer have a wireless network connection?"
                Write-Host "   Is the remote computer accepting connections?"
                Write-Host
                Write-Host "Program END"
                exit
           }
           

           # Collect the lines that contain the MAC addresses
           $bssid = $wlanData -match "BSSID"

           # Collect the lines that contain the Signal Strengths
           $rssi = $wlanData -match "Signal"

           # Extract the Signal Strengths
           $a = [regex]::split($rssi," ")
           $b = [regex]::split($a,"Signal")
           $rssi = [regex]::split($b,":")
           $c = ""
           $rssi|foreach{ $c = $c + $_.Trim() + "*"}
           $c = $c.Trim("*")
           $rssi = $c.Split("*")
           # Trim off any leading or trailing spaces and %'s.
           $rssi = $rssi | foreach-object {$_.trim(" %")}

           # Extract the MAC addresses
           $c2 = ""
           $bssid|foreach{ $c2 = $c2 + $_.Substring($_.Length-17,17)+" "}
           $c2 = $c2.Trim()
           $bssid = $c2.Split()
                       
           # WRITE THE DATA TO THE OUTPUT FILE
           Write-Host "Writing data sample : $iter"
           for($i=0; $i -lt $bssid.count; $i++)
           {   
               "$iter" +" "+$global:sector+" "+"$global:computer" +" "+ $global:room+" "+$bssid[$i]+" "+$rssi[$i] | Out-File $global:outputPath -Append -Encoding ASCII
           }
           Start-Sleep -s $global:delay
           
           if (($iter % $global:headerNreadings) -eq 0 ) { reWriteHeader }
       }
        
       # Rewrite the Header based on seen AP MACs (BSSID) and Room names
       reWriteHeader
   }
   else
   {
       Write-Host "Auto writing  header."
       writeheader
       scanWAPs
   }
}
    




function writeheader()
{
   $global:header_is_written = $true
   $global:outputPath = $global:outputFolder + $global:outputFile 
   
   #Create the actual file
   New-Item $global:outputPath -ItemType file -force
   
   # header information
   $header = @(
   "@relation tm450",
   "@attribute ITERATION {}",
   "@attribute COMPUTER {}",
   "@attribute ROOM {}",
   "@attribute BSSID {}",
   "@attribute RSSI integer [0,100]",
   "@data")
   
   # Write the header information
   Out-File $global:outputPath -Encoding ASCII
   Write-Host "Writing  header."
}


function mainMenu()
{
    Write-Host
    Write-Host
    Write-Host "============";
    Write-Host "= MAINMENU =";
    Write-Host "============";
    Write-Host "'NAME n' to set room name. ( $global:room )"
    Write-Host "'NUMBER n' where n is the number of scans to perform in this room. ($global:maxIter)"
    Write-Host "'DELAY t' where t is the time in seconds between scans in this room. ($global:delay)"
    Write-Host "'HEADER n' write the header every n readings.($global:headerNreadings)"
    Write-Host "'COMPUTER c' to gather readings from the target computer c ($global:computer)"
    Write-Host "'SCAN' to perform the scan of this room."
    Write-Host "'CLEAR' to clear the existing output file upon next scan."
    Write-Host "'PATH p' to set the output path p of the output file. ($global:outputFolder)"
    Write-Host "'FILE f' to set the output filename f of the output file($global:outputFile)"
	Write-Host "'SECTOR s' to set the location of computer c ($global:sector)"
    Write-Host "'QUIT' to quit this session."
}



####################### MAIN SCRIPT STARTS HERE ################################################

$global:computer = $env:ComputerName
$global:room ="GCL-I"
$global:outputFolder = "C:\Users\Ujjwal\Documents\MATLAB\Wireless\Demo\"
$global:outputFile = "demo-1"
$global:outputPath = $global:outputFolder + $global:outputFile 
$global:maxIter = 10
$global:delay = 3
$global:sector = 1
$global:header_is_written = $true
$global:fileData = @()
$global:uniqueCOMPUTERs = @{}
$global:uniqueBSSIDs = @{}
$global:uniqueROOMs = @{}
$global:thisCOMPUTER = ""
$global:thisROOM = ""
$global:thisBSSID = ""
$global:headerNreadings = 500
$global:runningLocally = $true


do
{
    mainMenu
    $input = Read-Host "Enter an option "
    $verb = $input.split()[0]
    $noun = $input.split()[1]
    switch ($verb)
    {
        "NAME"
        {
           # Set ROOM name
           $global:room = $noun
           Write-Host
           Write-Host "Room name set to " $global:room
        }
       
        "NUMBER"
        {
           # Set number of reading for this scan
           $global:maxIter = $noun
           Write-Host
           Write-Host "Maximum readings for this scan set to " $global:maxIter
           
        }
       
        "DELAY"
        {
           # Set delay between scans
           $global:delay = $noun
           Write-Host
           Write-Host "Delay between reading set to" $global:delay
           
        }
        
		"SECTOR"
		{
			# Set location of computer
			$global:sector = $noun
			Write-Host
			Write-Host "Location set to sector" $global:sector
		}
        "HEADER"
        {
           #  Write the header every n readings
           $global:headerNreadings = $noun
            
        }
       
        "SCAN"
        {
           # Perform $global:maxIter readings with $global:delay seconds between them NOW
            scanWAPs
        }
        
        "COMPUTER"
        {
            # Targets a specific computer to take readings from
            $global:computer = $noun
            if ($noun -eq $env:computername)
            {
                $global:runningLocally = $true
            }
            else
            {
                $global:runningLocally = $false
            }
            
        }
        
       
       "CLEAR"
        {
           # Make sure next write to file starts afresh and clears old data.
            $global:header_is_written = $false
           Write-Host "Clearing existing output file."
        }
		
		"FILE"
		{	# Set File name
			$global:outputFile = $noun
			Write-Host
			Write-Host "File name has changed to" $global:outputFile
		}
		
		
        "QUIT"
        {
            # nothing
        }
       
        default
        {
           Write-Host
           Write-Host "Invalid input. Please enter a valid option.";
           Write-Host
        }
    }
} until ($input -eq "QUIT");
Write-Host
Write-Host
Write-Host "Program END."
