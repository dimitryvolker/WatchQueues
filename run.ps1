
Write-Host "-- Deleting old build"
Remove-Item -fo bin\*.*

Write-Host "Generating WatchQueues.prg"
monkeyc -o bin\WatchQueues.prg -f c:\Users\dimit\Development\WatchQueues\monkey.jungle -y c:\Users\dimit\Development\MonkeyC\keys\developer_key -d fr255_sim -w 

Write-Host "Running WatchQueues.prg"
monkeydo bin\WatchQueues.prg fr255