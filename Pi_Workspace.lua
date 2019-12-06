--[[
https://github.com/mdiz/piDev.git -- gitHub clone URL

Recommended Settings for Windows For this book, the following environment variables are recommended on Windows systems: 

UTIL_DIR=c:\program files\utility 
LUA_DIR=c:\program files\lua\5.1 
LUA_CPATH=?.dll;%LUA_DIR%\?.dll 
LUA_PATH=?.lua;%LUA_DIR%\?.lua 



The UTIL_DIR variable identifies the utility directory you created in the preceding section. Additionally, 
if you have a software development kit and intend to compile Lua and possibly libraries for Lua, set the 
following environment variables: 

SDK_DIR=c:\program files\msc 
INCLUDE=%SDK_DIR%\include;%SDK_DIR%\include\usr 
LIB=%SDK_DIR%\lib;%SDK_DIR%\lib\usr

--prints the lua package paths from the table package
print("LUA MODULES:\n",(package.path:gsub("%;","\n\t")),"\n\nC MODULES:\n",(package.cpath:gsub("%;","\n\t")))


--]]


--x=loadfile("pkServers.lua")
--x()
--dofile("servers.lua")
--x=dofile("c:\Users\Mike Dismore\Dropbox (Voyant Solutions)\XVS Development\Development Versions\Unified Controller\DEV\servers.lua")
--x=dofile("C:\\Users\\Public\\servers.lua")
--x=dofile([[C:\Users\Public\servers.lua]])
--dofile([[c:\path\lib1.lua]])
--pkServers.fnSetServer()
--fnServers=loadfile("servers.lua")
--fnServers()
--print(servers)
--servers.fnSetServer(4)c:\
--x=dofile([[/data/servers.lua]])
--dofile("c:\\Users\\Mike Dismore\\Dropbox (Voyant Solutions)\\XVS Development\\Development Versions\\Unified Controller\\DEV\\LuaTest.lua")

--print(tbObjARC2.tbAI2.PointName)


--{"path": "\\data\\.","size": 0,"attr": 67,"date": "2017-09-14 21:11:54" }, 
--{"path": "\\data\\..","size": 0,"attr": 67,"date": "2017-09-14 21:11:54" }, 
--{"path": "\\data\\trend.csv","size": 53,"attr": 3,"date": "2000-01-02 19:11:30" }, 
--{"path": "\\data\\servers.lua","size": 1171,"attr": 3,"date": "2000-01-02 19:26:28" }, 
--{"path": "\\data\\Config ARC Tool.xlsm","size": 438963,"attr": 3,"date": "2017-07-15 19:25:20" }, 
--{"path": "\\data\\Schedule Calculator.xlsx","size": 10765,"attr": 3,"date": "2016-02-02 23:10:26" }


--set LUA_PATH=?.lua;C:\Program Files\lua\5.1\?.lua;C:\Users\Mike Dismore\Dropbox (Voyant Solutions)\XVS Development\Development Versions\Unified Controller\DEV\?.lua

--[[

os functions
difftime function: 217C3918
remove function: 217C3958
move function: 217C39B8
clock function: 217C3898
time function: 217C39F8
rename function: 217C3978
date function: 217C38D8

io functions
lines function: 217C33E0
write function: 217C3500
close function: 217C3360
flush function: 217C3380
open function: 217C3400
output function: 217C3440
read function: 217C34C0
stderr file (closed)
stdin file (closed)
input function: 217C33A0
stdout file (closed)
type function: 217C34E0
popen function: 217C3480


--]]


-- Need this in a function to create appklpkcation object tables.  Should all the application tables be one table? YES
-- Review master object table to decide how to use SYSTEM and HARDWARE objects
-- Add fields to identify the application (ARC1, ARC2...). This could be done by adding (ARC1, ARC2 to the table name) (tbAV24 is now ARC1_V24)
--dofile("pkUtil.lua")
--Util=loadfile("ssspkUtil.lua")

--dofile("obj.lua")
-- Build this into a single function that builds the string and saves it as a table

--pkUtil.fnCopyTableToFile(tbObj,"TestTable","TestTable.lua","a")

--dofile("TestTable.lua")


--"r" read mode (the default);
--"w" write mode;
--"a" append mode;
--"r+" update mode, all previous data is preserved;
--"w+" update mode, all previous data is erased;
--"a+" append update mode, previous data is preserved, writing is only allowed at the end of file.
--[[

    function serializeOld (o) -- this works
      if type(o) == "number" then
        io.write(o)
      elseif type(o) == "string" then
        io.write(string.format("%q", o))
      elseif type(o) == "table" then
        io.write("{\n")
        for k,v in pairs(o) do
          io.write("  ", k, " = ")
          serialize(v)
          io.write(",\n")
        end
        io.write("}\n")
      else
        error("cannot serialize a " .. type(o))
      end
    end

    function serialize2 (o) -- this works, add brackets
      if type(o) == "number" then
        io.write(o)
      elseif type(o) == "string" then
        io.write(string.format("%q", o))
      elseif type(o) == "table" then
        io.write("{\n")
        for k,v in pairs(o) do
          --io.write("  ", k, " = ")
          io.write("  [")
          serialize(k)
          io.write("] = ")

          serialize(v)
          io.write(",\n")
        end
        io.write("}\n")
      else
        error("cannot serialize a " .. type(o))
      end
    end

    function serialize3 (o) -- changed to build into one line
      -- Save Lua table as file that can be loaded back into program
      if type(o) == "number" then
        io.write(o)
      elseif type(o) == "string" then
        io.write(string.format("%q", o))
      elseif type(o) == "table" then
        --io.write("{\n")
        io.write("{")
        for k,v in pairs(o) do
          --io.write("  ", k, " = ")
          io.write("[")
          serialize(k)
          io.write("]=")

          serialize(v)
          --io.write(",\n")
          io.write(",")
        end
        io.write("}\n")
        --io.write("}")
      else
        error("cannot serialize a " .. type(o))
      end
    end

    function serializeNOPE (o) -- changed to build into one line
      -- Save Lua table as file that can be loaded back into program
      --local lvTable
      if type(o) == "number" then
        lvTable=lvTable..o
      elseif type(o) == "string" then
        lvTable=lvTable..string.format("%q", o)
      elseif type(o) == "table" then
        --io.write("{\n")
        lvTable="{"
        for k,v in pairs(o) do
          --io.write("  ", k, " = ")
          lvTable=lvTable.."  ["
          serialize(k)
          lvTable=lvTable.."] = "

          serialize(v)
          --io.write(",\n")
          lvTable=lvTable..","
        end
        lvTable=lvTable.."}\n"
        --io.write("}")
      else
        error("cannot serialize a " .. type(o))
      end
      --print(lvTable)
    end


     function fnSerializeWorking (lvTable) -- changed to build into a file
      -- Save Lua table as file that can be loaded back into program
      if type(lvTable) == "number" then
        lvCovLog:write(lvTable)
      elseif type(lvTable) == "string" then
        lvCovLog:write(string.format("%q", lvTable))
      elseif type(lvTable) == "table" then
        --io.write("{\n")
        lvCovLog:write("={")
        for k,v in pairs(lvTable) do
          --io.write("  ", k, " = ")
          lvCovLog:write("[")
          fnSerialize(k)
          lvCovLog:write("]=")

          fnSerialize(v)
          --io.write(
          lvCovLog:write(",")
        end
        lvCovLog:write("}\n")
        --io.write("}")
      else
        error("cannot serialize a " .. type(lvTable))
      end
    end
  function fnObjSave(lvTable,lvFile, lvTableName)
    lvCovLog = io.open(lvFile, "w+")
    lvCovLog:write(lvTableName)
    fnSerialize(lvTable)
    lvCovLog:close()
  end



--three file types - .opr  .bak  .upd


-- UPDATE need log file to write to with io.write()




FirmwareOld="2.13.2.11"
FirmwareNew="2.20.1.4" 
ME.CFG1_Firmware_Version.value
--]]

--[[
do
local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end
  os.execute("megaio 0 rwrite 1 on")
  sleep(1)
  os.execute("megaio 0 rwrite 2 on")
  sleep(1)
  os.execute("megaio 0 rwrite 3 on")
  sleep(1)
  os.execute("megaio 0 rwrite 4 on")
  sleep(1)
  os.execute("megaio 0 rwrite 5 on")
  sleep(1)
  os.execute("megaio 0 rwrite 6 on")
  sleep(1)
  os.execute("megaio 0 rwrite 7 on")
  sleep(1)
  os.execute("megaio 0 rwrite 8 on")
  sleep(1)

  os.execute("megaio 0 rwrite 1 off")
  sleep(1)
  os.execute("megaio 0 rwrite 2 off")
  sleep(1)
  os.execute("megaio 0 rwrite 3 off")
  sleep(1)
  os.execute("megaio 0 rwrite 4 off")
  sleep(1)
  os.execute("megaio 0 rwrite 5 off")
  sleep(1)
  os.execute("megaio 0 rwrite 6 off")
  sleep(1)
  os.execute("megaio 0 rwrite 7 off")
  sleep(1)
  os.execute("megaio 0 rwrite 8 off")
end

Push Files to git
1. On your computer, move the file you'd like to upload to GitHub into the local directory that was created when you cloned the repository.

2. Open Git Bash.

3. Change the current working directory to your local repository.

4. Stage the file for commit to your local repository.

$ git add .
# Adds the file to your local repository and stages it for commit. To unstage a file, use 'git reset HEAD YOUR-FILE'.

5. Commit the file that you've staged in your local repository.

$ git commit -m "Add existing file"
# Commits the tracked changes and prepares them to be pushed to a remote repository. To remove this commit and modify the file, use 'git reset --soft HEAD~1' and commit and add the file again.

6. Push the changes in your local repository to GitHub.

$ git push origin your-branch
# Pushes the changes in your local repository up to the remote repository you specified as

megaio -v
megaio -lt
megaio -lw <val>
megaio -lw <lednr> <val>
megaio -warranty
megaio -connector
megaio <id> board

megaio <id> rwrite <channel> <on/off>
megaio <id> rread <channel>
megaio <id> rread

megaio <id> aread <channel>
megaio <id> awrite <value>

megaio <id> optread <channel>
megaio <id> optread

megaio <id> ocread
megaio <id> ocwrite <ch> <on/off; 1/0>
megaio <id> ocwrite <val>

megaio <id> optirqset <channel> <rising/falling/change/none>
megaio <id> optitRead

megaio <id> iodwrite <channel> <in/out> -- For setting type of IO
megaio <id> iodread <channel>
megaio <id> iodread

megaio <id> iowrite <channel> <on/off> -- For reading the IO
megaio <id> ioread <channel>
megaio <id> ioread

megaio <id> ioirqset <channel> <rising/falling/change/none>
megaio <id> ioitread

--megaio <id> test
megaio <id> atest <chNr>
--megaio <id> test-opto-oc <optoCh> <ocCh>
--megaio <id> test-io <ch1> <ch2>
--megaio <id> test-dac-adc <adcCh>
megaio 0 ocwrite 1 off

--]]


dofile("C:\\Users\\miked\\Dropbox (Voyant Solutions)\\XVS Development\\PiDev\\pkPiUtil.lua")


--package.path="./?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;/home/pi/Documents/?.lua;/home/pi/Documents/piDev/?.lua"
--require("pkPiUtil")

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end



--************************2295 CAUSES ERROR!!!!!!!
vAdcResistance,vAdcVoltage=pkPiUtil.fnADCcalc(2018,3.3,10000,4095)
vSpaceTemp,vSpaceTempResistance=pkPiUtil.fnThermLookup(pkPiUtil.tb10KType2, vAdcResistance,40)


print("vAdcResistance = "..vAdcResistance)
print("vAdcVoltage = "..vAdcVoltage)

print("vSpaceTemp = "..vSpaceTemp)
print("vSpaceTempResistance = "..vSpaceTempResistance)

--[[
This is how to calculate the exact temperature

--DiffR = Calculate difference between higher and lower resistance
--Lookup temp for higher resistance and lower resistance
--DiffT = Calculate difference between temperatures
Res = Divide resistance into 20 steps
Temp = Divide temp into 20 steps
Add Res , Temp to a local table
Use fnThermLookup to find nearest resistance from ADC and find on local table


megaio 0 rwrite 1 off
megaio 0 rwrite 2 off
megaio 0 rwrite 3 off
megaio 0 rwrite 4 off
megaio 0 rwrite 5 off
megaio 0 rwrite 6 off
megaio 0 rwrite 7 off
megaio 0 rwrite 8 off

megaio 0 iodread 1
megaio 0 iodread 2
megaio 0 iodread 3
megaio 0 iodread 4
megaio 0 iodread 5
megaio 0 iodread 6

megaio 0 iodwrite 1 out
megaio 0 iodwrite 2 out
megaio 0 iodwrite 3 out
megaio 0 iodwrite 4 out
megaio 0 iodwrite 5 out
megaio 0 iodwrite 6 out

megaio 0 iowrite 1 on
megaio 0 iowrite 2 on
megaio 0 iowrite 3 on
megaio 0 iowrite 4 on
megaio 0 iowrite 5 on
megaio 0 iowrite 6 on

megaio 0 ioread 1
megaio 0 ioread 2
megaio 0 ioread 3
megaio 0 ioread 4
megaio 0 ioread 5
megaio 0 ioread 6


--]]

function fnSleep(n)  -- seconds
  local clock = os.clock  
  local t0 = clock()
  while clock() - t0 <= n do end
end
function fnFlash(io,s,t)
  for x=1,t do
    os.execute("megaio 0 iowrite "..io.." on")
    fnSleep(s)
    os.execute("megaio 0 iowrite "..io.." off")
    fnSleep(s)
  end
end






--var("iDiningLightStatus", "ME.AI4")
--vScheduleState == 1 or vScheduleState == 2 or vScheduleState == 3 then 

--Questions for Meeting
--is this an alarm, error, status?
  -- Alarm = schedule <> status > timeDelay
  -- Error = report the ammount of time schedule <> status
  -- Status = schedule <> status

-- I believe what we're looking for are times greater than X where lights off and schedule on.
  -- just report when schedule <> status.  Analitics/Customer decides on X

-- The alarm code can hide times where the lights are turned on for a brief time and back off.


--it's an error if lights are off and schedule is occ.  Is it also an error if lights are on and schedule is not occ?

--Deleted Points
--var("iOutsideLightLevel", "ME.AI4")
--var("vSensorFailOutsideLightLevel", "ME.BV123")

--New Points
--iDiningLightStatus
--vAlarmOpeningClosingDelay
--vAlarmOpeningClosing


--\XVS Development\MC v45 Release\Upgrade Packages\8-9-2019 MC Upgrade Package.txt

--Delete Light Level Objects
fnDeleteObjects(4, 4, 4, "AI") -- Delete iOutsideLightLevel 
ME.BV123_Object_Name.value="Analog Value 123"
ME.BV123_Description.value=""   
ME.BV123_Present_Value.value=0 --vSensorFailOutsideLightLevel   

--Dining Light Status Objects
var("iDiningLightStatus", "ME.BI4")
var("vAlarmOpeningClosing", "ME.BV132")
var("vAlarmOpeningClosingDelay", "ME.AV134")

fnCreateObject(129,"BI",4,_,95,_,_,"iDiningLightStatus","Dining Lights Status")
fnCreateObject(129,"BV",132,_,95,_,_,"vAlarmOpeningClosing","Opening Closing Alarm")
fnCreateObject(129,"AV",134,_,95,_,_,"vAlarmOpeningClosingDelay","OpeningClosing Alarm Delay")
ME.AV134_Present_Value.value = 0 -- vAlarmOpeningClosing
ME.AV134_Present_Value.value = 5 -- vAlarmOpeningClosingDelay

{PointName = "BI4", Heartbeat = 360, Throttle = 1, ChangeDelta = 0.5, Critical = 1},
{PointName = "BV132", Heartbeat = 360, Throttle = 1, ChangeDelta = 0.5, Critical = 1},

-- Verify new points
print(ME.BI4_Present_Value.value)


-- New Alarm Code
if tbTimers.AlarmOpeningClosing == nil then
    tbTimers.AlarmOpeningClosing = gvOSAdjustedTime
else
  if iDiningLightStatus==1 and vScheduleState==2 then
    tbTimers.AlarmOpeningClosing = gvOSAdjustedTime
    if stable.vAlarmOpeningClosing() > 900 then
      vAlarmOpeningClosing = 0
      tbAct["OpeningClosing alarm inactive"]=1
    end
  elseif ((gvOSAdjustedTime - tbTimers.AlarmOpeningClosing) / 60) >= vAlarmOpeningClosingDelay then
        vAlarmOpeningClosing = 1
        tbAct["OpeningClosing alarm active"]=1
    end
end


var("vDoorAjarShutdownActive", "ME.BV205")
Door Ajar Shutdown Delay
Door Ajar Restart Delay
Door Ajar Action (0 None, 1 Alarm Only, 2 Shutdown Only, 3 Alarm and Shutdown)
